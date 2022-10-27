local ITEM = Clockwork.item:New();
ITEM.name = "Razor";
ITEM.uniqueID = "beard_razor";
ITEM.cost = 50;
ITEM.model = "models/halokiller38/fallout/weapons/melee/straightrazor.mdl";
ITEM.spawnValue = 3;
ITEM.spawnType = "misc";
ITEM.weight = 0.4;
ITEM.category = "Grooming"
ITEM.access = "1";
ITEM.business = false;
ITEM.batch = 1;
ITEM.useSound = "npc/antlion/idle1.wav";
ITEM.description = "An old-style metal razor with a fancy looking engraved blade, it looks rather blunt but it will get the job done.";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();