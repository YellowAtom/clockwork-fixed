local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Goggles";
ITEM.uniqueID = "goggles";
ITEM.cost = 30;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.weight = 0.2;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Eyewear";
ITEM.description = "A goofy pair of goggles, they might provide eye protection if you're willing to wear them.";
ITEM.bodyGroup = 6;
ITEM.bodyGroupState = 2;
ITEM.bodyGroupName = "glasses";
ITEM.spawnType = "misc";
ITEM.spawnValue = 3;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();
