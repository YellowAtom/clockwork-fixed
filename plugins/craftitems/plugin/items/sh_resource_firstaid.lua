local ITEM = Clockwork.item:New();
ITEM.name = "Empty First-Aid Kit";
ITEM.cost = 3;
ITEM.skin = 0;
ITEM.model = "models/w_models/weapons/w_eq_medkit.mdl";
ITEM.uniqueID = "empty_firstaid";
ITEM.weight = 0.1;
ITEM.spawnType = "crafting";
ITEM.category = "Junk"
ITEM.spawnValue = 8;
ITEM.business = false;
ITEM.description = "An empty first-aid kit. How useless.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();