local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "UU Pouch";
BLUEPRINT.model = "models/weapons/w_defuser.mdl";
BLUEPRINT.uniqueID = "uu_craft_pouch";
BLUEPRINT.category = "Storage";
BLUEPRINT.description = "A small pouch with a UU insignia on it, ideal for holding small things.";
BLUEPRINT.itemRequirements = {
	cloth = 4,
	thread = 2
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	cloth = 4,
	thread = 2
};
BLUEPRINT.giveItems = {
	uupouch = 1
};

Clockwork.crafting:Register(BLUEPRINT);