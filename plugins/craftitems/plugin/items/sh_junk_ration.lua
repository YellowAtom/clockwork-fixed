local ITEM = Clockwork.item:New();
ITEM.name = "Empty Ration Packet";
ITEM.cost = 2;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_packatc.mdl";
ITEM.uniqueID = "normal_empty_ration";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 8;
ITEM.weight = 0.1;
ITEM.business = false;
ITEM.description = "An empty standard ration packet. It's ready to be filled with goodies.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();