
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("ItemSpawnerRemove");
COMMAND.tip = "Remove an item spawn at your target position.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local position = player:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 32);
	local itemSpawns = 0;
	
	local distSqr = math.pow(256, 2);
	for k, spawn in pairs(PLUGIN.itemSpawns) do
		if (spawn.pos:DistToSqr(position) <= distSqr) then
			itemSpawns = itemSpawns + 1;
			
			PLUGIN.itemSpawns[k] = nil;
		end;
	end
	
	if (itemSpawns > 0) then
		if (itemSpawns == 1) then
			Clockwork.player:Notify(player, "You have removed "..itemSpawns.." item spawn.");
		else
			Clockwork.player:Notify(player, "You have removed "..itemSpawns.." item spawns.");
		end;
	else
		Clockwork.player:Notify(player, "There are no item spawns near this position.");
	end;
	
	PLUGIN:UpdateItemSpawnESP();
	PLUGIN:SaveItemSpawns();
end;

COMMAND:Register();