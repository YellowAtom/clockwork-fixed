local ITEM = Clockwork.item:New();
ITEM.name = "Broken Mp5K C";
ITEM.cost = 45;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_synergy_mp5k.mdl";
ITEM.uniqueID = "broken_mp5kc";
ITEM.weight = 0.10;
ITEM.business = false;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 1;
ITEM.description = "A broken Mp5K C Sub-Machine Gun. It's battered up and practically unuseable.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();