local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Flash Grenade";
BLUEPRINT.uniqueID = "flash_grenade";
BLUEPRINT.model = "models/weapons/w_grenade.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "A shoddily crafted flash grenade.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 4,
	paper = 2,
	zip_tie = 2,
	compound_a = 2,
	compound_b = 1, 
	bonding_agent = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 4,
	paper = 2,
	zip_tie = 2,
	compound_a = 2,
	compound_b = 1, 
	bonding_agent = 1
};
BLUEPRINT.giveItems = {
	cw_flashgrenade = 1
};

Clockwork.crafting:Register(BLUEPRINT);