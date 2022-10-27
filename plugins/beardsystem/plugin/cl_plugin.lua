
local playerMeta = FindMetaTable("Player");

function playerMeta:CanGrowBeard()
	return self:GetGender() == GENDER_MALE and (self:GetFaction() == FACTION_CITIZEN or self:GetFaction() == FACTION_MPF);
end;
