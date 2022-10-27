local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "9mm Pistol Ammo";
BLUEPRINT.uniqueID = "9mm_ammo";
BLUEPRINT.model = "models/Items/BoxSRounds.mdl";
BLUEPRINT.category = "Ammunition";
BLUEPRINT.description = "A container filled with bullets and 9mm printed on the side.";
BLUEPRINT.itemRequirements = {
	empty_9mm_ammo = 1,
	gunpowder = 1,
	compound_a = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	empty_9mm_ammo = 1,
	gunpowder = 1,
	compound_a = 1
};
BLUEPRINT.giveItems = {
	ammo_pistol = 1
};

Clockwork.crafting:Register(BLUEPRINT);