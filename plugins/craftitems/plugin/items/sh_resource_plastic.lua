local ITEM = Clockwork.item:New();
ITEM.name = "Plastic";
ITEM.cost = 12;
ITEM.skin = 0;
ITEM.model = "models/props_wasteland/prison_toiletchunk01j.mdl";
ITEM.uniqueID = "plastic_piece";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 7;
ITEM.weight = 0.1;
ITEM.business = false;
ITEM.description = "A piece of plastic.";

function ITEM:OnDrop(player, position) end;

function ITEM:OnEntitySpawned(entity)
entity:SetMaterial("models/XQM//Deg360");
end;


ITEM:Register();