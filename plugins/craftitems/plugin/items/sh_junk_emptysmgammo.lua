local ITEM = Clockwork.item:New();
ITEM.name = "Empty SMG Ammo";
ITEM.cost = 35;
ITEM.skin = 0;
ITEM.model = "models/items/boxmrounds.mdl";
ITEM.uniqueID = "smg_ammo_empty";
ITEM.weight = 0.4;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 3;
ITEM.business = false;
ITEM.description = "An empty case of SMG ammo.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();