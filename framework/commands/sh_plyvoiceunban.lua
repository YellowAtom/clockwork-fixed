local COMMAND = Clockwork.command:New("PlyVoiceUnban")

COMMAND.tip = "CmdPlyVoiceUnban"
COMMAND.text = "CmdPlyVoiceUnbanDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if IsValid(target) then
		if target:GetData("VoiceBan") then
			target:SetData("VoiceBan", false)
		else
			Clockwork.player:Notify(player, {"PlayerNotBannedFromVoice", target:Name()})
		end
	end
end

COMMAND:Register()
