local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Metal Pipe";
BLUEPRINT.uniqueID = "metal_pipe";
BLUEPRINT.model = "models/props_canal/mattpipe.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Fix your leaky sink.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 5
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 5
};
BLUEPRINT.giveItems = {
	weapon_hl2pipe = 1
};

Clockwork.crafting:Register(BLUEPRINT);