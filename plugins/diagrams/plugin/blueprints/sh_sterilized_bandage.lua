local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Sterilized Bandage";
BLUEPRINT.uniqueID = "sterilized_bandage_blueprint";
BLUEPRINT.model = "models/props_wasteland/prison_toiletchunk01f.mdl";
BLUEPRINT.category = "Medical";
BLUEPRINT.description = "A sterilized bandage, there isn't much so use it wisely.";
BLUEPRINT.itemRequirements = {
	bandage = 1,
	anti_septic = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	bandage = 1,
	anti_septic = 1
};
BLUEPRINT.giveItems = {
	sterilized_bandage = 1
};

Clockwork.crafting:Register(BLUEPRINT);