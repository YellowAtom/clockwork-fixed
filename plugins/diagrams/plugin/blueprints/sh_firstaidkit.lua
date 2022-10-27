local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "First-Aid Kit";
BLUEPRINT.uniqueID = "first_aid_craft";
BLUEPRINT.model = "models/w_models/weapons/w_eq_medkit.mdl";
BLUEPRINT.category = "Medical";
BLUEPRINT.description = "A rudimentary First-Aid Kit to tend to your wounds.";
BLUEPRINT.itemRequirements = {
    anti_septic = 1,
    cloth = 1,
    paracetamol = 1,
	bandage = 1,
	empty_firstaid = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
    anti_septic = 1,
    cloth = 1,
    paracetamol = 1,
	bandage = 1, 
	empty_firstaid = 1
};
BLUEPRINT.giveItems = {
    first_aid = 1
};

Clockwork.crafting:Register(BLUEPRINT);