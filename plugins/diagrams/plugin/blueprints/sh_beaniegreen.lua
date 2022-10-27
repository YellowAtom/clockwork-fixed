local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Green Beanie";
BLUEPRINT.uniqueID = "green_beanie_craft";
BLUEPRINT.model = "models/props_c17/SuitCase_Passenger_Physics.mdl";
BLUEPRINT.category = "Clothing";
BLUEPRINT.description = "A warm beanie of green colour, it's actually quite comfortable.";
BLUEPRINT.itemRequirements = {
	cloth = 2,
	thread = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	cloth = 2,
	thread = 1
};
BLUEPRINT.giveItems = {
	green_beanie = 1
};

Clockwork.crafting:Register(BLUEPRINT);