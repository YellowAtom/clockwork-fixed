local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Satchel";
ITEM.cost = 90;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "satchel";
ITEM.weight = 0.1;
ITEM.invSpace = 9;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Storage";
ITEM.description = "A satchel, slung over the shoulder, with access on the rear.";
ITEM.bodyGroup = 7;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "satchel";
ITEM.spawnType = "misc";
ITEM.spawnValue = 3;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();