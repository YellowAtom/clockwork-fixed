local ITEM = Clockwork.item:New();
ITEM.name = "Wood Part";
ITEM.cost = 4;
ITEM.skin = 0;
ITEM.model = "models/gibs/furniture_gibs/furniturewooddrawer003a_chunk05.mdl";
ITEM.uniqueID = "wood_part";
ITEM.weight = 0.55;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 7;
ITEM.business = false;
ITEM.description = "A long shard of wood.";

function ITEM:OnEntitySpawned(entity)
entity:SetMaterial("models/props/CS_militia/roofbeams03");
end;

function ITEM:OnDrop(player, position) end;
ITEM:Register();