local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Red Handkerchief";
ITEM.cost = 20;
ITEM.access = "7v";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "facewrap";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Headstrap";
ITEM.description = "A red handkerchief, could be used to conceal your face.";
ITEM.bodyGroup = 10;
ITEM.bodyGroupState = 3;
ITEM.bodyGroupName = "headstrap";
ITEM.protection = 0;
ITEM.spawnType = "misc";
ITEM.spawnValue = 6;
ITEM.maxArmor = 0;
ITEM.isAnonymous = true;


ITEM:Register();