local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Red Jacket";
ITEM.cost = 200;
ITEM.access = "7";
ITEM.business = true;
ITEM.uniqueID = "red_jacket";
ITEM.weight = 0.2;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "An almost waterproof jacket in a red and light grey colour scheme.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 16;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 1;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();