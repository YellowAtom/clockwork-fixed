
-- A function to make a player exit their stance.
function cwEmoteAnims:MakePlayerExitStance(player, keepPosition)
	if player.cwPreviousPos and not keepPosition then
		for k, v in pairs(cwPlayer.GetAll()) do
			if v ~= player and v:GetPos():Distance(player.cwPreviousPos) <= 32 then
				Clockwork.player:Notify(player, "Another character is blocking this position!")

				return
			end
		end

		Clockwork.player:SetSafePosition(player, player.cwPreviousPos)
	end

	player:SetForcedAnimation(false)
	player.cwPreviousPos = nil
	player:SetSharedVar("StancePos", Vector(0, 0, 0))
	player:SetSharedVar("StanceAng", Angle(0, 0, 0))
	player:SetSharedVar("StanceIdle", false)
end
