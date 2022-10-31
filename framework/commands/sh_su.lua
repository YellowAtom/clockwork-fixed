local COMMAND = Clockwork.command:New("Su")

COMMAND.tip = "CmdSu"
COMMAND.text = "CmdSuDesc"
COMMAND.access = "s"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local listeners = {}

	for k, v in pairs(cwPlayer.GetAll()) do
		if v:IsSuperAdmin() then
			listeners[#listeners + 1] = v
		end
	end

	Clockwork.chatBox:Add(listeners, player, "priv", table.concat(arguments, " "), {
		userGroup = "superadmin"
	})
end

COMMAND:Register()
