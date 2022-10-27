DEFINE_BASECLASS("base_gmodentity");

ENT.Type = "anim";
ENT.Author = "Blt950";
ENT.PrintName = "Flood Light";
ENT.Spawnable = false;
ENT.AdminSpawnable = false;

function ENT:SetupDataTables()
	self:DTVar("Int", 0, "State");
end;