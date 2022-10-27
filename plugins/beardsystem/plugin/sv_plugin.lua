
local PLUGIN = PLUGIN;

BEARD_NONE = 0;
BEARD_HALF = 1;
BEARD_FULL = 2;

PLUGIN.styles = {
	STYLE_HANDLEBAR = 1,
	STYLE_COPSTASH = 2,
	STYLE_DALLAS = 3,
	STYLE_IMPERIAL = 4,
	STYLE_SMALLGOATEE = 6,
	STYLE_GOATEE = 7
};

local playerMeta = FindMetaTable("Player");

function playerMeta:CanGrowBeard(gender, faction)
	faction = faction or self:GetFaction();

	return (gender or self:GetGender()) == GENDER_MALE and (faction == FACTION_CITIZEN or faction == FACTION_MPF);
end;
