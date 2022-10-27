local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Pan";
BLUEPRINT.uniqueID = "pan_weapon";
BLUEPRINT.model = "models/props_c17/metalpot002a.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Craft a frying pan to cook some eggs...";
BLUEPRINT.itemRequirements = {
	scrap_metal = 4
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 4
};
BLUEPRINT.giveItems = {
	weapon_hl2pan = 1
};

Clockwork.crafting:Register(BLUEPRINT);