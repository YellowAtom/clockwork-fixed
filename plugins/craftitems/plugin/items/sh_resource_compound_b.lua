local ITEM = Clockwork.item:New();
ITEM.name = "Compound B";
ITEM.cost = 95;
ITEM.skin = 0;
ITEM.model = "models/mark2580/gtav/mp_apa_06/bathroom/prop_toilet_shamp_01_high.mdl";
ITEM.uniqueID = "compound_b";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 2;
ITEM.weight = 0.8;
ITEM.business = false;
ITEM.description = "A plastic container with some writing in black marker reading 'Compound B'.";

function ITEM:OnDrop(player, position) end;

ITEM:Register();