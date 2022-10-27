local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Pouch";
ITEM.cost = 75;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "pouch";
ITEM.weight = 0.1;
ITEM.invSpace = 3;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Storage";
ITEM.description = "A pouch, slung over the shoulder, with access on the front.";
ITEM.bodyGroup = 8;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "pouch";
ITEM.spawnType = "misc";
ITEM.spawnValue = 3;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();