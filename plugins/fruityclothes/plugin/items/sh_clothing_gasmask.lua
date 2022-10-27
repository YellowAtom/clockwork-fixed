local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Gas Mask";
ITEM.cost = 180;
ITEM.uniqueID = "fruity_gasmask";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Headstrap";
ITEM.description = "A dirty old dark grey gasmask, still operational.";
ITEM.bodyGroup = 10;
ITEM.bodyGroupState = 4;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupName = "headstrap";
ITEM.spawnType = "misc";
ITEM.spawnValue = 1;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = true;


ITEM:Register();