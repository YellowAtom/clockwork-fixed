local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Pistol";
BLUEPRINT.uniqueID = "pistol";
BLUEPRINT.model = "models/weapons/w_pistol.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "A small pistol coated in a dull grey. It has a flashlight mounted to it.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 1,
	screws = 1,
	springs = 2,
	screw_driver = 1,
	empty_pistol = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 1,
	screws = 1,
	springs = 2,
	empty_pistol = 1
};
BLUEPRINT.giveItems = {
	weapon_pistol = 1
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