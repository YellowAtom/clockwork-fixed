local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Grey Waterproof Jacket";
ITEM.cost = 200;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "beta_grey_jacket";
ITEM.weight = 0.2;
ITEM.invSpace = 2;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Torso";
ITEM.description = "A grey jacket with a Union logo on the back.";
ITEM.bodyGroup = 1;
ITEM.bodyGroupState = 19;
ITEM.bodyGroupName = "torso";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;

 
ITEM:Register();