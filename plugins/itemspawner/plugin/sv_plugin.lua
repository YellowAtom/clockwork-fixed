
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

Clockwork.config:Add("itemspawner_spawn_interval", 720);
Clockwork.config:Add("itemspawner_spawn_interval_variation", 0.2);
Clockwork.config:Add("itemspawner_items_per_player", 1);
Clockwork.config:Add("itemspawner_items_per_interval", 5);
Clockwork.config:Add("itemspawner_items_per_interval_variation", 0.3);
Clockwork.config:Add("itemspawner_min_items_per_interval", 2);
Clockwork.config:Add("itemspawner_max_items_per_interval", 8);
Clockwork.config:Add("itemspawner_min_items", 10);
Clockwork.config:Add("itemspawner_max_items", 60);
Clockwork.config:Add("itemspawner_min_players", 5);
Clockwork.config:Add("itemspawner_rare_spawn_chance", 0.01);
Clockwork.config:Add("itemspawner_decay_time", 48, nil, nil, nil, nil, true);
Clockwork.config:Add("itemspawner_logging_enabled", true);

-- Spawn chance for each item type
PLUGIN.typeValues = {
	["misc"] = 10,
	["consumable"] = 40,
	["crafting"] = 30,
	["medical"] = 10,
	["junk"] = 10
};

PLUGIN.spawnedItems = {};
PLUGIN.itemSpawns = {};

-- A function to load the item spawns.
function PLUGIN:LoadItemSpawns()
	self.itemSpawns = Clockwork.kernel:RestoreSchemaData("plugins/itemspawner/"..game.GetMap().."_spawns");
end;

-- A function to load the spawned items.
function PLUGIN:LoadSpawnedItems()
	local spawnedItems = Clockwork.kernel:RestoreSchemaData("plugins/itemspawner/"..game.GetMap().."_items", false);

	if (!spawnedItems) then
		self:Log("[LDN] No spawned items yet for map "..game.GetMap()..". Starting new spawned items list.");
	else
		-- Loop through all items to remove decayed ones.
		local items = ents.FindByClass("cw_item");
		local decayTime = os.time() - Clockwork.config:Get("itemspawner_decay_time"):Get() * 3600;
		local itemsDecayed = 0;
		local itemTable = nil;
		local itemID = nil;
		
		for k, item in pairs(items) do
			itemTable = item:GetItemTable();
			itemID = tostring(itemTable("itemID"));
			
			if (spawnedItems[itemID]) then
				if (spawnedItems[itemID] < decayTime) then
					self:Log("[DCY] "..itemTable("name").." (ID: "..itemTable("itemID")..") has decayed.");
					spawnedItems[itemID] = nil;
					item:Remove();
					itemsDecayed = itemsDecayed + 1;
				else
					self:UpdateSpawnedItems(itemID, spawnedItems[itemID]);
					spawnedItems[itemID] = nil;
				end;
			end;
		end;
		self:Log("[LDN] Spawned items table loaded.");
		self:Log("[LDN] "..table.Count(self.spawnedItems).." items are currently spawned, "..itemsDecayed.." items have decayed.");
		self:Log("[LDN] "..table.Count(spawnedItems).." items were not found.");
	end;

	self:SaveSpawnedItems();
end;

-- A function to save the item spawns.
function PLUGIN:SaveItemSpawns()
	Clockwork.kernel:SaveSchemaData("plugins/itemspawner/"..game.GetMap().."_spawns", self.itemSpawns);
end;

-- A function to save the spawned items
function PLUGIN:SaveSpawnedItems()
	Clockwork.kernel:SaveSchemaData("plugins/itemspawner/"..game.GetMap().."_items", self.spawnedItems);
end;

-- A function to check if an item was spawned
function PLUGIN:IsSpawnedItem(itemID)
	return self.spawnedItems[tostring(itemID)];
end;

-- A function to update the spawned item list
function PLUGIN:UpdateSpawnedItems(itemID, newValue, bShouldSave)
	if (bShouldSave and self.spawnedItems[tostring(itemID)] != newValue) then
		self.spawnedItems[tostring(itemID)] = newValue;
		self:SaveSpawnedItems();
	else
		self.spawnedItems[tostring(itemID)] = newValue;
	end;
end;

-- A function to get the current spawned item count
function PLUGIN:GetSpawnedItemsCount()
	return table.Count(self.spawnedItems);
end;

