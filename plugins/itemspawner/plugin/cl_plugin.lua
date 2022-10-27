
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

Clockwork.config:AddToSystem("[IS] Minimum Spawned Items", "itemspawner_min_items", "The minimum amount of spawned items that are allowed at one time.", 0, 128, 0);
Clockwork.config:AddToSystem("[IS] Maximum Spawned Items", "itemspawner_max_items", "The maximum amount of spawned items that are allowed at one time.", 0, 256, 0);
Clockwork.config:AddToSystem("[IS] Items per Player", "itemspawner_items_per_player", "The amount of spawned items that are allowed per player on the server.", 0, 10, 1);
Clockwork.config:AddToSystem("[IS] Item Spawn Interval", "itemspawner_spawn_interval", "The interval in seconds between spawning items.", 0, 7200, 0);
Clockwork.config:AddToSystem("[IS] Item Spawn Interval Variation", "itemspawner_spawn_interval_variation", "The percentage of variation to allow in the spawn interval.", 0, 1, 2);
Clockwork.config:AddToSystem("[IS] Minimum Items per Interval", "itemspawner_min_items_per_interval", "The minimum amount of items to spawn every interval.", 0, 256, 0);
Clockwork.config:AddToSystem("[IS] Maximum Items per Interval", "itemspawner_max_items_per_interval", "The maximum amount of items to spawn every interval.", 256, 0);
Clockwork.config:AddToSystem("[IS] Items per Interval", "itemspawner_items_per_interval", "The amount of items to spawn on average per interval.", 0, 256, 0);
Clockwork.config:AddToSystem("[IS] Items per Interval Variation", "itemspawner_items_per_interval_variation", "How much the items spawned per interval should vary depending on how high/low the target amount is.", 0, 1, 2);
Clockwork.config:AddToSystem("[IS] Rare Spawn Chance", "itemspawner_rare_spawn_chance", "The chance to select a rare item from the rare spawn list every time an item is spawned.", 0, 1, 3);
Clockwork.config:AddToSystem("[IS] Spawned Item Decay Time", "itemspawner_decay_time", "The amount of hours it takes for an item to be considered decayed if it doesn't get picked up. Decayed items get removed after a map reload.", 0, 256, 0);
Clockwork.config:AddToSystem("[IS] Minimum Players Online", "itemspawner_min_players", "The minimum amount of players that have to be online for items to be spawned.", 0, 80, 0);
Clockwork.config:AddToSystem("[IS] Enable Logging", "itemspawner_logging_enabled", "Turns the logging on and off.", 0, 1, 0);