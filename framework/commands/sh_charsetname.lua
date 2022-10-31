local COMMAND = Clockwork.command:New("CharSetName")

COMMAND.tip = "CmdCharSetName"
COMMAND.text = "CmdCharSetNameDesc"
COMMAND.access = "o"
COMMAND.arguments = 2

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if target then
		local name = table.concat(arguments, " ", 2)

		Clockwork.player:NotifyAll({"PlayerSetPlayerName", player:Name(), target:Name(), name})

		Clockwork.player:SetName(target, name)
	else
		Clockwork.player:Notify(player, {"NotValidCharacter", arguments[1]})
	end
end

COMMAND:Register()
