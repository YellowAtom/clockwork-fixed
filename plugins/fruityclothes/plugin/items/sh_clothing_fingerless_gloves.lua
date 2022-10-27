local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Fingerless Gloves";
ITEM.cost = 18;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "fingerless_gloves";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Hands";
ITEM.description = "Keeps your hands warm, but not your fingers.";
ITEM.bodyGroup = 3;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "hands";
ITEM.protection = 0;
ITEM.spawnType = "misc";
ITEM.spawnValue = 5;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();