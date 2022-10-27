local ITEM = Clockwork.item:New();
ITEM.name = "Thread";
ITEM.cost = 5;
ITEM.skin = 0;
ITEM.model = "models/fallout/components/spool_2.mdl";
ITEM.uniqueID = "thread";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 8;
ITEM.weight = 0.1;
ITEM.business = false;
ITEM.description = "A thread. You could use this thread to make clothing, if you had a some cloth.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();