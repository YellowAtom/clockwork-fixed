local COMMAND = Clockwork.command:New("CharFallOver")

COMMAND.tip = "CmdCharFallOver"
COMMAND.text = "CmdCharFallOverDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.optionalArguments = 1

COMMAND.alias = {"Fallover"}

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local curTime = CurTime()

	if not player.cwNextFallTime or curTime >= player.cwNextFallTime then
		player.cwNextFallTime = curTime + 5

		if not player:InVehicle() and not Clockwork.player:IsNoClipping(player) then
			local seconds = tonumber(arguments[1])

			if seconds then
				seconds = math.Clamp(seconds, 2, 30)
			elseif seconds == 0 then
				seconds = nil
			end

			if not player:IsRagdolled() then
				Clockwork.player:SetRagdollState(player, RAGDOLL_FALLENOVER, seconds)
				player:SetSharedVar("FallenOver", true)
			end
		else
			Clockwork.player:Notify(player, {"CannotActionRightNow"})
		end
	end
end

COMMAND:Register()
