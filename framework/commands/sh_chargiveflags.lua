local COMMAND = Clockwork.command:New("CharGiveFlags")

COMMAND.tip = "CmdCharGiveFlags"
COMMAND.text = "CmdCharGiveFlagsDesc"
COMMAND.access = "s"
COMMAND.arguments = 2

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if target then
		if string.find(arguments[2], "a") or string.find(arguments[2], "s") or string.find(arguments[2], "o") then
			Clockwork.player:Notify(player, {"CannotGiveAdminFlags"})

			return
		end

		Clockwork.player:GiveFlags(target, arguments[2])

		Clockwork.player:NotifyAll({"PlayerGavePlayerFlags", player:Name(), target:Name(), arguments[2]})
	else
		Clockwork.player:Notify(player, {"NotValidCharacter", arguments[1]})
	end
end

COMMAND:Register()
