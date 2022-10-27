local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Black Rebel Legs";
ITEM.cost = 125;
ITEM.uniqueID = "rebel_legs_black";
ITEM.weight = 0.3;
ITEM.invSpace = 4;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Legs";
ITEM.description = "A pair of rebel-style trousers, with knee supports, dyed black.";
ITEM.bodyGroup = 2;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupState = 12;
ITEM.bodyGroupName = "legs";
ITEM.spawnType = "misc";
ITEM.spawnValue = 1;
ITEM.protection = 0;
ITEM.maxArmor = 10;
ITEM.isAnonymous = false;

 
ITEM:Register();