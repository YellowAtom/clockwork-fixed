local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Trashed CID";
BLUEPRINT.uniqueID = "trashed_cid_craft";
BLUEPRINT.model = "models/cmz/citizenid.mdl";
BLUEPRINT.category = "ID Cards";
BLUEPRINT.description = "Scratch up a CID so that no one can read it. This shouldn't be done lightheartedly!";
BLUEPRINT.itemRequirements = {
	pin = 1,
	cid_card = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	cid_card = 1
};
BLUEPRINT.giveItems = {
	trashed_cid = 1
};

Clockwork.crafting:Register(BLUEPRINT);