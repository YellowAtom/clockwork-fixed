local COMMAND = Clockwork.command:New("MeC")

COMMAND.tip = "CmdMeC"
COMMAND.text = "CmdMeCDesc"
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE)
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local text = table.concat(arguments, " ")

	if text == "" then
		Clockwork.player:Notify(player, {"NotEnoughText"})

		return
	end

	Clockwork.chatBox:AddInTargetRadius(player, "mec", string.gsub(text, "^.", string.lower), player:GetPos(), math.min(Clockwork.config:Get("talk_radius"):Get() / 3, 80))
end

COMMAND:Register()
