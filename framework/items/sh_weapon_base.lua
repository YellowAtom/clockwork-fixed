local Clockwork = Clockwork

local ITEM = Clockwork.item:New(nil, true)

ITEM.name = "Weapon Base"
ITEM.useText = "Equip"
ITEM.useSound = "items/ammo_pickup.wav"
ITEM.category = "Weapons"
ITEM.useInVehicle = false

local defaultWeapons = {
	["weapon_357"] = {"357", nil, true},
	["weapon_ar2"] = {"ar2", "ar2altfire", 30},
	["weapon_rpg"] = {"rpg_round", nil, 3},
	["weapon_smg1"] = {"smg1", "smg1_grenade", true},
	["weapon_slam"] = {"slam", nil, 2},
	["weapon_frag"] = {"grenade", nil, 1},
	["weapon_pistol"] = {"pistol", nil, true},
	["weapon_shotgun"] = {"buckshot", nil, true},
	["weapon_crossbow"] = {"xbowbolt", nil, 4}
}

ITEM:AddData("ClipOne", 0, true)
ITEM:AddData("ClipTwo", 0, true)

-- Called whent he item entity's menu options are needed.
function ITEM:GetEntityMenuOptions(entity, options)
	if self:HasSecondaryClip() or self:HasPrimaryClip() then
		local informationColor = Clockwork.option:GetColor("information")
		local toolTip = Clockwork.kernel:AddMarkupLine("", "Salvage any ammo from this weapon.", informationColor)
		local clipOne = self:GetData("ClipOne")
		local clipTwo = self:GetData("ClipTwo")

		if clipOne > 0 or clipTwo > 0 then
			if clipOne > 0 then
				toolTip = Clockwork.kernel:AddMarkupLine(toolTip, "Primary: " .. clipOne)
			end

			if clipTwo > 0 then
				toolTip = Clockwork.kernel:AddMarkupLine(toolTip, "Secondary: " .. clipTwo)
			end

			options["Ammo"] = {
				isArgTable = true,
				arguments = "cwItemAmmo",
				toolTip = toolTip
			}
		end
	end
end

-- Called to get whether a player has the item equipped.
function ITEM:HasPlayerEquipped(player, bIsValidWeapon)
	local weaponClass = self("weaponClass")
	local weapon = player:GetWeapon(weaponClass)
	local itemTable = Clockwork.item:GetByWeapon(weapon)
	if itemTable and itemTable:IsTheSameAs(self) then return true end

	return false
end

-- Called when a player attempts to pick up the item.
function ITEM:CanPickup(player, quickUse, itemEntity)
	if (quickUse) then
		if (!player:CanHoldWeight(self.weight)) then
			Clockwork.player:Notify(player, "You do not have enough inventory space!");
			
			return false;
		end;
	end;
end;

-- Called when a player attempts to holster the weapon.
function ITEM:CanHolsterWeapon(player, forceHolster, bNoMsg)
	return true
end

-- Called when the unequip should be handled.
function ITEM:OnHandleUnequip(Callback)
	if self.OnDrop then
		local menu = DermaMenu()
		menu:SetMinimumWidth(100)

		menu:AddOption(L("Holster"), function()
			Callback()
		end)

		menu:AddOption(L("Drop"), function()
			Callback("drop")
		end)

		menu:Open()
	else
		Callback()
	end
end

-- Called when a player has unequipped the item.
function ITEM:OnPlayerUnequipped(player, extraData)
	local weapon = player:GetWeapon(self("weaponClass"))
	if not IsValid(weapon) then return end
	local itemTable = Clockwork.item:GetByWeapon(weapon)

	if itemTable:IsTheSameAs(self) then
		local class = weapon:GetClass()

		if extraData ~= "drop" then
			if Clockwork.plugin:Call("PlayerCanHolsterWeapon", player, self, weapon) then
				if player:GiveItem(self) then
					Clockwork.plugin:Call("PlayerHolsterWeapon", player, self, weapon)
					player:StripWeapon(class)
					player:SelectWeapon("cw_hands")
				end
			end
		elseif Clockwork.plugin:Call("PlayerCanDropWeapon", player, self, weapon) then
			local trace = player:GetEyeTraceNoCursor()

			if player:GetShootPos():Distance(trace.HitPos) <= 192 then
				local entity = Clockwork.entity:CreateItem(player, self, trace.HitPos)

				if IsValid(entity) then
					Clockwork.entity:MakeFlushToGround(entity, trace.HitPos, trace.HitNormal)
					Clockwork.plugin:Call("PlayerDropWeapon", player, self, entity, weapon)
					player:TakeItem(self, true)
					player:StripWeapon(class)
					player:SelectWeapon("cw_hands")
				end
			else
				Clockwork.player:Notify(player, {"CannotDropWeaponFar"})
			end
		end
	end
