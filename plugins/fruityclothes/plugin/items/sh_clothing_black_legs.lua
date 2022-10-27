local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Black Cargo Trousers";
ITEM.cost = 80;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "black_cargo_trousers";
ITEM.weight = 0.2;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Legs";
ITEM.description = "A pair of well-kept black cargo trousers.";
ITEM.bodyGroup = 2;
ITEM.bodyGroupState = 13;
ITEM.bodyGroupName = "legs";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();