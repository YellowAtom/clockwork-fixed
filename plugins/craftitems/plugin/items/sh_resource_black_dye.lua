local ITEM = Clockwork.item:New();
ITEM.name = "Black Dye";
ITEM.cost = 25;
ITEM.model = "models/props_junk/metal_paintcan001a.mdl";
ITEM.uniqueID = "black_dye";
ITEM.weight = 0.60;
ITEM.business = false;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 4;
ITEM.description = "A small paint can filled with black dye.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();