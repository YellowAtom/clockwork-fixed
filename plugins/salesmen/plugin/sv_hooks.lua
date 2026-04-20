
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
	
	-- Identity bypass: if the player matches a Steam ID, character name, or custom class,
	-- they are explicitly allowed and bypass all faction/class requirements.
	if numSteamIDs > 0 then
		local playerSteamID = player:SteamID()
		local playerSteamID64 = player:SteamID64()
		for steamID, _ in pairs(entity.cwSteamIDs) do
			if playerSteamID == steamID or playerSteamID64 == steamID then
				return
			end
		end
	end

	if numCharNames > 0 then
		local playerCharName = player:Name()
		for charName, _ in pairs(entity.cwCharNames) do
			if string.lower(playerCharName) == string.lower(charName) then
				return
			end
		end
	end

	if numCustomClasses > 0 then
		local playerCustomClass = player:GetCharacterData("customclass") or ""
		for customClass, _ in pairs(entity.cwCustomClasses) do
			if playerCustomClass ~= "" and string.lower(playerCustomClass) == string.lower(customClass) then
				return
			end
		end
	end

	-- If only identity-based restrictions were configured and none matched, deny access
	local hasStructuralRestrictions = numFactions > 0 or numClasses > 0
	if not hasStructuralRestrictions then
		entity:TalkToPlayer(player, entity.cwTextTab.noSale, "I cannot trade my inventory with you!")
		return false
	end

	-- Check faction restriction (must pass if factions are set)
	local factionAllowed = true
	if numFactions > 0 then
		factionAllowed = entity.cwFactions[player:GetFaction()] == true
	end

	-- Check built-in class restriction (must pass if classes are set)
	local classAllowed = true
	if numClasses > 0 then
		classAllowed = entity.cwClasses[cwTeam.GetName(player:Team())] == true
	end

	-- Player must pass all structural restriction categories that are set
	if not (factionAllowed and classAllowed) then
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
