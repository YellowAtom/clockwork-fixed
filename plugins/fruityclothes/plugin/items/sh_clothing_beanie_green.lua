local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Green Beanie";
ITEM.cost = 40;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "green_beanie";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Headgear";
ITEM.description = "A warm beanie of green colour, it's actually quite comfortable.";
ITEM.bodyGroup = 4;
ITEM.bodyGroupState = 2;
ITEM.bodyGroupName = "headgear";
ITEM.protection = 0;
ITEM.spawnType = "misc";
ITEM.spawnValue = 3;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();