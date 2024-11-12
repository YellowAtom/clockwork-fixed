
Clockwork.datastream:Hook("SalesmanDone", function(player, data)
	if IsValid(data) and data:GetClass() == "cw_salesman" then
		data:TalkToPlayer(player, data.cwTextTab.doneBusiness, "Thanks for doing business, see you soon!")
	end
end)

Clockwork.datastream:Hook("Salesmenu", function(player, data)
	if data.entity:GetClass() == "cw_salesman" then
		if player:GetPos():Distance(data.entity:GetPos()) < 196 then
			local itemTable = Clockwork.item:FindByID(data.uniqueID)
			local itemUniqueID = itemTable("uniqueID")

			if data.tradeType == "Sells" and not itemTable("isBaseItem") and data.entity.cwSellTab[data.uniqueID] then
				if data.entity.cwStock[itemUniqueID] == 0 then
					data.entity:TalkToPlayer(player, data.entity.cwTextTab.noStock, "I do not have that item in stock!")

					return
				end

				local amount = 1
				local cost = itemTable("cost")

				if type(data.entity.cwSellTab[itemUniqueID]) == "number" then
					cost = data.entity.cwSellTab[itemUniqueID]
				end

				if data.entity.cwPriceScale then
					cost = cost * data.entity.cwPriceScale
				end

				if data.entity.cwBuyInShipments then
					amount = itemTable("batch")
				end

				if not player:CanHoldWeight(itemTable("weight") * amount) then
					Clockwork.player:Notify(player, "You do not have enough inventory space!")

					return
				end

				if Clockwork.player:CanAfford(player, cost * amount) then
					if itemTable.CanOrder and itemTable:CanOrder(player, v) == false then return end

					if player:CanHoldWeight(itemTable("weight") * amount) then
						for i = 1, amount do
							player:GiveItem(Clockwork.item:CreateInstance(itemUniqueID))
						end

						if amount > 1 then
							Clockwork.player:GiveCash(player, -(cost * amount), amount .. " " .. Clockwork.kernel:Pluralize(itemTable("name")))
							Clockwork.player:Notify(player, "You have purchased " .. amount .. " " .. Clockwork.kernel:Pluralize(itemTable("name")) .. " from " .. data.entity:GetNWString("Name") .. ".")
							Clockwork.kernel:PrintLog(LOGTYPE_MAJOR, player:Name() .. " has purchased " .. amount .. " " .. Clockwork.kernel:Pluralize(itemTable("name")) .. " from " .. data.entity:GetNWString("Name") .. " leaving them with " .. player:GetCash() .. " tokens.") -- Edited By TrulyDivined
						else
							Clockwork.player:GiveCash(player, -(cost * amount), amount .. " " .. itemTable("name"))
							Clockwork.player:Notify(player, "You have purchased " .. amount .. " " .. itemTable("name") .. " from " .. data.entity:GetNWString("Name") .. ".")
							Clockwork.kernel:PrintLog(LOGTYPE_MAJOR, player:Name() .. " has purchased " .. amount .. " " .. itemTable("name") .. " from " .. data.entity:GetNWString("Name") .. " leaving them with " .. player:GetCash() .. " tokens.") -- Edited By TrulyDivined
						end

						data.entity.cwCash = data.entity.cwCash + cost
						Clockwork.datastream:Start(player, "SalesmenuRebuild", data.entity.cwCash)

						if data.entity.cwStock[itemUniqueID] then
							data.entity.cwStock[itemUniqueID] = data.entity.cwStock[itemUniqueID] - 1
						end
					end
				else
					local cashRequired = cost * amount - player:GetCash()
					data.entity:TalkToPlayer(player, data.entity.cwTextTab.needMore, "You need another " .. Clockwork.kernel:FormatCash(math.floor(cashRequired, nil, true)) .. "!")
				end
			elseif data.tradeType == "Buys" and not itemTable("isBaseItem") and data.entity.cwBuyTab[itemUniqueID] then
				local itemTable = player:FindItemByID(data.uniqueID, data.itemID)

				if itemTable then
					local cost = itemTable("cost")

					if type(data.entity.cwBuyTab[itemUniqueID]) == "number" then
						cost = data.entity.cwBuyTab[itemUniqueID]
					end

					if data.entity.cwBuyRate then
						cost = cost * (data.entity.cwBuyRate / 100)
					end

					if data.entity.cwCash == -1 or data.entity.cwCash >= cost then
						if player:TakeItem(itemTable) then
							if data.entity.cwCash ~= -1 then
								data.entity.cwCash = data.entity.cwCash - cost
							end

							Clockwork.player:GiveCash(player, cost, "1 " .. itemTable("name"))
							Clockwork.player:Notify(player, "You have sold 1 " .. itemTable("name") .. " to " .. data.entity:GetNWString("Name") .. ".")
							Clockwork.kernel:PrintLog(LOGTYPE_MAJOR, player:Name() .. " has sold 1 " .. itemTable("name") .. " to " .. data.entity:GetNWString("Name") .. " leaving them with " .. player:GetCash() .. " tokens.") -- Edited By TrulyDivined remove if necessary		
						end
					else
						data.entity:TalkToPlayer(player, data.entity.cwTextTab.cannotAfford, "I cannot afford to buy that item from you!")
					end

					Clockwork.datastream:Start(player, "SalesmenuRebuild", data.entity.cwCash)
				end
			end
		end
	end
end)

