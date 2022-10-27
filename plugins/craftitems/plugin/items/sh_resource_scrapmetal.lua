local ITEM = Clockwork.item:New();
ITEM.name = "Scrap Metal";
ITEM.cost = 7;
ITEM.skin = 0;
ITEM.model = "models/props_debris/metal_panelshard01d.mdl";
ITEM.uniqueID = "scrap_metal";
ITEM.weight = 0.75;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 5;
ITEM.business = false;
ITEM.description = "A shard of scrap metal.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();