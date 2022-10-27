local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Beige Shirt";
ITEM.cost = 115;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "beige_shirt";
ITEM.weight = 0.1;
ITEM.invSpace = 3;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "An old beige shirt.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 6;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();
