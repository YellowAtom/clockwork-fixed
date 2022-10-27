local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Confederate Cap";
ITEM.cost = 70;
ITEM.uniqueID = "confederate_cap";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Headgear";
ITEM.description = "An old, pre-war confederate hat. It's fairly battered, but it looks cool.";
ITEM.bodyGroup = 4;
ITEM.bodyGroupState = 3;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupName = "headgear";
ITEM.spawnType = "misc";
ITEM.spawnValue = 3;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();
