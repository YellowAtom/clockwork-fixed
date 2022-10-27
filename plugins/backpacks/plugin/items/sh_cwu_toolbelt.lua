
local ITEM = Clockwork.item:New("backpack_base");
ITEM.name = "CWU toolbelt";
ITEM.uniqueID = "cwutoolbelt";
ITEM.business = true;
ITEM.model = "models/Items/CrossbowRounds.mdl";
ITEM.access = "1";
ITEM.cost = 45;
ITEM.batch = 1;
ITEM.actualWeight = 1;
ITEM.invSpace = 2;
ITEM.slot = "belt";
ITEM.slotSpace = 10;
ITEM.description = "A toolbelt, with UU logo on it, with two large pockets on the side and some slots for tools.";

ITEM:Register();