local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Gloves";
BLUEPRINT.uniqueID = "gloves_craft";
BLUEPRINT.model = "models/props_c17/SuitCase_Passenger_Physics.mdl";
BLUEPRINT.category = "Clothing";
BLUEPRINT.description = "Keeps your hands warm.";
BLUEPRINT.itemRequirements = {
	cloth = 2,
	thread = 1,
	synth_leather = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	cloth = 2,
	thread = 1,
	synth_leather = 1
};
BLUEPRINT.giveItems = {
	gloves = 1
};

Clockwork.crafting:Register(BLUEPRINT);