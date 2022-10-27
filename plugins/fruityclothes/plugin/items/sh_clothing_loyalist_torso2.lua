local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Black Jacket Rolled Sleeves";
ITEM.cost = 95;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "black_jacket_rolled";
ITEM.weight = 0.2;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "A black jacket with rolled up sleeves, even cooler.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 11;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 3;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();