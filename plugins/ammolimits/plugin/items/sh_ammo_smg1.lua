--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");
	ITEM.name = "SMG Bullets";
	ITEM.cost = 45;
	--ITEM.classes = {CLASS_EMP, CLASS_EOW};
	ITEM.model = "models/items/boxmrounds.mdl";
	ITEM.weight = 2;
	ITEM.access = "V";
	ITEM.uniqueID = "ammo_smg1";
	ITEM.business = true;
	ITEM.batch = 2;
	ITEM.ammoClass = "smg1";
	ITEM.ammoAmount = 30;
	ITEM.description = "A heavy container filled with a lot of bullets.";
	function ITEM:CanPickup(player)
	if (player:HasItemByID(self.uniqueID) and table.Count(player:GetItemsByID(self.uniqueID)) >= 5) then
		player:Notify("You are carrying too many boxes of " .. ITEM.name .. "!")

		return false
	end
end

function ITEM:OnUse(player, itemEntity)
	local ammocount = player:GetAmmoCount(ITEM.ammoClass)

	if ammocount >= 255 then
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
ITEM:Register();