local COMMAND = Clockwork.command:New("ItL")

COMMAND.tip = "CmdItL"
COMMAND.text = "CmdItLDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local text = table.concat(arguments, " ")

	if string.utf8len(text) < 8 then
		Clockwork.player:Notify(player, {"NotEnoughText"})

		return
	end

	Clockwork.chatBox:AddInTargetRadius(player, "itl", text, player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)
end

COMMAND:Register()
