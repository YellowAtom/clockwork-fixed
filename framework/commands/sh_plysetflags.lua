local COMMAND = Clockwork.command:New("PlySetFlags")

COMMAND.tip = "CmdPlySetFlags"
COMMAND.text = "CmdPlySetFlagsDesc"
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

		Clockwork.player:SetPlayerFlags(target, arguments[2])

		Clockwork.player:NotifyAll({"PlayerSetPlayerFlagsTo", player:Name(), target:SteamName(), arguments[2]})
	else
		Clockwork.player:Notify(player, {"NotValidCharacter", arguments[1]})
	end
end

COMMAND:Register()
