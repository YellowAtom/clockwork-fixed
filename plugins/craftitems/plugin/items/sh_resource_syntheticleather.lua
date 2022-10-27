local ITEM = Clockwork.item:New();
ITEM.name = "Synthetic Leather";
ITEM.cost = 35;
ITEM.model = "models/props_lab/jar01a.mdl";
ITEM.uniqueID = "synth_leather";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 6;
ITEM.weight = 0.3;
ITEM.description = "A white plastic jar with the words 'Synthetic Leather' written on it in pencil.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();