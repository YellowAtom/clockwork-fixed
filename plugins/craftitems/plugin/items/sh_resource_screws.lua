local ITEM = Clockwork.item:New();
ITEM.name = "Screws";
ITEM.cost = 39;
ITEM.skin = 4;
ITEM.model = "models/fallout/components/box.mdl";
ITEM.uniqueID = "screws";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 3;
ITEM.weight = 0.2;
ITEM.access = "v";
ITEM.business = true;
ITEM.description = "A cardboard box with the words 'Screws' written on it in a black marker.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();