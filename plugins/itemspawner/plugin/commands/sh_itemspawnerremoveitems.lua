
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("ItemSpawnerRemoveItems");
COMMAND.tip = "Add an item spawn at your target position.";
COMMAND.text = "[bool DecayedOnly|Default: false]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 0;
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local decayedOnly = (arguments[1] and Clockwork.kernel:ToBool(arguments[1]));
	local items = ents.FindByClass("cw_item");
	local itemTable = nil;
	local itemID = nil;
	local decayTime = Clockwork.config:Get("itemspawner_decay_time"):Get() * 3600;
	local osTime = os.time() - decayTime;
	local count = 0;

	for k, item in pairs(items) do
		itemTable = item:GetItemTable();
		itemID = tostring(itemTable("itemID"));

		if (PLUGIN.spawnedItems[itemID]) then
			if (PLUGIN.spawnedItems[itemID] < osTime) then
				PLUGIN:UpdateSpawnedItems(itemID);
				item:Remove();
				count = count + 1;
			elseif (!decayedOnly) then
				PLUGIN:UpdateSpawnedItems(itemID);
				item:Remove();
				count = count + 1;
			end;
		end;
	end;

	if (decayedOnly) then
		PLUGIN:Log("[FRC] "..player:Name().." ("..player:SteamName()..") has removed all decayed items.");
	else
		PLUGIN:Log("[FRC] "..player:Name().." ("..player:SteamName()..") has removed all spawned items.");
	end;
	PLUGIN:SaveSpawnedItems();
	
	Clockwork.player:Notify(player, "You have removed "..count.." spawned items.");
end;

COMMAND:Register();