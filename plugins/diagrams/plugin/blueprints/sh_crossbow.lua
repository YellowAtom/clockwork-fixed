local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Repair: Crossbow";
BLUEPRINT.uniqueID = "broken_crossbow";
BLUEPRINT.model = "models/weapons/w_crossbow.mdl";
BLUEPRINT.category = "Repair: Crossbow";
BLUEPRINT.description = "Repair the Crossbow.";
BLUEPRINT.itemRequirements = {
	screws = 1,
	plastic_piece = 2,
	blow_torch = 1,
	broken_crossbow_craft = 1,
	screw_driver = 1,
	bonding_agent = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	screws = 1,
	plastic_piece = 2,
	blow_torch = 1,
	broken_crossbow_craft = 1,
	bonding_agent = 1
};
BLUEPRINT.giveItems = {
	weapon_crossbow = 1
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