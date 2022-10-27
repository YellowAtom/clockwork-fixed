local ITEM = Clockwork.item:New();
ITEM.name = "Bobby Pin";
ITEM.cost = 45;
ITEM.category = "Tools";
ITEM.batch = 1;
ITEM.model = "models/Gibs/wood_gib01c.mdl";
ITEM.weight = .5;
ITEM.access = "v";
ITEM.uniqueID = "b_pin";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 3;
ITEM.business = false;
ITEM.description = "An old bobby pin. Maybe it could fit into a lock?";
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();