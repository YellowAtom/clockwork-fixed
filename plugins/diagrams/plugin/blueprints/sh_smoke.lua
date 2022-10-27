local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Smoke Grenade";
BLUEPRINT.uniqueID = "smoke_grenade";
BLUEPRINT.model = "models/weapons/w_grenade.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "A shoddily crafted smoke grenade.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 4,
	paper = 2,
	compound_a = 1,
	compound_b = 1, 
	black_dye = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 4,
	paper = 2,
	compound_a = 1,
	compound_b = 1, 
	black_dye = 1
};
BLUEPRINT.giveItems = {
	cw_smokegrenade = 1
};

Clockwork.crafting:Register(BLUEPRINT);