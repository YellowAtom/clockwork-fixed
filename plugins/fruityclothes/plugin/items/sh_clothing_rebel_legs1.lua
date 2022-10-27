local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Padded Rebel Legs (Green)";
ITEM.cost = 110;
ITEM.uniqueID = "rebel_legs_green";
ITEM.weight = 0.3;
ITEM.invSpace = 3;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Legs";
ITEM.description = "A pair of padded resistance leggings, with a green colour.";
ITEM.bodyGroup = 2;
ITEM.access = "v";
ITEM.batch = 1;
ITEM.business = true;
ITEM.bodyGroupState = 5;
ITEM.bodyGroupName = "legs";
ITEM.spawnType = "misc";
ITEM.spawnValue = 1;
ITEM.protection = 0;
ITEM.maxArmor = 10;
ITEM.isAnonymous = false;

 
ITEM:Register();