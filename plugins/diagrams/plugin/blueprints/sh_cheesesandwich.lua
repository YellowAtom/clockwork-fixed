local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Cheese Sandwich";
BLUEPRINT.uniqueID = "cheese_sandwich";
BLUEPRINT.model = "models/bioshockinfinite/dread_loaf.mdl";
BLUEPRINT.category = "Consumables";
BLUEPRINT.description = "A well prepared UU Cheese Sandwich.";
BLUEPRINT.itemRequirements = {
	uu_bread = 1,
	uu_cheese = 1,
	uu_butter = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	uu_bread = 1,
	uu_cheese = 1,
	uu_butter = 1
};
BLUEPRINT.giveItems = {
	uu_cheese_sandwich = 1
};

Clockwork.crafting:Register(BLUEPRINT);