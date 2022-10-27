local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Civil Medic Worker Shirt";
ITEM.uniqueID = "cmu_shirt";
ITEM.weight = 0.2;
ITEM.invSpace = 2;
ITEM.useText = "Wear";
ITEM.batch = 1;
ITEM.category = "Clothing - Torso";
ITEM.description = "Standard CMU shirt issued to workers.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 2;
ITEM.bodyGroupName = "torso";
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();