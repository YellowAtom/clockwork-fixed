local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Crowbar";
BLUEPRINT.uniqueID = "crowbar_craft";
BLUEPRINT.model = "models/weapons/w_crowbar.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "A crowbar... and about time too.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 6
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 6
};
BLUEPRINT.giveItems = {
	weapon_crowbar = 1
};

Clockwork.crafting:Register(BLUEPRINT);