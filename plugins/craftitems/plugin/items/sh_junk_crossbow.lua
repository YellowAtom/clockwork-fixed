local ITEM = Clockwork.item:New();
ITEM.name = "Broken Crossbow";
ITEM.cost = 265;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_crossbow.mdl";
ITEM.uniqueID = "broken_crossbow_craft";
ITEM.weight = 2.37;
--ITEM.spawnType = "crafting";
--ITEM.spawnValue = 1;
--ITEM.isRareSpawn = true;
ITEM.description = "A destroyed crossbow. The pullback string is cut in two, and the release clutch is stuck, and a few bolts are missing from the crossbow. The scope also has a stick through it.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();