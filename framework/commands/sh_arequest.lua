local COMMAND = Clockwork.command:New("ARequest")

COMMAND.tip = "CmdARequest"
COMMAND.text = "CmdARequestDesc"
COMMAND.access = "o"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if not Clockwork.player:IsAdmin(player) then
		Clockwork.player:NotifyAdmins("o", {"RequestFromMsg", player:Name(), table.concat(arguments, " ")})
	else
		Clockwork.player:Notify(player, {"RequestAdminRedirect"})
	end
end

COMMAND:Register()
