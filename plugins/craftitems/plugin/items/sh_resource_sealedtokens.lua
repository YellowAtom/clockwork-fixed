local ITEM = Clockwork.item:New();
ITEM.name = "Sealed Tokens";
ITEM.cost = 1;
ITEM.skin = 0;
ITEM.model = "models/props_lab/box01a.mdl";
ITEM.uniqueID = "sealed_tokens";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 6;
ITEM.weight = 0.1;
ITEM.business = false;
ITEM.description = "What the hell? They're sealed or something...";

function ITEM:OnDrop(player, position) end;
ITEM:Register();