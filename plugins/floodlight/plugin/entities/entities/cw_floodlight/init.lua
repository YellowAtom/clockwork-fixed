include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/props_c17/light_floodlight02_off.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	local phys = self:GetPhysicsObject();

	if phys:IsValid() then
		phys:Wake();
	end;
end;

-- Called when the entity is spawned.
function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return; end;
	local ent = ents.Create("cw_floodlight");
	ent:SetPos(tr.HitPos + tr.HitNormal * 16);
	ent:Spawn();
	ent:Activate();

	return ent;
end;

function ENT:OnRemove()
end;

function ENT:Think()
end;

function ENT:Use()
	if ((self.nextUse or 0) < CurTime()) then
		self.nextUse = CurTime() + 1;

		if (self:GetDTInt(0) == 0) then
			self:SetDTInt(0, 1);
		else
			self:SetDTInt(0, 0);
		end;

		self:EmitSound("buttons/lightswitch2.wav");
	end;
end