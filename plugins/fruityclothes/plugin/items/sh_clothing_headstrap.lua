local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Dust Mask";
ITEM.cost = 50;
ITEM.access = "v";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "dust_mask";
ITEM.cost = 68;
ITEM.weight = 0.2;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Headstrap";
ITEM.description = "A dark grey dust mask. It offers minimal protection, but it stops particulates to most effect.";
ITEM.bodyGroup = 10;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "headstrap";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = true;


ITEM:Register();