local ITEM = Clockwork.item:New();
ITEM.name = "Gunpowder";
ITEM.cost = 120;
ITEM.skin = 0;
ITEM.model = "models/props_lab/jar01b.mdl";
ITEM.uniqueID = "gunpowder";
ITEM.weight = 0.40;
ITEM.access = "V";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 3;
ITEM.batch = 1;
ITEM.business = true;
ITEM.description = "A jar filled with gunpowder.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();