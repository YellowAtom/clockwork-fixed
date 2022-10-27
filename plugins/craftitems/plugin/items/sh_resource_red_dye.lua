local ITEM = Clockwork.item:New();
ITEM.name = "Red Dye";
ITEM.cost = 30;
ITEM.model = "models/props_junk/metal_paintcan001a.mdl";
ITEM.uniqueID = "red_dye";
ITEM.weight = 0.60;
ITEM.business = false;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 4;
ITEM.description = "A small paint can filled with red dye.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();