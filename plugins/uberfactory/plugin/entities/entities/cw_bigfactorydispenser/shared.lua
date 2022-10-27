--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

DEFINE_BASECLASS("base_gmodentity");

TYPE_WATERCAN = 0;
TYPE_SUPPLIES = 1;

ENT.Type = "anim";
ENT.Author = "ExT";
ENT.PrintName = "Factory Dispenser";
ENT.Spawnable = false;
ENT.AdminSpawnable = false;
ENT.PhysgunDisabled = true;

function ENT:SetupDataTables()
	self:DTVar("Int", 0, "index");
	self:DTVar("Int", 1, "Type");
end;

function ENT:GetSpawnType()
	return self:GetDTInt(1);
end;