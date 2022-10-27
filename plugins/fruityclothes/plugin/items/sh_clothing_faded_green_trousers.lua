local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Faded Green Trousers";
ITEM.cost = 32;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "faded_green_trousers";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Legs";
ITEM.description = "Some rather dirty and faded looking green trousers.";
ITEM.bodyGroup = 2;
ITEM.bodyGroupState = 3;
ITEM.bodyGroupName = "legs";
ITEM.spawnType = "misc";
ITEM.spawnValue = 6;


ITEM.isAnonymous = false;

 
ITEM:Register();
