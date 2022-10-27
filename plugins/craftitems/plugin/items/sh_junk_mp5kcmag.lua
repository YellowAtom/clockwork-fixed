local ITEM = Clockwork.item:New();
ITEM.name = "Mp5K C Clip";
ITEM.cost = 45;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_eq_eholster.mdl";
ITEM.uniqueID = "mp5kc_magazine";
ITEM.weight = 0.10;
ITEM.business = false;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 1;
ITEM.description = "A magazine for the Mp5K C Sub-Machine Gun. The gun is chambered in 5.7x28mm rounds.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();