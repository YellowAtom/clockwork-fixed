--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");
	ITEM.name = "Pulse-Rifle Energy";
	ITEM.cost = 80;
	--ITEM.classes = {CLASS_EOW};
	ITEM.model = "models/items/combine_rifle_cartridge01.mdl";
	ITEM.plural = "Pulse-Rifle Energy";
	ITEM.weight = 1;
	ITEM.uniqueID = "ammo_ar2";
	ITEM.business = true;
	ITEM.access = "V";
	ITEM.ammoClass = "ar2";
	ITEM.ammoAmount = 30;
	ITEM.description = "A cartridge with a blue glow emitting from it.";
		function ITEM:CanPickup(player)
	if (player:HasItemByID(self.uniqueID) and table.Count(player:GetItemsByID(self.uniqueID)) >= 5) then
		player:Notify("You are carrying too many boxes of " .. ITEM.name .. "!")

		return false
	end
end

function ITEM:OnUse(player, itemEntity)
	local ammocount = player:GetAmmoCount(ITEM.ammoClass)

	if ammocount >= 90 then
		player:Notify("You are carrying too many cartridges!")

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
ITEM:Register();