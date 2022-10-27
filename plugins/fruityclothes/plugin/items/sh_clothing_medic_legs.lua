local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Black Trousers";
ITEM.cost = 56;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "black_trousers";
ITEM.weight = 0.2;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Legs";
ITEM.description = "A worn pair of black trousers.";
ITEM.bodyGroup = 2;
ITEM.bodyGroupState = 9;
ITEM.bodyGroupName = "legs";
ITEM.spawnType = "misc";
ITEM.spawnValue = 5;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();