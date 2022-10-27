local ITEM = Clockwork.item:New("backpack_base");
ITEM.name = "Chest Rig";
ITEM.uniqueID = "chest_rig";
ITEM.business = true;
ITEM.access = "v";
ITEM.cost = 100;
ITEM.batch = 1;
ITEM.model = "models/props_junk/cardboard_box003b.mdl";
ITEM.actualWeight = 1.5;
ITEM.invSpace = 6;
ITEM.slot = "chest";
ITEM.slotSpace = 7;
ITEM.description = "A chest rig with pouches all over it, very good to keep things at hand.";

ITEM:Register();