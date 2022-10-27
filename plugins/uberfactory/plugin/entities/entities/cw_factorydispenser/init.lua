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
	self.tube:SetAngles( self:GetAngles() + Angle(0,90,0));
	self.tube:SetParent(self);
	self.tube:SetModel("models/mechanics/solid_steel/box_beam_4.mdl");
	self.tube:SetMaterial("models/props_pipes/GutterMetal01a");
	self.tube:SetPos( self:GetPos() + Vector(-16,0,-6));
	self.tube:Spawn();

	self:DeleteOnRemove(self.tube);
		
	self:SetCollisionGroup(COLLISION_GROUP_WORLD);
	
	local phys = self:GetPhysicsObject()
	phys:SetMass( 120 )
	
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
			
			self.nextUse = curTime + 5;
		else
			self:EmitSound("buttons/button11.wav");
		end;
	end;
end;

function ENT:SpawnItem(activator)
	if (self:GetSpawnType() == TYPE_WATERCAN) then
		Clockwork.entity:CreateItem( activator, "breens_water", self.tube:GetPos());
	else
		Clockwork.entity:CreateItem( activator, "citizen_supplements", self:GetPos());
	end;
end;

function ENT:CanTool(player, trace, tool)
	return false;
end;