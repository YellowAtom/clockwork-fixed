local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Blue Shirt Rolled Sleeves";
ITEM.cost = 30;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "citizen_torso_2";
ITEM.weight = 0.2;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "The top portion of a citizen uniform with the sleeves rolled up.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 5;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();