--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/Items/item_item_crate.mdl");
	
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetHealth(50);
	self:SetSolid(SOLID_VPHYSICS);
	
	self:SetDTInt(1,0);
	self:SetDTBool(2,false);
	
	
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
	for k, v in ipairs( ents.FindInSphere(self:GetPos(),25) ) do
		if v:IsValid() && v:GetClass() == "cw_emptyration" then
			--print("HERE!!")
		
			if (v:GetDTBool(2) and v:GetDTBool(1)) then
				print("1")
				v:Remove();
				self:EmitSound("items/medshot4.wav");
				self:SetDTInt(1, self:GetDTInt(1) + 1);
				print("2")
				if (self:GetDTInt(1) >= 10) then
					Clockwork.entity:CreateShipment(nil,"ration",10,self:GetPos(),self:GetAngles());
					self:Remove();
				end;
			end;
		end;
	end;
end;

function ENT:CheckFull()
	if (self:GetDTInt(1) >= 10) then
		self:SetDTBool(2, true);
	end;
end;