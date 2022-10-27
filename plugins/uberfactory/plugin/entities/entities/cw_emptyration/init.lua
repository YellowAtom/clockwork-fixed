--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/weapons/w_packatc.mdl");
	
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetHealth(25);
	self:SetSolid(SOLID_VPHYSICS);
	
	self:SetDTBool(1,false);
	self:SetDTBool(2,false);
	self:SetDTBool(3,false);
	
	
	self.breens_water = Clockwork.item:FindByID("breens_water");
	self.citizen_supplements = Clockwork.item:FindByID("citizen_supplements");
	
	local physicsObject = self:GetPhysicsObject();
	
	if ( IsValid(physicsObject) ) then
		physicsObject:Wake();
		physicsObject:EnableMotion(true);
	end;
end;

function ENT:Explode()
	local effectData = EffectData();
	
	effectData:SetStart( self:GetPos() );
	effectData:SetOrigin( self:GetPos() );
	effectData:SetScale(8);
	
	util.Effect("GlassImpact", effectData, true, true);
	
	self:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav");
end;

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;

function ENT:OnTakeDamage(damageInfo)
	self:SetHealth( math.max(self:Health() - damageInfo:GetDamage(), 0) );
	
	if (self:Health() <= 0) then
		self:Explode(); self:Remove();
	end;
end;

function ENT:Think()
	if (!self:GetDTBool(2) or !self:GetDTBool(1)) then
		for k, v in ipairs( ents.FindInSphere(self:GetPos(),15) ) do
			if v:IsValid() && v:GetClass() == "cw_item" then
				local index = v:GetDTInt(0);
				
				if (index != 0) then	
					local findedItem = Clockwork.item:FindByID(index);
					
					if (findedItem == self.citizen_supplements or findedItem == self.breens_water) then
						if (findedItem == self.citizen_supplements) then
							if (!self:GetDTBool(2)) then
								self:SetDTBool(2, true);
								v:Remove();
								self:EmitSound("items/medshot4.wav");
							end;
						else
							if (!self:GetDTBool(1)) then
								self:SetDTBool(1, true);
								v:Remove();
								self:EmitSound("items/medshot4.wav");
							end;
						end;
						
						self:CheckFull();
					end;
				end;
			end;
		end;
	end;
end;

function ENT:CheckFull()
	if (self:GetDTBool(2) and self:GetDTBool(1)) then
		self:SetDTBool(3, true);
	end;
end;