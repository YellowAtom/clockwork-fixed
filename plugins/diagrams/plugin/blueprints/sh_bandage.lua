local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Bandage";
BLUEPRINT.uniqueID = "bandage_blueprint";
BLUEPRINT.model = "models/props_wasteland/prison_toiletchunk01f.mdl";
BLUEPRINT.category = "Medical";
BLUEPRINT.description = "A bandage, there isn't much so use it wisely.";
BLUEPRINT.itemRequirements = {
	cloth = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	cloth = 1
};
BLUEPRINT.giveItems = {
	bandage = 1
};

Clockwork.crafting:Register(BLUEPRINT);