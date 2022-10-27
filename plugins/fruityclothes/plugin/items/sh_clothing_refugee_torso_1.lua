local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Olive Shirt";
ITEM.cost = 135;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "olive_shirt";
ITEM.weight = 0.2;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "A slightly dirty green shirt.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 4;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 3;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();
