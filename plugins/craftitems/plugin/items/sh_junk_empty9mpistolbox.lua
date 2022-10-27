local ITEM = Clockwork.item:New();
ITEM.name = "Empty 9mm Pistol Ammo";
ITEM.cost = 20;
ITEM.skin = 0;
ITEM.model = "models/Items/BoxSRounds.mdl";
ITEM.uniqueID = "empty_9mm_ammo";
ITEM.weight = 0.3;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 4;
ITEM.business = false;
ITEM.description = "An empty case of 9mm Pistol ammo.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();