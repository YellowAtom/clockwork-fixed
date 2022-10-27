-- Called at an interval while a player is connected.
function PLUGIN:PlayerThink(player, curTime, infoTable)
	if (player:Alive() and !player:IsRagdolled()) then
		if (!player:InVehicle() and player:GetMoveType() == MOVETYPE_WALK) then
			if (player:IsInWorld()) then
				--if (!player:IsOnGround()) then
					--player:ProgressAttribute(ATB_ACROBATICS, 0.25, true);
				if (player:IsRunning()) then
					player:ProgressAttribute(ATB_AGILITY, 0.125, true);
				elseif (player:IsJogging()) then
					player:ProgressAttribute(ATB_AGILITY, 0.0625, true);
				end;
			end;
		end;
	end;
end;