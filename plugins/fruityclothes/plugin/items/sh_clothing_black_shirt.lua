local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Black Shirt";
ITEM.cost = 180;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "black_shirt2";
ITEM.weight = 0.2;
ITEM.invSpace = 3;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "A black jacket with pockets.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 22;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();