-- A function to get the normal and rare spawn list.
function PLUGIN:GetSpawnList()
	Clockwork.plugin:Call("AdjustItemSpawnerTypeValues", self.typeValues);
	-- Create empty tables
	local itemsLists = {};
	local rareItems = {};
	rareItems.maxKey = 0;
	-- Start making the tables with all items
	for k, itemTable in pairs(Clockwork.item:GetAll()) do
		-- Grab value from the item
		local spawnValue = itemTable("spawnValue");
		if (spawnValue and spawnValue > 0) then
			-- Grab isRare and type of the item
			local rareItem = itemTable("isRareSpawn");
			local spawnType = itemTable("spawnType");
			-- If the item is rare
			if (rareItem) then
				if (spawnValue > 1 or spawnValue < 0) then
					ErrorNoHalt("[ItemSpawner] Item '"..itemTable("name").."' is rare, ITEM.spawnValue should be between or equal to 0 and 1.\n");
				end;
				if (spawnType) then
					ErrorNoHalt("[ItemSpawner] Item '"..itemTable("name").."' is rare, ITEM.spawnType will be ignored.\n");
				end;

				-- Get the latest key
				local key = rareItems.maxKey;
				key = key + 1;
				-- Add in item
				rareItems[key] = tostring(itemTable("index"));
				rareItems.maxKey = key;
			-- Else if the item has a valid category
			elseif (spawnType and self.typeValues[spawnType]) then
				if (spawnValue < 1) then
					ErrorNoHalt("[ItemSpawner] Item '"..itemTable("name").."' is not rare, ITEM.spawnValue should be bigger than or equal to 1.\n");
				end;
				-- Ensure spawnValue is at least 1
				spawnValue = math.max(math.Round(spawnValue), 1);
				-- Set up the table to a new one if it doesn't exist yet
				if (!itemsLists[spawnType]) then
					itemsLists[spawnType] = {};
					itemsLists[spawnType].maxKey = 0;
				end;

				-- Get the latest key
				local amount = itemsLists[spawnType].maxKey;
				-- Set next position
				local nxt = amount + spawnValue;
				-- Fill the fields between the previous and current item
				for i = amount + 1, nxt - 1 do
					itemsLists[spawnType][i] = nxt;
				end;
				-- Add in current item
				itemsLists[spawnType][nxt] = tostring(itemTable("index"));
				-- Set latest key
				itemsLists[spawnType].maxKey = nxt;
			else
				if (self.typeValues[spawnType]) then
					ErrorNoHalt("[ItemSpawner] Item '"..itemTable("name").."' has a spawnValue set, but no spawnType (and is not rare).\n");
				elseif (spawnType) then
					ErrorNoHalt("[ItemSpawner] Item '"..itemTable("name").."' has an invalid type '"..spawnType.."'.\n");
				else
					ErrorNoHalt("[ItemSpawner] Item '"..itemTable("name").."' has no spawnType set.\n");
				end;
			end;
		end;
	end;

	-- Setup table with the itemsLists
	local items = {};
	items.maxKey = 0;
	for type, itemList in pairs(itemsLists) do
		-- Grab value of the type
		local value = self.typeValues[type];
		-- If the type has a value, it's an existing type
		if (value) then
			-- Ensure the value is at least 1
			value = math.max(math.Round(value), 1);
			-- If there is no items in the table, don't bother adding it and continue
			if (table.Count(itemList) == 0) then
				continue;
			end;
			-- Get the latest key
			local amount = items.maxKey;
			-- Set next position
			local nxt = amount + value;
			-- Fill the fields between the previous and current item
			for i = amount + 1, nxt - 1 do
				items[i] = nxt;
			end;
			-- Add in current item
			items[nxt] = itemList;
			-- Set latest key
			items.maxKey = nxt;
		end;
	end;
	return items, rareItems;
end;

-- Updates the next time the item spawner will attempt to spawn items.
function PLUGIN:GetNextSpawnTime()
	-- Get spawn interval
	local spawnInterval = Clockwork.config:Get("itemspawner_spawn_interval"):Get();
	-- Get spawn interval variation
	local spawnIntervalVariation = math.Clamp(Clockwork.config:Get("itemspawner_spawn_interval_variation"):Get(), 0, 1);
	-- Update spawn interval based on the default interval +/- some variation
	return spawnInterval + ((2 * math.random() - 1) * spawnIntervalVariation * spawnInterval);
end;

