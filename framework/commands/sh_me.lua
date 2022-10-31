local COMMAND = Clockwork.command:New("Me")

COMMAND.tip = "CmdMe"
COMMAND.text = "CmdMeDesc"
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE)
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local text = table.concat(arguments, " ")

	if text == "" then
		Clockwork.player:Notify(player, {"NotEnoughText"})

		return
	end

	Clockwork.chatBox:AddInTargetRadius(player, "me", string.gsub(text, "^.", string.lower), player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2)
end

COMMAND:Register()
