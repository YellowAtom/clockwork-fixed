local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Worker Shirt";
ITEM.uniqueID = "cwu_shirt";
ITEM.weight = 0.1;
ITEM.invSpace = 3;
ITEM.useText = "Wear";
ITEM.batch = 1;
ITEM.category = "Clothing - Torso";
ITEM.description = "Standard CWU Shirt.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 3;
ITEM.bodyGroupName = "torso";
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();