local ITEM = Clockwork.item:New();
ITEM.name = "Broken 9mm Pistol";
ITEM.cost = 58;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_pistol.mdl";
ITEM.uniqueID = "empty_pistol";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 1;
ITEM.isRareSpawn = true;
ITEM.weight = 0.5;
ITEM.business = false;
ITEM.description = "This pistol has some vital parts missing from it, including ammunition. You need to learn how to fix this before attempting anything.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();