local ITEM = Clockwork.item:New();
ITEM.name = "Broken .357";
ITEM.cost = 75;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_357.mdl";
ITEM.uniqueID = "empty_357";
ITEM.weight = 0.30;
ITEM.business = false;
--ITEM.spawnType = "crafting";
--ITEM.isRareSpawn = true;
--ITEM.spawnValue = 1;
ITEM.description = "This .357 magnum revolver has some vital parts missing from it, including ammunition. You need to learn how to fix this before attempting anything.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();