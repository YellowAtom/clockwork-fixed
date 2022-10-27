local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Sling Backpack";
ITEM.cost = 100;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "sling_bag";
ITEM.weight = 0.5;
ITEM.invSpace = 9;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Storage";
ITEM.description = "A dark coloured backpack with a strap you can sling around your back.";
ITEM.bodyGroup = 5;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "bag";
ITEM.protection = 0;
ITEM.spawnType = "misc";
ITEM.spawnValue = 4;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;


ITEM:Register();

