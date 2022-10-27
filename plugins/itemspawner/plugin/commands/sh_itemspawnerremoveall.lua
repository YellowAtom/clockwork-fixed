
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("ItemSpawnerRemoveAll");
COMMAND.tip = "Remove all item spawns.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	PLUGIN.itemSpawns = {};
	PLUGIN:UpdateItemSpawnESP();
	PLUGIN:SaveItemSpawns();
	Clockwork.player:Notify(player, "You have removed all item spawns.");
end;

COMMAND:Register();