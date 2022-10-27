local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("ToggleOOC");
COMMAND.tip = "Toggle whether or not OOC chat is enabled.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local ooc = Clockwork.config:Get("ooc_enabled");

	if (ooc:Get()) then
		ooc:Set(false);
		--Clockwork.player:NotifyAll(player:Name().." has disabled OOC.");
	else
		ooc:Set(true);
		--Clockwork.player:NotifyAll(player:Name().." has re-enabled OOC.");
	end;
end;

COMMAND:Register();