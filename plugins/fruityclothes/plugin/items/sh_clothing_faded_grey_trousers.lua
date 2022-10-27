local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Faded Grey Trousers";
ITEM.cost = 28;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "faded_grey_trousers";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Legs";
ITEM.description = "Some rather dirty and faded looking grey trousers.";
ITEM.bodyGroup = 2;
ITEM.bodyGroupState = 10;
ITEM.bodyGroupName = "legs";
ITEM.spawnType = "misc";
ITEM.spawnValue = 7;


ITEM.isAnonymous = false;

 
ITEM:Register();
