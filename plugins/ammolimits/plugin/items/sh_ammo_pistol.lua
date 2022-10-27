--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]
local ITEM = Clockwork.item:New("ammo_base")
ITEM.name = "9mm Pistol Bullets"
ITEM.cost = 30
--ITEM.classes = {CLASS_EMP, CLASS_EOW}
ITEM.model = "models/items/boxsrounds.mdl"
ITEM.weight = 1
ITEM.access = "V"
ITEM.uniqueID = "ammo_pistol"
ITEM.business = true
ITEM.batch = 2;
ITEM.ammoClass = "pistol"
ITEM.ammoAmount = 20
ITEM.description = "A container filled with bullets and 9mm printed on the side."

function ITEM:CanPickup(player)
	if (player:HasItemByID(self.uniqueID) and table.Count(player:GetItemsByID(self.uniqueID)) >= 5) then
		player:Notify("You are carrying too many boxes of " .. ITEM.name .. "!")

		return false
	end
end

function ITEM:OnUse(player, itemEntity)
	local ammocount = player:GetAmmoCount(ITEM.ammoClass)

	if ammocount >= 150 then
		player:Notify("You are carrying too many magazines!")

		return false
	end

	local secondaryAmmoClass = self("secondaryAmmoClass")
	local primaryAmmoClass = self("primaryAmmoClass")
	local ammoAmount = self("ammoAmount")
	local ammoClass = self("ammoClass")

	for k, v in pairs(player:GetWeapons()) do
		local itemTable = Clockwork.item:GetByWeapon(v)

		if (itemTable and (itemTable.primaryAmmoClass == ammoClass or itemTable.secondaryAmmoClass == ammoClass)) then
			player:GiveAmmo(ammoAmount, ammoClass)

			return
		end
	end

	Clockwork.player:Notify(player, "You need to equip a weapon that uses this ammunition!")

	return false
end

ITEM:Register()