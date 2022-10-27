local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Leech Sandwich";
BLUEPRINT.uniqueID = "leech_sandwich";
BLUEPRINT.model = "models/bioshockinfinite/dread_loaf.mdl";
BLUEPRINT.category = "Consumables";
BLUEPRINT.description = "A decent looking Leech Sandwich.";
BLUEPRINT.itemRequirements = {
	uu_bread = 1,
	canned_leeches = 1,
	uu_butter = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	uu_bread = 1,
	canned_leeches = 1,
	uu_butter = 1
};
BLUEPRINT.giveItems = {
	leech_sandwich = 1
};

Clockwork.crafting:Register(BLUEPRINT);