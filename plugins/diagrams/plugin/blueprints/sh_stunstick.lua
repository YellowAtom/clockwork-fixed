local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Stunstick";
BLUEPRINT.uniqueID = "stunstick";
BLUEPRINT.model = "models/weapons/w_stunbaton.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "A fixed stunstick. It has a slider with four settings on the side of it.";
BLUEPRINT.itemRequirements = {
	broken_stunstick = 1,
	circuit_box = 3,
	screw_driver = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	broken_stunstick = 1,
	circuit_box = 3
};
BLUEPRINT.giveItems = {
	cw_customstunstick = 1
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