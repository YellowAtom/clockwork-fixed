
local Clockwork = Clockwork;
local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("CharExamine");
COMMAND.tip = "Take a better look at someone for a detailed description.";
COMMAND.text = "[No Text]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local trace = player:GetEyeTraceNoCursor();
	local target = Clockwork.entity:GetPlayer(trace.Entity);
	if (target) then
		PLUGIN:SendDetailedDesc(player, target);
	else
		Clockwork.player:Notify(player, "There is no one there!");
	end;
end;

COMMAND:Register();