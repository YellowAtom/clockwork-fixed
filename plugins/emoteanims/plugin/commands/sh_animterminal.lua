local COMMAND = Clockwork.command:New("AnimTerminal")

COMMAND.tip = "Type on that terminal."
COMMAND.alias = {"ActTerminal"}
COMMAND.flags = CMD_DEFAULT

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local curTime = CurTime()

	if not player.cwNextStance or curTime >= player.cwNextStance then
		player.cwNextStance = curTime + 2
		local modelClass = Clockwork.animation:GetModelClass(player:GetModel())
--		local position = player:GetPos()

		if modelClass == "combineOverwatch" then
			local forcedAnimation = player:GetForcedAnimation()
			local animation = "console_type_loop"

			if forcedAnimation and forcedAnimation.animation == "console_type_loop" then
				cwEmoteAnims:MakePlayerExitStance(player)
			elseif not forcedAnimation or not cwEmoteAnimscwEmoteAnims[forcedAnimation.animation] then
				if player:Crouching() then
					Clockwork.player:Notify(player, "You cannot do this while you are crouching!")
				elseif player:IsOnGround() or IsValid(player:GetGroundEntity()) then
					player:SetSharedVar("StancePos", player:GetPos())
					player:SetSharedVar("StanceAng", player:GetAngles())
					player:SetSharedVar("StanceIdle", true)

					player:SetForcedAnimation(animation, 0, nil, function()
						cwEmoteAnims:MakePlayerExitStance(player)
					end)
				else
					Clockwork.player:Notify(player, "You must be standing on the ground!")
				end
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
	Clockwork.quickmenu:AddCommand(string.gsub(COMMAND.name, "Anim", ""), "Emotes", COMMAND.name)
end
