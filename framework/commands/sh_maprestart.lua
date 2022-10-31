local COMMAND = Clockwork.command:New("MapRestart")

COMMAND.tip = "CmdMapRestart"
COMMAND.text = "CmdMapRestartDesc"
COMMAND.access = "a"
COMMAND.optionalArguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local delay = tonumber(arguments[1]) or 10

	if type(arguments[1]) == "number" then
		delay = arguments[1]
	end

	Clockwork.player:NotifyAll({"PlayerRestartingMapIn", player:Name(), delay})

	timer.Simple(delay, function()
		RunConsoleCommand("changelevel", game.GetMap())
	end)
end

COMMAND:Register()
