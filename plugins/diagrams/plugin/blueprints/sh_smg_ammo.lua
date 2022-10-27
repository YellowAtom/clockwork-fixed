local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "SMG Ammo";
BLUEPRINT.uniqueID = "smg_ammo";
BLUEPRINT.model = "models/items/boxmrounds.mdl";
BLUEPRINT.category = "Ammunition";
BLUEPRINT.description = "A heavy container filled with a lot of bullets.";
BLUEPRINT.itemRequirements = {
	smg_ammo_empty = 1,
	gunpowder = 2,
	compound_b = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	smg_ammo_empty = 1,
	gunpowder = 2,
	compound_b = 1
};
BLUEPRINT.giveItems = {
	ammo_smg1 = 1
};

Clockwork.crafting:Register(BLUEPRINT);