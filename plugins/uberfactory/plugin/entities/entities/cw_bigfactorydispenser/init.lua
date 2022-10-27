--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/maxofs2d/button_06.mdl");
	
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetSolid(SOLID_VPHYSICS);
	
	self.tube = ents.Create("prop_dynamic");
	self.tube:DrawShadow(false);
	self.tube:SetAngles( self:GetAngles() + Angle(90,0,0));
	self.tube:SetParent(self);
	self.tube:SetModel("models/props_phx/construct/metal_tube.mdl");
	self.tube:SetMaterial("models/props_pipes/GutterMetal01a");
	self.tube:SetPos( self:GetPos() + Vector(-40,0,-20));
	self.tube:Spawn();
	
	self.tube2 = ents.Create("prop_dynamic");
	self.tube2:DrawShadow(false);
	self.tube2:SetAngles( self:GetAngles() + Angle(90,0,0));
	self.tube2:SetParent(self);
	self.tube2:SetModel("models/props_phx/construct/metal_tube.mdl");
	self.tube2:SetMaterial("models/props_pipes/GutterMetal01a");
	self.tube2:SetPos( self:GetPos() + Vector(-87,0,-20));
	self.tube2:Spawn();

	self:DeleteOnRemove(self.tube);
	
	local phys = self:GetPhysicsObject()
	phys:SetMass( 120 )
		
	self:SetCollisionGroup(COLLISION_GROUP_WORLD);
	
	self.timeStep = 8;
	
	self:SetSpawnType(1);
end;

function ENT:SetSpawnType(entType)
	if (entType == TYPE_WATERCAN or entType == TYPE_SUPPLIES) then
		self:SetDTInt(1,entType);
	end;
end;

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;

function ENT:EmitRandomSound()
	local randomSounds = {
		"ambient/machines/combine_terminal_idle2.wav",
		"buttons/button4.wav"
	};
	
	self:EmitSound( randomSounds[ math.random(1, #randomSounds) ] );
end;

function ENT:PhysicsUpdate(physicsObject)
	if (!self:IsPlayerHolding() and !self:IsConstrained()) then
		physicsObject:SetVelocity( Vector(0, 0, 0) );
		physicsObject:Sleep();
	end;
end;

function ENT:Use(activator, caller)
	if (activator:IsPlayer() and activator:GetEyeTraceNoCursor().Entity == self) then
		local curTime = CurTime();
		
		if (!self.nextUse or curTime >= self.nextUse) then
			self:EmitRandomSound();
			
			self:SpawnItem(activator);
			
			self.nextUse = curTime + self.timeStep;
		else
			self:EmitSound("buttons/button11.wav");
		end;
	end;
end;

function ENT:SpawnItem(activator)
	if (self:GetSpawnType() == TYPE_WATERCAN) then
		local entity = ents.Create("cw_emptyration");
		
		self.timeStep = 8;
		entity:SetPos(self.tube:GetPos());
		entity:Spawn();
	else
		local entity = ents.Create("cw_emptycrate");
		
		self.timeStep = 60;
		entity:SetPos(self.tube:GetPos()-Vector(0,0,-20));
		entity:Spawn();
	end;
end;

function ENT:CanTool(player, trace, tool)
	return false;
end;