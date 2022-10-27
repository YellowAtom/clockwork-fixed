local ITEM = Clockwork.item:New();
ITEM.name = "Glass Piece";
ITEM.cost = 9;
ITEM.skin = 0;
ITEM.model = "models/props_junk/garbage_glassbottle003a_chunk02.mdl";
ITEM.uniqueID = "glass_piece";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 7;
ITEM.weight = 0.1;
ITEM.business = false;
ITEM.description = "A single glass piece, looks to have came from some kind of bottle.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();