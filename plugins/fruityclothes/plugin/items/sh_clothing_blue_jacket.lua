local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Blue Jacket";
ITEM.cost = 180;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "blue_jacket";
ITEM.weight = 0.2;
ITEM.invSpace = 3;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "An almost waterproof jacket in a blue and light grey colour scheme.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 14;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();