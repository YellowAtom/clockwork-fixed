local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Metal Shovel";
BLUEPRINT.uniqueID = "metal_shovel";
BLUEPRINT.model = "models/props_junk/Shovel01a.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Go digging for your life's purpose.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 2,
	wood_part = 4
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 2,
	wood_part = 4
};
BLUEPRINT.giveItems = {
	weapon_hl2shovel = 1
};

Clockwork.crafting:Register(BLUEPRINT);