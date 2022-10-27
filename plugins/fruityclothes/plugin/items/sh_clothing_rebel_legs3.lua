local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Padded Rebel Legs (Blue)";
ITEM.cost = 110;
ITEM.uniqueID = "rebel_legs_blue";
ITEM.weight = 0.3;
ITEM.invSpace = 3;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Legs";
ITEM.description = "A pair of padded resistance leggings, with a blue colour.";
ITEM.bodyGroup = 2;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupState = 7;
ITEM.bodyGroupName = "legs";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.protection = 0;
ITEM.maxArmor = 10;
ITEM.isAnonymous = false;

 
ITEM:Register();