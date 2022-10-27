local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Rebel-style Kevlar";
ITEM.cost = 350;
ITEM.uniqueID = "rebel_kevlar";
ITEM.weight = 0.4;
ITEM.invSpace = 1;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Kevlar";
ITEM.description = "A salvaged CP kevlar chest.";
ITEM.bodyGroup = 11;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupState = 2;
ITEM.bodyGroupName = "kevlar";
ITEM.spawnType = "misc";
ITEM.isRareSpawn = true;
ITEM.protection = 0.2;
ITEM.maxArmor = 50;
ITEM.isAnonymous = false;


ITEM:Register();