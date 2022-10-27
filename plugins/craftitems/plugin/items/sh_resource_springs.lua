local ITEM = Clockwork.item:New();
ITEM.name = "Springs";
ITEM.cost = 28;
ITEM.skin = 5;
ITEM.model = "models/fallout/components/box.mdl";
ITEM.uniqueID = "springs";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 4;
ITEM.weight = 0.1;
ITEM.business = false;
ITEM.description = "A cardboard box with the words 'Springs' written on it in a black marker.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();