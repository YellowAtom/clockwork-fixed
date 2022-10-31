local COMMAND = Clockwork.command:New("A")

COMMAND.tip = "CmdA"
COMMAND.text = "CmdADesc"
COMMAND.access = "o"
COMMAND.arguments = 1

COMMAND.alias = {"AD", "OP"}

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local listeners = {}

	for k, v in pairs(cwPlayer.GetAll()) do
		if v:IsUserGroup("operator") or v:IsAdmin() or v:IsSuperAdmin() then
			listeners[#listeners + 1] = v
		end
	end

	Clockwork.chatBox:Add(listeners, player, "priv", table.concat(arguments, " "), {
		userGroup = "AdminChat"
	})
end

COMMAND:Register()
