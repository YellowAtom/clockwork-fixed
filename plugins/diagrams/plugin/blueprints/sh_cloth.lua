local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Cloth";
BLUEPRINT.uniqueID = "cloth";
BLUEPRINT.model = "models/props_wasteland/prison_toiletchunk01f.mdl";
BLUEPRINT.category = "Other";
BLUEPRINT.description = "A peice of cloth. You could use this cloth to make clothing, if you had a thread.";
BLUEPRINT.itemRequirements = {
	suitcase = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	suitcase = 1
};
BLUEPRINT.giveItems = {
	cloth = 1
};

Clockwork.crafting:Register(BLUEPRINT);