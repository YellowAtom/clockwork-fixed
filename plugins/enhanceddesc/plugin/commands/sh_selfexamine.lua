local Clockwork = Clockwork;
local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("SelfExamine");
COMMAND.tip = "Look at yourself";
COMMAND.text = "[No Text]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	PLUGIN:SendDetailedDesc(player, player);
end;

COMMAND:Register();