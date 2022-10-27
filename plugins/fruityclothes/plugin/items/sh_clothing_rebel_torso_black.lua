local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Rebel Black Torso";
ITEM.cost = 170;
ITEM.uniqueID = "rebel_black_torso";
ITEM.weight = 0.4;
ITEM.invSpace = 4;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "A black tactical suit, with ammo pouches and a salvaged CP utility belt.";
ITEM.bodyGroup = 1;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupState = 17;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 1;
ITEM.protection = 0;
ITEM.maxArmor = 50;
ITEM.isAnonymous = false;


ITEM:Register();