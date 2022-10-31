DEFINE_BASECLASS("base_gmodentity")

ENT.Type = "anim"
ENT.Author = "kurozael"
ENT.PrintName = "Cash"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.UsableInVehicle = true

-- Called when the data tables are setup.
function ENT:SetupDataTables()
	self:DTVar("Int", 0, "Amount")
end
