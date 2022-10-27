
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

-- Called when Clockwork has loaded all of the entities.
function PLUGIN:ClockworkInitPostEntity()
	PLUGIN:LoadItemSpawns();
	self.itemsList, self.rareItemsList = self:GetSpawnList();
end;


function PLUGIN:ClockworkInitialized()
	local saveItemInit = cwSaveItems.ClockworkInitPostEntity;

	function cwSaveItems:ClockworkInitPostEntity()
		saveItemInit(self);
		PLUGIN:LoadSpawnedItems();
	end;
end;

-- Called just after data should be saved.
function PLUGIN:PostSaveData()
	self:SaveItemSpawns();
end;

function PLUGIN:ClockworkConfigChanged(key, data, oldValue, newValue)
	if (key == "itemspawner_max_items") then
		local minItems = Clockwork.config:Get("itemspawner_min_items"):Get();
		if (minItems > newValue) then
			Clockwork.config:Get(key):Set(minItems);
		end;
	elseif (key == "itemspawner_max_items_per_interval") then
		local minItems = Clockwork.config:Get("itemspawner_min_items_per_interval"):Get();
		if (minItems > newValue) then
			Clockwork.config:Get(key):Set(minItems);
		end;
	elseif (key == "itemspawner_spawn_interval") then
		self.nextItemSpawn = self.nextItemSpawn - oldValue + newValue;
	end;
end;

-- Called each tick.
function PLUGIN:Tick()
	local curTime = CurTime();
	-- Check if interval is reached
	if (!self.nextItemSpawn or curTime >= self.nextItemSpawn) then
		local nextSpawn = PLUGIN:GetNextSpawnTime();
		self.nextItemSpawn = curTime + nextSpawn;

		self:RunSpawnItems();

		self:Log("[NXT] The item spawner will attempt to spawn items in "..math.floor(nextSpawn / 60).." minutes and "..math.ceil(nextSpawn % 60).." seconds.");
	end;
end;

function PLUGIN:PlayerPickupItem(player, itemTable, entity, bQuickUse)
	if (self:IsSpawnedItem(itemTable("itemID"))) then
		self:Log("[PUP] '"..itemTable("name").."' (ID: "..itemTable("itemID")..") has been picked up by "..player:Name().." ("..player:SteamName()..").");
		self:UpdateSpawnedItems(itemTable("itemID"), nil, true);
	end;
end;

function PLUGIN:ShutDown()
	self.shuttingDown = true;
end;

function PLUGIN:EntityRemoved(entity)
	if (!self.shuttingDown and entity.GetClass and entity:GetClass() == "cw_item" and entity.GetItemTable) then
		local itemTable = entity:GetItemTable();
		if (self:IsSpawnedItem(itemTable("itemID"))) then
			self:Log("[RMV] '"..itemTable("name").."' (ID: "..itemTable("itemID")..") has been removed.");
			self:UpdateSpawnedItems(itemTable("itemID"), nil, true);
		end;
	end;
end;