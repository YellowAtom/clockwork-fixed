-- A function to get the local player's maximum characters.
function Clockwork.player:GetMaximumCharacters()
	local whitelistLimits = Clockwork.WhitelistLimits;
	local maxCharacters = 0;

	for faction, limit in pairs(whitelistLimits) do
		maxCharacters = maxCharacters+limit;
	end;

	return maxCharacters;
end;

Clockwork.datastream:Hook("WhitelistLimits", function(data)
	Clockwork.WhitelistLimits = data;
end);