local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Axe";
BLUEPRINT.uniqueID = "wood_axe";
BLUEPRINT.model = "models/props/cs_militia/axe.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Axe me a question, I dare you.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 3,
	wood_part = 2
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 3,
	wood_part = 2
};
BLUEPRINT.giveItems = {
	weapon_hl2axe = 1
};

Clockwork.crafting:Register(BLUEPRINT);