local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Mp5k C Sub-Machine Gun";
BLUEPRINT.uniqueID = "broken_mp5kc";
BLUEPRINT.model = "models/weapons/w_synergy_mp5k.mdl";
BLUEPRINT.category = "Weapons";
BLUEPRINT.description = "Repair the Mp5K C Sub-Machine Gun.";
BLUEPRINT.itemRequirements = {
    scrap_metal = 2,
    hammer_weapon = 1,
    screws = 2,
    screw_driver = 2,
    broken_mp5kc_craft = 1,
    mp5kc_magazine = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
    scrap_metal = 2,
    hammer_weapon = 1,
    screws = 2,
    screw_driver = 2,
    broken_mp5kc_craft = 1,
    mp5kc_magazine = 1
};
BLUEPRINT.giveItems = {
    weapon_synergy_mp5k_c = 1
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