-- A function to get a random item spawn.
function PLUGIN:GetRandomItemSpawn(itemSpawns, players)
	-- Get a random position
	local position = itemSpawns[math.random(1, #itemSpawns)];
	-- Return if no position was found
	if (!position) then return end;

	local radiusX = position.radiusX;
	local radiusY = position.radiusY;
	local distSqr = math.pow(position.noSpawnRadius, 2);
	-- If a player is too close to the item spawn, it will select a different item spawn.
	for k, player in pairs(players) do
		if (player:HasInitialized() and player:Alive() and player:GetPos():DistToSqr(position.pos) <= distSqr and !player:IsNoClipping()) then
			return nil;
		end;
	end;

	-- Return position plus a random offset
	return (position.pos + Vector(radiusX * (1 - 2 * math.random()), radiusY * (1 - 2 * math.random()), 0));
end;

-- A function to get a random item.
function PLUGIN:GetRandomItem(tbl)
	-- Get a random list
	local itemList = PLUGIN:FindRandomInTable(tbl);
	-- Get random item from that list
	local item = PLUGIN:FindRandomInTable(itemList);
	-- Return random item
	return item;
end;

-- A function to find a random element in a table
function PLUGIN:FindRandomInTable(tbl)
	-- Check if the table is valid
	if (!tbl or type(tbl) != "table") then
		return nil;
	end;
	-- Get a random field
	local rand = tbl[math.random(tbl.maxKey)];
	-- Return the field if it is not a number
	if (type(rand) != "number") then
		return rand;
	-- Else return the field that is where the current field points
	else
		return tbl[rand];
	end;
end;

-- A function to spawn a certain amount of items.
function PLUGIN:SpawnItems(amount)
	if (amount < 1) then
		ErrorNoHalt("[ItemSpawner] Attempting to make less than 1 attempt to spawn items.");
		self:Log("[ERR] Attempting to make less than 1 attempt to spawn items.");
		return;
	end;

	-- Check if our itemsList has anything on it
	if (self.itemsList.maxKey == 0) then
		ErrorNoHalt("[ItemSpawner] No items are correctly defined as spawnable.");
		self:Log("[ERR] No items are correctly defined as spawnable.");
		return;
	end;
	
	self:Log("[SPW] Attempting to spawn items "..amount.." times.");

	local players = player.GetAll();
	local rareSpawnChance = math.Clamp(Clockwork.config:Get("itemspawner_rare_spawn_chance"):Get(), 0, 1);
	for i = 1, amount do
		-- Get random position
		local randomPos = self:GetRandomItemSpawn(self.itemSpawns, players);
		-- Check if we got a position
		if (!randomPos) then
			self:Log("[FLR] No valid spawn location selected.");
			continue;
		end

		-- Get random item
		local randomItem;
		local tag = "ITEM";
		local spawnType;
		-- Check if we need to get an item from the rare item list
		if (math.random() > rareSpawnChance) then
			randomItem = self:GetRandomItem(self.itemsList);
		else
			self:Log("[RARE] Rare spawn chance roll successful.")
			randomItem = self:FindRandomInTable(self.rareItemsList);
			-- Do a roll to see if we should spawn this item
			if (randomItem) then
				local itemTable = Clockwork.item:FindByID(tonumber(randomItem));
				if (itemTable) then
					self:Log("[RARE-ROLL] Rolling to spawn a '"..itemTable("name").."'.");
					-- If the roll fails, spawn a normal item instead
					if (math.random() > itemTable("spawnValue")) then
						self:Log("[RARE-FAIL] Rare item roll failed. Selecting normal item.");
						randomItem = self:GetRandomItem(self.itemsList);
					else
						tag = "RARE";
						spawnType = "rare";
						self:Log("[RARE-SUCC] Rare item roll for '"..itemTable("name").."' successful!")
					end;
				end;
			end;
		end;
		-- Check if we got an item and make an instance if we did, else continue
		if (randomItem) then
			randomItem = Clockwork.item:CreateInstance(tonumber(randomItem));
			if (!randomItem("isRareSpawn")) then
				spawnType = randomItem("spawnType");
			end;
		else
			self:Log("[FLR] No valid random item selected!");
			continue;
		end;

		-- Spawn the item entity
		local entity = Clockwork.entity:CreateItem(nil, randomItem, randomPos);
		-- If we spawned an item, add the os.time onto a data field
		if (entity) then
			self:Log("["..tag.."-SPWN] '"..randomItem("name").."' (ID: "..randomItem("itemID")..", type: "..spawnType..") successfully selected and spawned.");
			self:UpdateSpawnedItems(randomItem("itemID"), os.time());
		end;
	end;

	self:SaveSpawnedItems();
	cwSaveItems:SaveItems();
end;

-- A function to run the item spawner once
function PLUGIN:RunSpawnItems()
	self:Log("[SPW] Attempting to spawn items...");

	-- Check if our itemsList has anything on it
	if (self.itemsList.maxKey == 0) then
		ErrorNoHalt("[ItemSpawner] No items are correctly defined as spawnable.");
		self:Log("[ERR] No items are correctly defined as spawnable.");
		return;
	end;
	
	-- Get the player count
	local players = player.GetAll();
	local playerCount = 0;
	for k, v in pairs(players) do
		if (v:HasInitialized()) then
			playerCount = playerCount + 1;
		end;
	end;
	-- Check if we have enough players
	if (playerCount < Clockwork.config:Get("itemspawner_min_players"):Get()) then
		self:Log("[SPW] Only "..playerCount.." players online, minimum is "..Clockwork.config:Get("itemspawner_min_players"):Get()..". Aborting spawning.");
		return;
	end;

	-- Get the config vars
	local itemsPerPlayer = Clockwork.config:Get("itemspawner_items_per_player"):Get();
	local minItems = Clockwork.config:Get("itemspawner_min_items"):Get();
	local maxItems = math.max(Clockwork.config:Get("itemspawner_max_items"):Get(), minItems);

	-- Get the maximum amount of items we should spawn based on the playercount
	local currentTarget = math.Clamp(playerCount * itemsPerPlayer, minItems, maxItems);
	-- Get the current item count
	local count = self:GetSpawnedItemsCount();
	-- Spawn items if there are less than the maximum amount
	if (count < currentTarget) then
		-- Calculate the amount we need to spawn
		local itemsPerInterval = Clockwork.config:Get("itemspawner_items_per_interval"):Get();
		local itemsPerIntervalVariation = Clockwork.config:Get("itemspawner_items_per_interval_variation"):Get();
		local spawnCount = itemsPerInterval * (1 - itemsPerIntervalVariation * (1 -
			2 * (currentTarget - minItems + 1) / (maxItems - minItems + 1)));
		spawnCount = math.Clamp(spawnCount,	Clockwork.config:Get("itemspawner_min_items_per_interval"):Get(),
			Clockwork.config:Get("itemspawner_max_items_per_interval"):Get());
		-- Spawn the needed amount of items (or up to the maximum amount)
		self:SpawnItems(math.min(currentTarget - count, math.Round(spawnCount)));
	else
		self:Log("[SPW] "..count.." items already spawned, current maximum is "..currentTarget..". Aborting spawning.");
	end;
end;

-- Updates the ESP info for all players that have it on
function PLUGIN:UpdateItemSpawnESP()
	local players = player.GetAll();
	local sendTo = {};

	for k, ply in pairs(players) do
		if (ply:IsSuperAdmin() and ply.itemSpawnESP) then
			table.insert(sendTo, ply);
		end;
	end;

	Clockwork.datastream:Start(sendTo, "ItemSpawnsESPInfo", self.itemSpawns);
end;

-- A function to log to the server.
function PLUGIN:Log(text)
	if (!Clockwork.config:Get("itemspawner_logging_enabled"):Get()) then
		return;
	end;

	local dateInfo = os.date("*t");
	
	if (dateInfo) then
		if (dateInfo.month < 10) then dateInfo.month = "0"..dateInfo.month; end;
		if (dateInfo.day < 10) then dateInfo.day = "0"..dateInfo.day; end;
		local fileName = dateInfo.year.."-"..dateInfo.month.."-"..dateInfo.day;
		
		if (dateInfo.hour < 10) then dateInfo.hour = "0"..dateInfo.hour; end;
		if (dateInfo.min < 10) then dateInfo.min = "0"..dateInfo.min; end;
		if (dateInfo.sec < 10) then dateInfo.sec = "0"..dateInfo.sec; end;
		local time = dateInfo.hour..":"..dateInfo.min..":"..dateInfo.sec;
		local logText = time..": "..string.gsub(text, "\n", "");

		Clockwork.file:Append("logs/itemspawner/"..game.GetMap().."/"..fileName..".log", logText.."\n");
	end;
end;