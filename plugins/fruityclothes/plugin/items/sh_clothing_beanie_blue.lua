local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Black Beanie";
ITEM.cost = 32;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "black_beanie";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Headgear";
ITEM.description = "A clean looking black beanie.";
ITEM.bodyGroup = 4;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "headgear";
ITEM.protection = 0;
ITEM.spawnType = "misc";
ITEM.spawnValue = 4;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();