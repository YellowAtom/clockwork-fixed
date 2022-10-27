--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

local COMMAND = Clockwork.command:New("FactoryDispenserAdd");
COMMAND.tip = "Add a factory dispenser at your target position.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 1;
COMMAND.text = "<1 = Breens Wather, 2 = Citizen Supplements>";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local trace = player:GetEyeTraceNoCursor();
	local entity = ents.Create("cw_factorydispenser");
	
	entity:SetPos(trace.HitPos + Vector(0,0,10));
	entity:Spawn();
	
	if (IsValid(entity)) then
		entity:SetAngles( Angle(90, player:EyeAngles().yaw + 180,0) );
		entity:SetSpawnType(arguments[1] - 1);

		Clockwork.player:Notify(player, "You have added a factory dispenser. Type: "..arguments[1]..".");
	end;
end;

COMMAND:Register();