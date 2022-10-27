--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("SpawnGarbagePointAdd");
COMMAND.tip = "Add garbage point at your target position.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";


-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local trace = player:GetEyeTraceNoCursor();
	local entity = ents.Create("cw_garbage");
	
	local Position = trace.HitPos + Vector(0,0,5);
	entity:SetPos(Position);
	entity:Spawn();
	
	if (IsValid(entity)) then
		Angles = Angle(0, player:EyeAngles().yaw + 180,0);
		entity:SetAngles( Angles );
		
		table.insert(PLUGIN.garbagePoints,{
			position = Position,
			angles = Angles,
			nextSpawn = 0
		});

		Clockwork.player:Notify(player, "You have added a garbage point.");
		
		PLUGIN:SaveItemAutoSpawnPoints()
	end;
end;

COMMAND:Register();