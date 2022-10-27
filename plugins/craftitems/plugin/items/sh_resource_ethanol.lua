local ITEM = Clockwork.item:New();
ITEM.name = "Ethanol";
ITEM.cost = 120;
ITEM.skin = 0;
ITEM.model = "models/props_junk/glassjug01.mdl";
ITEM.uniqueID = "ethanol";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 4;
ITEM.weight = 0.4;
ITEM.business = false;
ITEM.description = "A glass beaker containing Ethanol.";

function ITEM:OnDrop(player, position) end;

ITEM:Register();