Clockwork.datastream:Hook("SalesmanAdd", function(player, data)
	if player.cwSalesmanSetup then
		local varTypes = {
			["showChatBubble"] = "boolean",
			["buyInShipments"] = "boolean",
			["priceScale"] = "number",
			["factions"] = "table",
			["physDesc"] = "string",
			["buyRate"] = "number",
			["classes"] = "table",
			["model"] = "string",
			["sells"] = "table",
			["stock"] = "number",
			["text"] = "table",
			["cash"] = "number",
			["buys"] = "table",
			["name"] = "string"
		}

		for k, v in pairs(varTypes) do
			if data[k] == nil or type(data[k]) ~= v then return end
		end

		for k, v in pairs(data.sells) do
			if type(k) == "string" then
				local itemTable = Clockwork.item:FindByID(k)

				if itemTable and not itemTable("isBaseItem") then
					if type(v) == "number" then
						data.sells[k] = v
					else
						data.sells[k] = true
					end
				end
			end
		end

		for k, v in pairs(data.buys) do
			if type(k) == "string" then
				local itemTable = Clockwork.item:FindByID(k)

				if itemTable and not itemTable("isBaseItem") then
					if type(v) == "number" then
						data.buys[k] = v
					else
						data.buys[k] = true
					end
				end
			end
		end

		local salesman = ents.Create("cw_salesman")
		local angles = player:GetAngles()
		angles.pitch = 0
		angles.roll = 0
		angles.yaw = angles.yaw + 180
		salesman:SetPos(player.cwSalesmanPos or player.cwSalesmanHitPos)
		salesman:SetAngles(player.cwSalesmanAng or angles)
		salesman:SetModel(data.model)
		salesman:Spawn()
		salesman.cwStock = {}

		if data.stock ~= -1 then
			for k, v in pairs(data.sells) do
				salesman.cwStock[k] = data.stock
			end
		end

		salesman.cwCash = data.cash
		salesman.cwBuyTab = data.buys
		salesman.cwSellTab = data.sells
		salesman.cwTextTab = data.text
		salesman.cwClasses = data.classes
		salesman.cwBuyRate = data.buyRate
		salesman.cwFactions = data.factions
		salesman.cwPriceScale = data.priceScale
		salesman.cwBuyInShipments = data.buyInShipments
		salesman.cwAnimation = player.cwSalesmanAnim
		salesman:SetupSalesman(data.name, data.physDesc, player.cwSalesmanAnim, data.showChatBubble)
		Clockwork.entity:MakeSafe(salesman, true, true)
		cwSalesmen.salesmen[#cwSalesmen.salesmen + 1] = salesman
	end

	player.cwSalesmanAnim = nil
	player.cwSalesmanSetup = nil
	player.cwSalesmanPos = nil
	player.cwSalesmanAng = nil
	player.cwSalesmanHitPos = nil
end)

-- A function to load the salesmen.
function cwSalesmen:LoadSalesmen()
	self.salesmen = Clockwork.kernel:RestoreSchemaData("plugins/salesmen/" .. game.GetMap())

	for k, v in pairs(self.salesmen) do
		local salesman = ents.Create("cw_salesman")

		salesman:SetPos(v.position)
		salesman:SetModel(v.model)
		salesman:SetAngles(v.angles)
		salesman:SetSkin(v.skin)

		if (istable(v.bodyGroups)) then
			for k2, v2 in pairs(v.bodyGroups) do
				salesman:SetBodygroup(k2, v2)
			end
		end

		salesman:Spawn()

		salesman.cwCash = v.cash
		salesman.cwStock = v.stock
		salesman.cwClasses = v.classes
		salesman.cwBuyRate = v.buyRate
		salesman.cwFactions = v.factions
		salesman.cwBuyTab = v.buyTab
		salesman.cwSellTab = v.sellTab
		salesman.cwTextTab = v.textTab
		salesman.cwPriceScale = v.priceScale
		salesman.cwBuyInShipments = v.buyInShipments
		salesman.cwAnimation = v.animation

		salesman:SetupSalesman(v.name, v.physDesc, v.animation, v.showChatBubble)
		Clockwork.entity:MakeSafe(salesman, true, true)
		self.salesmen[k] = salesman
	end
end

-- A function to get a salesman table from an entity.
function cwSalesmen:GetTableFromEntity(entity)
	local entTable = {
		name = entity:GetNWString("Name"),
		cash = entity.cwCash,
		stock = entity.cwStock,
		model = entity:GetModel(),
		angles = entity:GetAngles(),
		buyRate = entity.cwBuyRate,
		factions = entity.cwFactions,
		buyTab = entity.cwBuyTab,
		sellTab = entity.cwSellTab,
		textTab = entity.cwTextTab,
		classes = entity.cwClasses,
		position = entity:GetPos(),
		physDesc = entity:GetNWString("PhysDesc"),
		animation = entity.cwAnimation,
		priceScale = entity.cwPriceScale,
		buyInShipments = entity.cwBuyInShipments,
		showChatBubble = IsValid(entity:GetChatBubble()),
		skin = entity:GetSkin()
	}

	local bodyGroups = entity:GetBodyGroups()

	if (istable(bodyGroups)) then
		entTable.bodyGroups = {}

		for _, v2 in pairs(bodyGroups) do
			if (entity:GetBodygroup(v2.id) > 0) then
				entTable.bodyGroups[v2.id] = entity:GetBodygroup(v2.id)
			end
		end
	end

	return entTable
end

-- A function to save the salesmen.
function cwSalesmen:SaveSalesmen()
	local salesmen = {}

	for k, v in pairs(self.salesmen) do
		if IsValid(v) then
			salesmen[#salesmen + 1] = self:GetTableFromEntity(v)
		end
	end

	Clockwork.kernel:SaveSchemaData("plugins/salesmen/" .. game.GetMap(), salesmen)
end
