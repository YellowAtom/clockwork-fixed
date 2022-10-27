local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Malignant Badge";
ITEM.uniqueID = "badge";
ITEM.weight = 0.1;
ITEM.batch = 1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Accessories";
ITEM.description = "A brown badge with words 'Malignant Resident' printed on it. Usually handed out to those with -6 penalty points.";
ITEM.bodyGroup = 9;
ITEM.bodyGroupState = 1;
ITEM.bodyGroupName = "badge";
ITEM.canSew = false;
ITEM.protection = 0;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;



ITEM:Register();

