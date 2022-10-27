local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Green Jogging Trousers";
ITEM.cost = 95;
ITEM.access = "7";
ITEM.business = true;
ITEM.uniqueID = "refugee_legs";
ITEM.weight = 0.2;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Legs";
ITEM.description = "Some old, worn jogging trousers in an unappealing green colour.";
ITEM.bodyGroup = 2;
ITEM.bodyGroupState = 2;
ITEM.bodyGroupName = "legs";
ITEM.spawnType = "misc";
ITEM.spawnValue = 4;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();