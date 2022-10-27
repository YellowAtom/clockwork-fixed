local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Blue Shirt";
ITEM.cost = 28;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "blue_shirt";
ITEM.weight = 0.2;
ITEM.invSpace = 2;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "A deep blue shirt with some kind of Union logo on the back.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 20;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 6;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();