local ITEM = Clockwork.item:New();
ITEM.name = "Anti-Septic";
ITEM.cost = 24;
ITEM.skin = 4;
ITEM.model = "models/fallout/components/jar.mdl";
ITEM.uniqueID = "anti_septic";
ITEM.access = "1"
ITEM.batch = 1;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 6;
ITEM.weight = 0.1;
ITEM.business = true;
ITEM.description = "A brown jar with the words 'Anti-Septic' written on it.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();