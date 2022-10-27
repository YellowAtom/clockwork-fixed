local ITEM = Clockwork.item:New();
ITEM.name = "Cloth";
ITEM.cost = 5;
ITEM.skin = 0;
ITEM.model = "models/props_wasteland/prison_toiletchunk01f.mdl";
ITEM.uniqueID = "cloth";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 8;
ITEM.weight = 0.1;
ITEM.business = false;
ITEM.description = "A peice of cloth. You could use this cloth to make clothing, if you had a thread.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();