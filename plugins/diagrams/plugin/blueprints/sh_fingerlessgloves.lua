local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Fingerless Gloves";
BLUEPRINT.uniqueID = "fingerless_gloves_craft";
BLUEPRINT.model = "models/props_c17/SuitCase_Passenger_Physics.mdl";
BLUEPRINT.category = "Clothing";
BLUEPRINT.description = "Keeps your hands warm, but not your fingers.";
BLUEPRINT.itemRequirements = {
	cloth = 1,
	thread = 1,
	nylon = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	cloth = 1,
	thread = 1,
	nylon = 1
};
BLUEPRINT.giveItems = {
	fingerless_gloves = 1
};

Clockwork.crafting:Register(BLUEPRINT);