--[[
	© 2016 TeslaCloud Studios.
	Private code for Global Cooldown community.
	Stealing Lua cache is not nice lol.
	get a life kiddos.
--]]

local ITEM = Clockwork.item:New(nil, true)
	ITEM.name 			= "Bodygroup Base"
	ITEM.model 			= "models/tnb/items/shirt_citizen1.mdl"
	ITEM.skin 			= 1
	ITEM.weight 		= 1
	ITEM.useText 		= "Wear"
	ITEM.category 		= "Clothing"
	ITEM.description 	= "Default Bodygroup Clothing Item."
	ITEM.bodyGroup 		= -1
	ITEM.bodyGroupVal 	= -1
	ITEM.requiredBG		= {-1, -1}
	ITEM.isCombine		= false
	ITEM.protection		= 0

	function ITEM:SetBodygroup(player, bg, val)
		if (bg <= player:GetNumBodyGroups()) then
			player:SetBodygroup(bg, val)

			return true
		else
			Clockwork.player:Notify(player, "You cannot wear this!")

			return false
		end
	end

	function ITEM:ResetBodygroup(player, bg)
		player:SetBodygroup(bg, 0)
		return true
	end

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		local clothesData = player.bgClothesData or {}

		if (self.requiredBG[1] != -1) then
			local bgData = clothesData[self.requiredBG[1]]
			if (!bgData) then
				Clockwork.player:Notify(player, "You cannot wear this!")
				return false
			end
		end

		if (self.bodyGroup != -1) then
			if (player:Alive() and !player:IsRagdolled()) then
				player:SetBodygroupClothes(self)
				return true
			end
		else
			Clockwork.player:Notify(player, "You cannot wear this!")

			return false
		end
	end

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position)
		if (self:HasPlayerEquipped(player) and self.bodyGroup != -1) then
			player:SetBodygroupClothes(self, true)
		end

		return true
	end

	-- Called when a player attempts to sell the item to salesman.
	function ITEM:CanSell(player)
		if (self:HasPlayerEquipped(player) and self.bodyGroup != -1) then
			player:SetBodygroupClothes(self, true)
		end

		return true
	end

	-- Called when a player attempts to give the item to storage.
	function ITEM:CanGiveStorage(player, storageTable)
		if (self:HasPlayerEquipped(player) and self.bodyGroup != -1) then
			player:SetBodygroupClothes(self, true)
		end

		return true
	end

	-- Called when a player changes clothes.
	function ITEM:OnChangeClothes(player, bIsWearing)
		if (bIsWearing) then
			self:SetBodygroup(player, self.bodyGroup, self.bodyGroupVal)
		else
			self:ResetBodygroup(player, self.bodyGroup)
		end

		if (self.OnChangedClothes) then
			self:OnChangedClothes(player, bIsWearing)
		end
	end

	-- Called to get whether a player has the item equipped.
	function ITEM:HasPlayerEquipped(player, bIsValidWeapon)
		local clothesData = player.bgClothesData or {}

		if (CLIENT) then
			clothesData = Clockwork.Client.bgClothesData or {}
		end

		local bg = self.bodyGroup

		if (clothesData[bg] and clothesData[bg].val != nil and clothesData[bg].itemID == self.uniqueID.." "..self.itemID) then
			return true
		end

		return false
	end

	-- Called when a player has unequipped the item.
	function ITEM:OnPlayerUnequipped(player, extraData)
		player:SetBodygroupClothes(self, true)
	end
	
ITEM:Register();