end

-- A function to get whether the item has a secondary clip.
function ITEM:HasSecondaryClip()
	return not self("hasNoSecondaryClip")
end

-- A function to get whether the item has a primary clip.
function ITEM:HasPrimaryClip()
	return not self("hasNoPrimaryClip")
end

-- A function to get whether the item is a throwable weapon.
function ITEM:IsThrowableWeapon()
	return self("isThrowableWeapon")
end

-- A function to get whether the item is a fake weapon.
function ITEM:IsFakeWeapon()
	return self("isFakeWeapon")
end

-- A function to get whether the item is a melee weapon.
function ITEM:IsMeleeWeapon()
	return self("isMeleeWeapon")
end

-- A function to get whether the item is a melee weapon.
function ITEM:IsPrimaryWeapon()
	return self("isPrimaryWeapon")
end

-- A function to get whether the item is a melee weapon.
function ITEM:IsSecondaryWeapon()
	return self("isSecondaryWeapon")
end

-- Called when the item is given to a player as a weapon.
function ITEM:OnWeaponGiven(player, weapon)
	Clockwork.player:StripDefaultAmmo(player, weapon, self)
	local clipOne = self:GetData("ClipOne")
	local clipTwo = self:GetData("ClipTwo")

	if clipOne > 0 then
		weapon:SetClip1(clipOne)
	end

	if clipTwo > 0 then
		weapon:SetClip2(clipTwo)
	end
end

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	local weaponClass = self("weaponClass")

	if not player:HasWeapon(weaponClass) then
		player:Give(weaponClass, self)
		local weapon = player:GetWeapon(weaponClass)

		if IsValid(weapon) then
			if self.OnEquip then
				self:OnEquip(player)
			end

			player:RebuildInventory()
		else
			return false
		end
	else
		local weapon = player:GetWeapon(weaponClass)

		if IsValid(weapon) and self.OnAlreadyHas then
			if Clockwork.item:GetByWeapon(weapon) == self then
				self:OnAlreadyHas(player)
			end
		end

		return false
	end
end

-- Called when a player drops the item.
function ITEM:OnDrop(player, position)
end

-- Called when the item should be setup.
function ITEM:OnSetup()
	if not self("weaponClass") then
		self:Override("weaponClass", self("uniqueID"))
	end

	self:Override("weaponClass", string.lower(self("weaponClass")))

	timer.Simple(2, function()
		local weaponClass = self("weaponClass")
		local weaponTable = weapons.GetStored(weaponClass)

		if weaponTable then
			if not self("primaryAmmoClass") then
				if weaponTable.Primary and weaponTable.Primary.Ammo then
					self:Override("primaryAmmoClass", weaponTable.Primary.Ammo)
				end
			end

			if not self("secondaryAmmoClass") then
				if weaponTable.Secondary and weaponTable.Secondary.Ammo then
					self:Override("secondaryAmmoClass", weaponTable.Secondary.Ammo)
				end
			end

			if not self("primaryDefaultAmmo") then
				if weaponTable.Primary and weaponTable.Primary.DefaultClip then
					if weaponTable.Primary.DefaultClip > 0 then
						if weaponTable.Primary.ClipSize == -1 then
							self:Override("primaryDefaultAmmo", weaponTable.Primary.DefaultClip)
							self:Override("hasNoPrimaryClip", true)
						else
							self:Override("primaryDefaultAmmo", true)
						end
					end
				end
			end

			if not self("secondaryDefaultAmmo") then
				if weaponTable.Secondary and weaponTable.Secondary.DefaultClip then
					if weaponTable.Secondary.DefaultClip > 0 then
						if weaponTable.Secondary.ClipSize == -1 then
							self:Override("secondaryDefaultAmmo", weaponTable.Secondary.DefaultClip)
							self:Override("hasNoSecondaryClip", true)
						else
							self:Override("secondaryDefaultAmmo", true)
						end
					end
				end
			end
		elseif defaultWeapons[weaponClass] then
			if not self("primaryAmmoClass") then
				self:Override("primaryAmmoClass", defaultWeapons[weaponClass][1])
			end

			if not self("secondaryAmmoClass") then
				self:Override("secondaryAmmoClass", defaultWeapons[weaponClass][2])
			end

			if not self("primaryDefaultAmmo") then
				self:Override("primaryDefaultAmmo", defaultWeapons[weaponClass][3])
			end

			if not self("secondaryDefaultAmmo") then
				self:Override("secondaryDefaultAmmo", defaultWeapons[weaponClass][4])
			end
		end
	end)
