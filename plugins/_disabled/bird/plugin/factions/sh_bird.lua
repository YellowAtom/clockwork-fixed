--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local FACTION = Clockwork.faction:New("Bird");

FACTION.useFullName = true;
FACTION.whitelist = true;
FACTION.material = "halfliferp/factions/bird";
FACTION.models = {
	female = {
		"models/crow.mdl",
		"models/pigeon.mdl",
		"models/seagull.mdl"
	},
	male = {
		"models/crow.mdl",
		"models/pigeon.mdl",
		"models/seagull.mdl"
	};
};

-- Called when a player is transferred to the faction.
function FACTION:OnTransferred(player, faction, name)
	if (faction.name != FACTION_CITIZEN) then
		return false;
	end;
end;

FACTION_BIRD = FACTION:Register();