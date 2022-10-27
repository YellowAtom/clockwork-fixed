--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("SpawnGarbagePointRemove");
COMMAND.tip = "Remove garbage point at your target position.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";


function COMMAND:OnRun(player, arguments)
	local position = player:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 32);
	local pointsCount = 0;
	
	for k, v in pairs(PLUGIN.garbagePoints) do
		if (v.position:Distance(position) <= 50) then
			pointsCount = pointsCount + 1;	
			PLUGIN.garbagePoints[k] = nil;
		end;
	end
	
	if (pointsCount > 0) then
		if (pointsCount == 1) then
			Clockwork.player:Notify(player, "You have removed "..pointsCount.." garbage spawn.");
		else
			Clockwork.player:Notify(player, "You have removed "..pointsCount.." garbage spawns.");
		end;
	else
		Clockwork.player:Notify(player, "There were no garbage spawns near this position.");
	end;
	
	PLUGIN:SaveItemAutoSpawnPoints()
end;

COMMAND:Register();