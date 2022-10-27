local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Rebel Medic Kevlar";
ITEM.cost = 375;
ITEM.uniqueID = "rebel_medic_kevlar";
ITEM.weight = 0.3;
ITEM.invSpace = 4;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Kevlar";
ITEM.description = "A CP kevlar vest with a medical backpack.";
ITEM.bodyGroup = 11;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "kevlar";
ITEM.spawnType = "misc";
ITEM.isRareSpawn = true;
ITEM.protection = 0.2;
ITEM.maxArmor = 50;
ITEM.isAnonymous = false;


ITEM:Register();