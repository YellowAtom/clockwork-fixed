local ITEM = Clockwork.item:New();
ITEM.name = "Broken Mp7";
ITEM.cost = 300;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_smg1.mdl";
ITEM.uniqueID = "broken_mp7_craft";
ITEM.weight = 2.30;
ITEM.business = false;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 1;
ITEM.isRareSpawn = true;
ITEM.description = "A destroyed Mp7. The clip appears to be missing, and the bolts and receiver are broken. It's also scratched and dented.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();