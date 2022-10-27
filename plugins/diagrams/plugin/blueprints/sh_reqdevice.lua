local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Request Device";
BLUEPRINT.model = "models/gibs/shield_scanner_gib1.mdl";
BLUEPRINT.uniqueID = "req_device";
BLUEPRINT.category = "Communication";
BLUEPRINT.description = "A small radio-like device with one red button.";
BLUEPRINT.itemRequirements = {
	batteries = 1,
	empty_req = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	batteries = 1,
	empty_req = 1
};
BLUEPRINT.giveItems = {
	request_device = 1
};

Clockwork.crafting:Register(BLUEPRINT);