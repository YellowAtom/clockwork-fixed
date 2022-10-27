local ITEM = Clockwork.item:New();
ITEM.name = "Compound A";
ITEM.cost = 70;
ITEM.skin = 0;
ITEM.model = "models/mark2580/gtav/mp_apa_06/bathroom/prop_toilet_shamp_01_high.mdl";
ITEM.uniqueID = "compound_a";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 3;
ITEM.weight = 0.6;
ITEM.business = false;
ITEM.description = "A plastic container with some writing in black marker reading 'Compound A'.";

function ITEM:OnDrop(player, position) end;

ITEM:Register();