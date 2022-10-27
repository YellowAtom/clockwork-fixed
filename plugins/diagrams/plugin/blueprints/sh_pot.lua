local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Pot";
BLUEPRINT.uniqueID = "pot_craft";
BLUEPRINT.model = "models/weapons/hl2meleepack/w_pot.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Craft a pot to boil some pasta...";
BLUEPRINT.itemRequirements = {
	scrap_metal = 5
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 5
};
BLUEPRINT.giveItems = {
	weapon_hl2pot = 1
};

Clockwork.crafting:Register(BLUEPRINT);