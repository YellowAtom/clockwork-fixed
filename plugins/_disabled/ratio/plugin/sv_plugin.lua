local cwFaction = Clockwork.faction;

function PLUGIN:PlayerCanUseCharacter(player, character)
	local faction = character.faction;

	if (faction == FACTION_MPF) then
		local mpf = cwFaction:GetPlayers(faction);

		if (mpf and #mpf > 4) then
			local citizens = cwFaction:GetPlayers(cwFaction:FindByID(FACTION_CITIZEN));

			if (citizens and (#mpf >= #citizens/4)) then
				if (player:IsAdmin() or player:IsSuperAdmin()) or player:IsUserGroup("donator") then
					Clockwork.player:Notify(player, "MPF full! Used " .. string.lower(player:GetUserGroup()) .. " ratio bypass.");
					return;
				elseif (string.find(string.lower(character.name), "rl")) then
					Clockwork.player:Notify(player, "MPF full! Used Rank Leader ratio bypass.");
					return;
				end;

				return "You cannot play on your CP until there are more Citizens on, or people flag down.";
			end;
		end;
	end;
end;

