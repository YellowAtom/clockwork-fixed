local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Boonie Hat";
ITEM.cost = 90;
ITEM.uniqueID = "boonie_hat";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Headgear";
ITEM.description = "A green boonie hat. Perfect for keeping the rain off of your head.";
ITEM.bodyGroup = 4;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupState = 4;
ITEM.bodyGroupName = "headgear";
ITEM.protection = 0;
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();
