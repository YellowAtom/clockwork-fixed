local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Turquoise Jacket";
ITEM.cost = 210;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "turquoise_jacket";
ITEM.weight = 0.2;
ITEM.invSpace = 2;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "A turquoise jacket.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 15;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 1;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();