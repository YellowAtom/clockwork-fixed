local COMMAND = Clockwork.command:New("CharGetUp")

COMMAND.tip = "CmdCharGetUp"
COMMAND.flags = CMD_DEFAULT

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if player:GetRagdollState() == RAGDOLL_FALLENOVER and player:GetSharedVar("FallenOver") and Clockwork.player:GetAction(player) ~= "unragdoll" then
		if Clockwork.plugin:Call("PlayerCanGetUp", player) then
			Clockwork.player:SetUnragdollTime(player, 5)
			player:SetSharedVar("FallenOver", false)
		end
	end
end

COMMAND:Register()
