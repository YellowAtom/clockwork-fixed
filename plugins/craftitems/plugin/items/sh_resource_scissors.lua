local ITEM = Clockwork.item:New();
ITEM.name = "Scissors";
ITEM.cost = 13;
ITEM.skin = 0;
ITEM.model = "models/props_c17/tools_pliers01a.mdl";
ITEM.uniqueID = "scissors";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 8;
ITEM.weight = 0.3;
ITEM.business = false;
ITEM.description = "A large pair of black scissors. They look quite sharp.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();