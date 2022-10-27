local ITEM = Clockwork.item:New();
ITEM.name = "Screw Driver";
ITEM.cost = 66;
ITEM.category = "Tools";
ITEM.uniqueID = "screw_driver";
ITEM.batch = 1;
ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl";
ITEM.weight = 1.3;
ITEM.access = "v";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 5;
ITEM.business = false;
ITEM.description = "An old rusted screwdriver. Maybe it could turn a lock?";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();