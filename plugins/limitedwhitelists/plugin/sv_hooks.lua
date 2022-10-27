
-- A function to get a player's maximum characters.
function Clockwork.player:GetMaximumCharacters(player)
	local whitelistLimits = player:GetData("WhitelistLimits");
	local maxCharacters = 0;

	for faction, limit in pairs(whitelistLimits) do
		maxCharacters = maxCharacters+limit;
	end;

	return maxCharacters;
end;

function PLUGIN:PlayerCanCreateCharacter(player, character, characterID)
	local whitelistLimits = player:GetData("WhitelistLimits");

	if (whitelistLimits) then
		for k, v in pairs(whitelistLimits) do
			if (character.faction == k) then
				local characters = player:GetCharacters();
				local amount = 0;

				for k2, v2 in pairs(characters) do
					if (v2.faction == character.faction) then
						amount = amount+1;
					end;

					if (amount >= v) then
						return "You have reached the limit of characters you can create in this faction!";
					end;
				end;

				break;
			end;
		end;
	end;
end;
