local COMMAND = Clockwork.command:New("Event")

COMMAND.tip = "CmdEvent"
COMMAND.text = "CmdEventDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.chatBox:Add(nil, player, "event", table.concat(arguments, " "))
end

COMMAND:Register()
