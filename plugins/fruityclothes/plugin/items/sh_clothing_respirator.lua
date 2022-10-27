local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Respirator";
ITEM.cost = 100;
ITEM.uniqueID = "respirator";
ITEM.weight = 0.2;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Headstrap";
ITEM.description = "A dark grey respirator mask, covering only your mouth and nose.";
ITEM.bodyGroup = 10;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupState = 2;
ITEM.bodyGroupName = "headstrap";
ITEM.spawnType = "misc";
ITEM.isRareSpawn = true;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = true;


ITEM:Register();