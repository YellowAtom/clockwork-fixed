local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Mp7 Sub-Machine Gun";
BLUEPRINT.uniqueID = "broken_mp7";
BLUEPRINT.model = "models/weapons/w_smg1.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Repair the Mp7 Sub-Machine Gun.";
BLUEPRINT.itemRequirements = {
	scrap_metal = 3,
	hammer_weapon = 1,
	screws = 4,
	screw_driver = 1,
	broken_mp7_craft = 1,
	mp7_magazine = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	scrap_metal = 3,
	hammer_weapon = 1,
	screws = 4,
	screw_driver = 1,
	broken_mp7_craft = 1,
	mp7_magazine = 1
};
BLUEPRINT.giveItems = {
	cw_smgnolaunch = 1,
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