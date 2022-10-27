local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Worker Trousers";
ITEM.uniqueID = "cwu_legs";
ITEM.weight = 0.1;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.batch = 1;
ITEM.category = "Clothing - Legs";
ITEM.description = "Standard leg apparel for CWU workers.";
ITEM.bodyGroup = 2;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "legs";
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();
