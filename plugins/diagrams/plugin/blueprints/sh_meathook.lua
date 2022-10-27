local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Meat Hook";
BLUEPRINT.uniqueID = "meat_hook";
BLUEPRINT.model = "models/props_junk/meathook001a.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "String stuff up with this metal hook.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 5
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 5
};
BLUEPRINT.giveItems = {
	weapon_hl2hook = 1
};

Clockwork.crafting:Register(BLUEPRINT);