local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "NLAW Rocket Launcher";
BLUEPRINT.uniqueID = "broken_nlaw";
BLUEPRINT.model = "models/weapons/w_rocket_launcher.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Repair the NLAW Rocket Launcher.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 15,
	screws = 6,
	screw_driver = 1,
	broken_nlaw_craft = 1,
	nlaw_lasermodule = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 15,
	screws = 6,
	screw_driver = 1,
	broken_nlaw_craft = 1,
	nlaw_lasermodule = 1
};
BLUEPRINT.giveItems = {
	weapon_rpg = 1,
	screw_driver = 1
};

function BLUEPRINT:HasObjectAccess(player)
	local knownBlueprints;
	local hasAccess;

	if (SERVER) then
		knownBlueprints = player:GetCharacterData("KnownBlueprints");
	else
		knownBlueprints = Clockwork.KnownBlueprints;
	end;

	if (!knownBlueprints) then return; end;

	for k, v in pairs(knownBlueprints) do
		if (v:match(self("uniqueID"))) then
			hasAccess = true;
			break;
		end;
	end;

	return hasAccess;
end;

Clockwork.crafting:Register(BLUEPRINT);