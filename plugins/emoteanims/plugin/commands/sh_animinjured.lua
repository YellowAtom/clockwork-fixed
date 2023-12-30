local COMMAND = Clockwork.command:New("AnimInjured")

COMMAND.tip = "Make your character lay on the ground."
COMMAND.alias = {"ActInjured"}
COMMAND.flags = CMD_DEFAULT

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local curTime = CurTime()

	if not player.cwNextStance or curTime >= player.cwNextStance then
		player.cwNextStance = curTime + 2.5
		local modelClass = Clockwork.animation:GetModelClass(player:GetModel())

		if modelClass == "maleHuman" or modelClass == "femaleHuman" then
			local forcedAnimation = player:GetForcedAnimation()

			if forcedAnimation and cwEmoteAnimscwEmoteAnims[forcedAnimation.animation] then
				Clockwork.player:Notify(player, "You cannot do this action at the moment!")
			else
				if modelClass == "femaleHuman" then
					player:SetForcedAnimation("d1_town05_wounded_idle_1", 0)
				else
					player:SetForcedAnimation("d1_town05_wounded_idle_1", 0)
				end

					player:SetSharedVar("StancePos", player:GetPos())
					player:SetSharedVar("StanceAng", player:GetAngles())
					player:SetSharedVar("StanceIdle", true)
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