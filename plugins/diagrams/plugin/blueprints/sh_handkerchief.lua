local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Red Handkerchief";
BLUEPRINT.uniqueID = "facewrap_craft";
BLUEPRINT.model = "models/props_c17/SuitCase_Passenger_Physics.mdl";
BLUEPRINT.category = "Clothing";
BLUEPRINT.description = "A red handkerchief, could be used to conceal your face.";
BLUEPRINT.itemRequirements = {
	cloth = 1,
	red_dye = 1,
	thread = 1,
	nylon = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	cloth = 1,
	red_dye = 1,
	thread = 1,
	nylon = 1
};
BLUEPRINT.giveItems = {
	facewrap = 1
};

Clockwork.crafting:Register(BLUEPRINT);