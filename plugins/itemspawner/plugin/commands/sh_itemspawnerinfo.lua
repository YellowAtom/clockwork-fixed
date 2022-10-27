
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("ItemSpawnerInfo");
COMMAND.tip = "Prints all the item spawner info in the chat.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	-- Get the current item count
	local count = PLUGIN:GetSpawnedItemsCount();

	-- Get the player count
	local players = _player.GetAll();
	for k, v in pairs(players) do
		if (!v:HasInitialized()) then
			players[k] = nil;
		end;
	end;
	local playerCount = table.Count(players);

	-- Get the config vars
	local itemsPerPlayer = Clockwork.config:Get("itemspawner_items_per_player"):Get();
	local minItems = Clockwork.config:Get("itemspawner_min_items"):Get();
	local maxItems = math.max(Clockwork.config:Get("itemspawner_max_items"):Get(), minItems);

	-- Get the maximum amount of items we should spawn based on the playercount
	local currentTarget = math.Clamp(playerCount * itemsPerPlayer, minItems, maxItems);

	Clockwork.player:Notify(player, "There are a total of "..count.." spawned items on the map.");
	Clockwork.player:Notify(player, "The target amount of spawned items is "..currentTarget..".");

	local curTime = CurTime();
	if (!PLUGIN.nextItemSpawn) then
		PLUGIN.nextItemSpawn = curTime + PLUGIN:GetNextSpawnTime();
	end;

	local timeToNextSpawn = PLUGIN.nextItemSpawn - curTime;
	Clockwork.player:Notify(player, "The item spawner will attempt to spawn items in "..math.floor(timeToNextSpawn / 60).." minutes "..math.ceil(timeToNextSpawn % 60).." seconds.");

	-- Spawn items if there are less than the maximum amount
	if (count < currentTarget and playerCount >= Clockwork.config:Get("itemspawner_min_players"):Get()) then
		-- Calculate the amount we need to spawn
		local itemsPerInterval = Clockwork.config:Get("itemspawner_items_per_interval"):Get();
		local itemsPerIntervalVariation = Clockwork.config:Get("itemspawner_spawn_interval_variation"):Get();
		local spawnCount = itemsPerInterval * (1 - itemsPerIntervalVariation * (1 -
			2 * (currentTarget - minItems + 1) / (maxItems - minItems + 1)));
		spawnCount = math.Clamp(spawnCount,	Clockwork.config:Get("itemspawner_min_items_per_interval"):Get(),
			Clockwork.config:Get("itemspawner_max_items_per_interval"):Get());

		Clockwork.player:Notify(player,
			"The item spawner will attempt to spawn items "..math.min(currentTarget - count, math.Round(spawnCount)).." times.");
	else
		if (count >= currentTarget) then
			Clockwork.player:Notify(player, "The item spawner will not attempt to spawn any items: the target has already been reached.");
		else
			Clockwork.player:Notify(player, "The item spawner will not attempt to spawn any items: there are only "..playerCount.." players online.");
		end;
	end;
end;

COMMAND:Register();