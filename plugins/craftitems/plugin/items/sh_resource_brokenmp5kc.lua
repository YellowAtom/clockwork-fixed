local ITEM = Clockwork.item:New();
ITEM.name = "Broken Mp5K C";
ITEM.cost = 300;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_synergy_mp5k.mdl";
ITEM.uniqueID = "broken_mp5kc_craft";
ITEM.weight = 2.0;
ITEM.business = false;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 1;
ITEM.isRareSpawn = true;
ITEM.description = "A destroyed Mp7K C. The clip appears to be missing, and the bolts and receiver are broken. It's also scratched and dented.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();