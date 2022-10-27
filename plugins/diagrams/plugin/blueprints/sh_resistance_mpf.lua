local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Resistance MPF Uniform";
BLUEPRINT.model = "models/dpfilms/metropolice/resistance_police.mdl";
BLUEPRINT.uniqueID = "resitance_mpf_uniform_craft";
BLUEPRINT.category = "Clothing";
BLUEPRINT.description = "A slightly altered Metropolice uniform. This uniform provides level IIA ballistic protection.";
BLUEPRINT.itemRequirements = {
	spray_can = 1,
	black_dye = 1,
	ground_unit_uniform = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	black_dye = 1,
	ground_unit_uniform = 1
};
BLUEPRINT.giveItems = {
	resistance_mpf_uniform = 1
};

Clockwork.crafting:Register(BLUEPRINT);