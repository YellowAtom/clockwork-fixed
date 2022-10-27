local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Rebel Molle Vest";
ITEM.cost = 650;
ITEM.uniqueID = "rebel_molle_kevlar";
ITEM.weight = 0.6;
ITEM.invSpace = 2;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Kevlar";
ITEM.description = "A new MOLLE vest. It offers great protection.";
ITEM.bodyGroup = 11;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupState = 5;
ITEM.bodyGroupName = "kevlar";
ITEM.protection = 0.25;
ITEM.maxArmor = 125;
ITEM.isAnonymous = false;


ITEM:Register();