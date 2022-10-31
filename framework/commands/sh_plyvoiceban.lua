local COMMAND = Clockwork.command:New("PlyVoiceBan")

COMMAND.tip = "CmdPlyVoiceBan"
COMMAND.text = "CmdPlyVoiceBanDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if IsValid(target) then
		if not target:GetData("VoiceBan") then
			target:SetData("VoiceBan", true)
		else
			Clockwork.player:Notify(player, {"PlayerAlreadyBannedFromVoice", target:Name()})
		end
	end
end

COMMAND:Register()
