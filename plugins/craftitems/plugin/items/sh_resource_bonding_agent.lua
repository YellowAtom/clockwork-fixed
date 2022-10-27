local ITEM = Clockwork.item:New();
ITEM.name = "Bonding Agent";
ITEM.cost = 40;
ITEM.skin = 0;
ITEM.model = "models/props_lab/jar01b.mdl";
ITEM.uniqueID = "bonding_agent";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 6;
ITEM.weight = 0.8;
ITEM.business = false;
ITEM.description = "A plastic beaker containing a bonding agent.";

function ITEM:OnDrop(player, position) end;

ITEM:Register();