
DEFINE_BASECLASS("base_gmodentity")

ENT.Type = "anim"
ENT.Author = "kurozael"
ENT.PrintName = "Item"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.UsableInVehicle = true

-- Called when the data tables are setup.
function ENT:SetupDataTables()
	self:DTVar("Int", 0, "Index")
end

-- A function to get the entity's item table.
function ENT:GetItemTable()
	return self.cwItemTable or Clockwork.entity:FetchItemTable(self)
end

-- A function to set the entity's item table.
function ENT:SetItemTable(itemTable)
	self.cwItemTable = itemTable
end
