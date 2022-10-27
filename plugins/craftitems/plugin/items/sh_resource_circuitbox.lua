local ITEM = Clockwork.item:New();
ITEM.name = "Circuit Box";
ITEM.cost = 120;
ITEM.skin = 0;
ITEM.model = "models/fallout/components/circuitry.mdl";
ITEM.uniqueID = "circuit_box";
ITEM.weight = 0.12;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 5;
ITEM.business = false;
ITEM.description = "A cardboard box containing some electrical circuits - very useful.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();