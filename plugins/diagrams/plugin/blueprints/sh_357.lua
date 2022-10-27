local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = ".357 Magnum Revolver";
BLUEPRINT.uniqueID = "357_repair";
BLUEPRINT.model = "models/weapons/w_357.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Repair the .357 magnum revolver.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 3,
	screws = 2,
	springs = 1,
	screw_driver = 2,
	empty_357 = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 3,
	screws = 2,
	springs = 1,
	screw_driver = 2,
	empty_357 = 1
};
BLUEPRINT.giveItems = {
	weapon_357 = 1
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