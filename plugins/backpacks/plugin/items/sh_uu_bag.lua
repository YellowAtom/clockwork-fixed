
local ITEM = Clockwork.item:New("backpack_base");
ITEM.name = "UU Bag";
ITEM.uniqueID = "uubag";
ITEM.batch = 1;
ITEM.value = 6;
ITEM.type = "misc";
ITEM.business = true;
ITEM.access = "1";
ITEM.cost = 35;
ITEM.model = "models/props_junk/garbage_bag001a.mdl";
ITEM.actualWeight = 0.5;
ITEM.invSpace = 2;
ITEM.slot = "back";
ITEM.slotSpace = 3;
ITEM.description = "A cloth bag with UU logo on side. It's better than nothing...";

ITEM:Register();