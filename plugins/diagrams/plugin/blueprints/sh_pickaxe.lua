local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Pickaxe";
BLUEPRINT.uniqueID = "pickaxe_craft";
BLUEPRINT.model = "models/props_mining/pickaxe01.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Go mining... wait actually... you can't go mining...";
BLUEPRINT.itemRequirements = {
	scrap_metal = 5,
	wood_part = 3
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 5,
	wood_part = 3
};
BLUEPRINT.giveItems = {
	weapon_hl2pickaxe = 1
};

Clockwork.crafting:Register(BLUEPRINT);