
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("ItemSpawnerForceRun");
COMMAND.tip = "Forces the item spawner to run once, ignoring the interval.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local count = PLUGIN:GetSpawnedItemsCount();

	PLUGIN:Log("[FRC] "..player:Name().." ("..player:SteamName()..") is forcing to item spawner to run.");
	PLUGIN:RunSpawnItems();

	local diff = PLUGIN:GetSpawnedItemsCount() - count;
	
	Clockwork.player:Notify(player, "Forcing the item spawner to run once. Spawned "..diff.." items.");
end;

COMMAND:Register();