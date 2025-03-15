local COMMAND = Clockwork.command:New("Radio")

COMMAND.tip = "CmdRadio"
COMMAND.text = "CmdRadioDesc"
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE, CMD_FALLENOVER)
COMMAND.arguments = 1

COMMAND.alias = {"r"}

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.player:SayRadio(player, table.concat(arguments, " "), true)
end

COMMAND:Register()
