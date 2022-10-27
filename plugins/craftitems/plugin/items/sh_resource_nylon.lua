local ITEM = Clockwork.item:New();
ITEM.name = "Nylon";
ITEM.cost = 20;
ITEM.model = "models/fallout/components/spool_2.mdl";
ITEM.uniqueID = "nylon";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 9;
ITEM.weight = 0.2;
ITEM.business = false;
ITEM.description = "A spool with nylon wrapped around it.";

function ITEM:OnDrop(player, position) end;

ITEM:Register();