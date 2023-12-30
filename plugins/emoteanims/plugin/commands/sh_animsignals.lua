local COMMAND = Clockwork.command:New("AnimSignals")

COMMAND.tip = "Allows your character to signal with hand motions."
COMMAND.alias = {"ActSignals"}
COMMAND.text = ""
COMMAND.flags = CMD_DEFAULT

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local curTime = CurTime()

	if not player.cwNextStance or curTime >= player.cwNextStance then
		player.cwNextStance = curTime + 2.5
		local modelClass = Clockwork.animation:GetModelClass(player:GetModel())

		if modelClass == "combineOverwatch" then
			local forcedAnimation = player:GetForcedAnimation()
			local action = string.lower(arguments[1] or "")

			if forcedAnimation and cwEmoteAnimscwEmoteAnims[forcedAnimation.animation] then
				Clockwork.player:Notify(player, "You cannot do this action at the moment!")
			else
				if action == "advance" then
					player:SetForcedAnimation("signal_advance", 1)
				elseif action == "forward" then
					player:SetForcedAnimation("signal_forward", 1)
				elseif action == "group" then
					player:SetForcedAnimation("signal_group", 1)
				elseif action == "halt" then
					player:SetForcedAnimation("signal_halt", 1)
				elseif action == "left" then
					player:SetForcedAnimation("signal_left", 1)
				elseif action == "right" then
					player:SetForcedAnimation("signal_right", 1)
				elseif action == "take cover" then
					player:SetForcedAnimation("signal_takecover", 1)
				end

				player:SetSharedVar("StancePos", player:GetPos())
				player:SetSharedVar("StanceAng", player:GetAngles())
				player:SetSharedVar("StanceIdle", false)
			end
		else
			Clockwork.player:Notify(player, "The model that you are using cannot perform this action!")
		end
	else
		Clockwork.player:Notify(player, "You cannot do another stance or gesture yet!")
	end
end

COMMAND:Register()

if CLIENT then
	Clockwork.quickmenu:AddCommand(string.gsub(COMMAND.name, "Anim", ""), "Emotes", COMMAND.name, {"Advance", "Forward", "Group", "Halt", "Left", "Right", "Take Cover"})
end
