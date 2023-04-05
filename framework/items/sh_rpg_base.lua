local Clockwork = Clockwork

local ITEM = Clockwork.item:New("weapon_base", true)

ITEM.name = "RPG Base"
ITEM.category = "Weapons";
ITEM.isThrowableWeapon = false

-- Called when a player equips the item.
function ITEM:OnEquip(player)
	 player:SetAmmo(1, "RPG_Round")
end

-- Called when a player holsters the item.
function ITEM:OnHolster(player, bForced)
	Clockwork.player:TakeSpawnAmmo(player, "RPG_Round", 1)
end

-- Called when a player attempts to drop the weapon.
function ITEM:CanDropWeapon(player, attacker, bNoMsg)
	if player:GetAmmoCount("RPG_Round") == 0 then
		player:StripWeapon(self("weaponClass"))
		player:TakeItem(self, true)
		player:GiveItem(Clockwork.item:CreateInstance("Depleted NLAW"), true)
		return false
	else
		return true
	end
end

-- Called when a player attempts to holster the weapon.
function ITEM:CanHolsterWeapon(player, forceHolster, bNoMsg)
	if player:GetAmmoCount("RPG_Round") == 0 then
		player:StripWeapon(self("weaponClass"))
		player:GiveItem(Clockwork.item:CreateInstance("Depleted NLAW"), true)
		return false
	else
		return true
	end
end

Clockwork.item:Register(ITEM)
