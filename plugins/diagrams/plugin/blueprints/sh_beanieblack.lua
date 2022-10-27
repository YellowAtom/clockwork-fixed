local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Black Beanie";
BLUEPRINT.uniqueID = "black_beanie_craft";
BLUEPRINT.model = "models/props_c17/SuitCase_Passenger_Physics.mdl";
BLUEPRINT.category = "Clothing";
BLUEPRINT.description = "A clean looking black beanie.";
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
	black_beanie = 1
};

Clockwork.crafting:Register(BLUEPRINT);