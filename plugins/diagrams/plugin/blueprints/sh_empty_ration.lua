local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Regular Ration";
BLUEPRINT.uniqueID = "normal_ration";
BLUEPRINT.model = "models/weapons/w_packatc.mdl";
BLUEPRINT.category = "Other";
BLUEPRINT.description = "The regular ration containing Smooth Breen's Water, Citizen Supplements and some tokens.";
BLUEPRINT.itemRequirements = {
	normal_empty_ration = 1,
	breens_water = 1,
	citizen_supplements = 1,
	sealed_tokens = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	normal_empty_ration = 1,
	breens_water = 1,
	citizen_supplements = 1,
	sealed_tokens = 1
};
BLUEPRINT.giveItems = {
	ration = 1
};

Clockwork.crafting:Register(BLUEPRINT);