end

-- Called when a player holsters the item.
function ITEM:OnHolster(player, bForced)
end

if CLIENT then
	function ITEM:GetClientSideInfo()
		if not self:IsInstance() then return end
		local clientSideInfo = ""
		local clipOne = self:GetData("ClipOne")
		local clipTwo = self:GetData("ClipTwo")
		local ammoClass = self("primaryAmmoClass")
		local ammoClassSecondary = self("secondaryAmmoClass")
local ammoTypes = {
    ["nil"] = "N/A",
	[""] = "N/A",
    ["ar2"] = "Pulse",
    ["ar2altfire"] = "Pulse Orbs",
    ["pistol"] = "Pistol",
    ["smg1"] = "SMG",
    ["357"] = "357",
    ["357"] = "Magnum",
    ["xbowbolt"] = "Crossbow Bolts",
    ["buckshot"] = "Shotgun Shells",
    ["rpg_round"] = "Rockets",
    ["smg1_grenade"] = "Thumper Grenade",
    ["grenade"] = "Grenades",
    ["slam"] = "SLAMs",
    ["alyxgun"] = "Rifle", -- rifle
    ["sniperround"] = "Darts", -- darts
    ["sniperpenetratedround"] = "Sniper", -- sniper
    ["combinecannon"] = "Flares", -- flares
	["thumper"] = "Thumper",
	["gravity"] = "Gravity",
	["battery"] = "Battery",
	["gaussenergy"] = "Gauss Energy",
	["airboatgun"] = "BBs",
	["striderminigun"] = "Magnum",
	["helicoptergun"] = "Helicopter",
	["9mmround"] = "9mm Rounds",
	["357round"] = "357 Rounds",
	["buckshothl1"] = "Buckshot",
	["xbowbolthl1"] = "Crossbow",
	["mp5_grenade"] = "MP5 Grenade",
	["rpg_rocket"] = "RPG",
	["uranium"] = "Uranium",
	["grenadehl1"] = "Granada",
	["hornet"] = "Hornet",
	["snark"] = "Snark",
	["tripmine"] = "Tripmine",
	["satchel"] = "Satchel Charge",
	["12mmround"] = "Turret",
	["striderminigundirect"] = "Strider",
	["combineheavycannon"] = "Combine Cannon",
}
		
		if self("isPrimaryWeapon") == true then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, L("Weapon Slot: Primary"))
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, L("Ammo Type: "..ammoTypes[ammoClass]..""))
		end
		
		if self("isSecondaryWeapon") == true then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, L("Weapon Slot: Secondary"))
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, L("Ammo Type: "..ammoTypes[ammoClass]..""))
		end
		
		if self("isMeleeWeapon") == true then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, L("Weapon Slot: Melee"))
		end
		
		if self("isThrowableWeapon") == true then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, L("Weapon Slot: Throwable"))
		end
		
		if clipOne > 0 then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, L("ItemInfoClipOne", clipOne))
		end

		if clipTwo > 0 then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, L("ItemInfoClipTwo", clipTwo))
		end

		return clientSideInfo ~= "" and clientSideInfo
	end
end

Clockwork.item:Register(ITEM)
