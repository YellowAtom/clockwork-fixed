
-- Called when Clockwork has loaded all of the entities.
function cwSalesmen:ClockworkInitPostEntity()
	self:LoadSalesmen()
end

-- Called just after data should be saved.
function cwSalesmen:PostSaveData()
	self:SaveSalesmen()
end

-- Called when a player attempts to use a salesman.
function cwSalesmen:PlayerCanUseSalesman(player, entity)
	local numFactions = table.Count(entity.cwFactions or {})
	local numClasses = table.Count(entity.cwClasses or {})
	local numCustomClasses = table.Count(entity.cwCustomClasses or {})
	local numSteamIDs = table.Count(entity.cwSteamIDs or {})
	local numCharNames = table.Count(entity.cwCharNames or {})
	
	-- Check if any restrictions are set
	local hasRestrictions = numFactions > 0 or numClasses > 0 or numCustomClasses > 0 or numSteamIDs > 0 or numCharNames > 0
	
	if not hasRestrictions then
		-- No restrictions, allow everyone
		return
	end
	
	-- Check faction restriction (must pass if factions are set)
	local factionAllowed = true
	if numFactions > 0 then
		factionAllowed = entity.cwFactions[player:GetFaction()] == true
	end

	-- Check class restriction - must match built-in class OR custom class (if either is set)
	local classAllowed = true
	if numClasses > 0 or numCustomClasses > 0 then
		classAllowed = false
		
		-- Check built-in classes
		if numClasses > 0 then
			if entity.cwClasses[cwTeam.GetName(player:Team())] then
				classAllowed = true
			end
		end
		
		-- Check custom class restriction (uses CharSetCustomClass character data)
		if not classAllowed and numCustomClasses > 0 then
			local playerCustomClass = player:GetCharacterData("customclass") or ""
			
			for customClass, _ in pairs(entity.cwCustomClasses) do
				if playerCustomClass ~= "" and string.lower(playerCustomClass) == string.lower(customClass) then
					classAllowed = true
					break
				end
			end
		end
	end
	
	-- Check identity restrictions (Steam ID or character name) - these are OR with each other
	local identityAllowed = true
	if numSteamIDs > 0 or numCharNames > 0 then
		identityAllowed = false
		
		-- Check Steam ID restriction
		if numSteamIDs > 0 then
			local playerSteamID = player:SteamID()
			local playerSteamID64 = player:SteamID64()
			for steamID, _ in pairs(entity.cwSteamIDs) do
				if playerSteamID == steamID or playerSteamID64 == steamID then
					identityAllowed = true
					break
				end
			end
		end
		
		-- Check character name restriction
		if not identityAllowed and numCharNames > 0 then
			local playerCharName = player:Name()
			for charName, _ in pairs(entity.cwCharNames) do
				if string.lower(playerCharName) == string.lower(charName) then
					identityAllowed = true
					break
				end
			end
		end
	end

	-- Player must pass ALL restriction categories that are set
	if not (factionAllowed and classAllowed and identityAllowed) then
		entity:TalkToPlayer(player, entity.cwTextTab.noSale, "I cannot trade my inventory with you!")
		return false
	end
end

-- Called when a player uses a salesman.
function cwSalesmen:PlayerUseSalesman(player, entity)
	Clockwork.datastream:Start(player, "Salesmenu", {
		buyInShipments = entity.cwBuyInShipments,
		priceScale = entity.cwPriceScale,
		factions = entity.cwFactions,
		buyRate = entity.cwBuyRate,
		classes = entity.cwClasses,
		entity = entity,
		stock = entity.cwStock,
		sells = entity.cwSellTab,
		cash = entity.cwCash,
		text = entity.cwTextTab,
		buys = entity.cwBuyTab,
		name = entity:GetNWString("Name")
	})

	entity:TalkToPlayer(player, entity.cwTextTab.start, "How can I help you today?")
end
