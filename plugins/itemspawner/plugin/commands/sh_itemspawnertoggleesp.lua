
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("ItemSpawnerToggleESP");
COMMAND.tip = "Toggles item spawns on or off on the admin ESP.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (player.itemSpawnESP == true) then
		Clockwork.datastream:Start(player, "ItemSpawnsESPInfo", false);
		player.itemSpawnESP = false;
		Clockwork.player:Notify(player, "You have turned the item spawn ESP off.");
	else
		Clockwork.datastream:Start(player, "ItemSpawnsESPInfo", PLUGIN.itemSpawns);
		player.itemSpawnESP = true;
		Clockwork.player:Notify(player, "You have turned the item spawn ESP on.");
	end;
end;

COMMAND:Register();