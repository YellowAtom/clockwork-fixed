
local weaponMeta = FindMetaTable("Weapon")

weaponMeta.OldGetPrintName = weaponMeta.OldGetPrintName or weaponMeta.GetPrintName

-- A function to get a weapon's print name.
function weaponMeta:GetPrintName()
	local itemTable = Clockwork.item:GetByWeapon(self)

	if itemTable then
		return L(itemTable("name"))
	else
		return self:OldGetPrintName()
	end
end
