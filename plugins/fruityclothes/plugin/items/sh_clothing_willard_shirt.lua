local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "White Shirt";
ITEM.cost = 190;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "white_shirt";
ITEM.weight = 0.2;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "A pure white shirt.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 21;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.isRareSpawn = true;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();

