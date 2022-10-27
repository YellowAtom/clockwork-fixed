local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Brown Winter Coat";
ITEM.cost = 200;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "winter_coat";
ITEM.weight = 0.3;
ITEM.invSpace = 4;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "A warm brown winter coat.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 12;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();

