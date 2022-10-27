local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Glasses";
ITEM.cost = 40;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "fruity_glasses";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Eyewear";
ITEM.description = "A pair of spectacles for those with inferior eyes, also for cosmetic purposes if you're really that way inclined.";
ITEM.bodyGroup = 6;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "glasses";
ITEM.spawnType = "misc";
ITEM.spawnValue = 5;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();
