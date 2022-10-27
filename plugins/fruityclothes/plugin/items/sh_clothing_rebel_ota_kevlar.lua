local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Salvaged OTA vest";
ITEM.uniqueID = "rebel_ota_kevlar";
ITEM.batch = 1;
ITEM.weight = 1;
ITEM.invSpace = 6;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Kevlar";
ITEM.description = "A salvaged OTA vest. It offers the best protection around.";
ITEM.bodyGroup = 11;
ITEM.bodyGroupState = 3;
ITEM.bodyGroupName = "kevlar";
ITEM.protection = 0.3;
ITEM.maxArmor = 135;
ITEM.isAnonymous = false;


ITEM:Register();