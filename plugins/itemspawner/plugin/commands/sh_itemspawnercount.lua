
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("ItemSpawnerCount");
COMMAND.tip = "Counts the amount of spawned items on the map.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.player:Notify(player, "There are a total of "..PLUGIN:GetSpawnedItemsCount().." spawned items on the map.");
end;

COMMAND:Register();