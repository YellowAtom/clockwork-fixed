local ITEM = Clockwork.item:New();
ITEM.name = "Smashed Camera";
ITEM.cost = 30;
ITEM.skin = 0;
ITEM.model = "models/maxofs2d/camera.mdl";
ITEM.uniqueID = "smashed_camera";
ITEM.weight = 0.27;
ITEM.business = false;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 7;
ITEM.description = "A beaten up looking camera with parts missing, the most noticable amount of damage is the massive screen crack in the lens.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();