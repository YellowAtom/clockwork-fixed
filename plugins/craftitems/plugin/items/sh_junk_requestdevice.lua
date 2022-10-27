local ITEM = Clockwork.item:New();
ITEM.name = "Empty Request Device";
ITEM.cost = 16;
ITEM.skin = 0;
ITEM.model = "models/gibs/shield_scanner_gib1.mdl";
ITEM.uniqueID = "empty_req";
ITEM.weight = 0.1;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 7;
ITEM.business = false;
ITEM.description = "This request device has ran out of batteries.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();