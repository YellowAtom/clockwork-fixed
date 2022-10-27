local ITEM = Clockwork.item:New();
ITEM.name = "Broken Stunstick";
ITEM.cost = 80;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_stunbaton.mdl";
ITEM.uniqueID = "broken_stunstick";
ITEM.weight = 0.56;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 1;
ITEM.isRareSpawn = true;
ITEM.business = false;
ITEM.description = "A beaten up, rusty looking stunstick. It is missing many key components in order for it to function properly.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();