local COMMAND = Clockwork.command:New("Observer")

COMMAND.tip = "Enter or exit observer mode."
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if player:Alive() and not player:IsRagdolled() and not player.cwObserverReset and not player.bFreeze then
		if player:GetMoveType(player) == MOVETYPE_NOCLIP then
			cwObserverMode:MakePlayerExitObserverMode(player)
		else
			cwObserverMode:MakePlayerEnterObserverMode(player)
		end
	end
end

COMMAND:Register()
