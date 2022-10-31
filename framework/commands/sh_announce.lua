local COMMAND = Clockwork.command:New("Announce")

COMMAND.tip = "CmdAnnounce"
COMMAND.text = "CmdAnnounceDesc"
COMMAND.arguments = 1
COMMAND.access = "o"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local text = table.concat(arguments, " ")

	if text ~= "" then
		Clockwork.player:NotifyAll(text)
	end
end

COMMAND:Register()
