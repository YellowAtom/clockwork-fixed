local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Crossbow Bolts";
BLUEPRINT.uniqueID = "crossbow_bolts_craft";
BLUEPRINT.model = "models/items/crossbowrounds.mdl";
BLUEPRINT.category = "Ammunition";
BLUEPRINT.description = "A set of iron bolts, the coating is rusting away.";
BLUEPRINT.itemRequirements = {
	metal_rods = 1,
	bonding_agent = 1,
	blow_torch = 1,
	scrap_metal = 3
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	metal_rods = 1,
	bonding_agent = 1,
	blow_torch = 1,
	scrap_metal = 3
};
BLUEPRINT.giveItems = {
	ammo_xbowbolt = 1
};

Clockwork.crafting:Register(BLUEPRINT);