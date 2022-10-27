
function PLUGIN:PlayerDataLoaded(player)
	local whitelistLimits = player:GetData("WhitelistLimits");

	if (!whitelistLimits) then
		local limit = Clockwork.config:Get("default_citizen_limit"):Get(3);
		whitelistLimits = { Citizen = limit };
	else
		local factions = Clockwork.faction:GetAll();

		for k, v in pairs(whitelistLimits) do
			local exists;

			for k2, v2 in pairs(factions) do
				if (k == k2) then
					exists = true;
					break;
				end;
			end;

			if (!exists) then
				whitelistLimits[k] = nil;
			end;
		end;
	end;

	player:SetData("WhitelistLimits", whitelistLimits);
	Clockwork.datastream:Start(player, "WhitelistLimits", whitelistLimits);
end;
