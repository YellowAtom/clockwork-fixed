local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Blue Jogging Trousers";
ITEM.cost = 80;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "blue_jogging_trousers";
ITEM.weight = 0.2;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Legs";
ITEM.description = "A comfy pair of blue jogging trousers.";
ITEM.bodyGroup = 2;
ITEM.bodyGroupState = 4;
ITEM.bodyGroupName = "legs";
ITEM.spawnType = "misc";
ITEM.spawnValue = 6;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();