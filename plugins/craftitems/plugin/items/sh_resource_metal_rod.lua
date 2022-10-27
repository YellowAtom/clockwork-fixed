local ITEM = Clockwork.item:New();
ITEM.name = "Metal Rods";
ITEM.cost = 20;
ITEM.skin = 0;
ITEM.model = "models/items/crossbowrounds.mdl";
ITEM.uniqueID = "metal_rods";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 8;
ITEM.weight = 0.9;
ITEM.business = false;
ITEM.description = "A collection of metal rods bound together with a rubber band.";

function ITEM:OnDrop(player, position) end;

ITEM:Register();