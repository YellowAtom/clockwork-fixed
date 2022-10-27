local ITEM = Clockwork.item:New("diagram_base");
ITEM.name = "Mp7 Diagram";
ITEM.model = "models/props_c17/paper01.mdl";
ITEM.weight = 0.16;
ITEM.cost = 650;
ITEM.batch = 1;
ITEM.access = "v";
ITEM.business = true;
ITEM.spawnType = "misc";
ITEM.spawnValue = 1;
ITEM.description = "A very descriptive page that describes the Mp7 Sub-Machine Gun in great detail. The article shows a photo of a Mp7 and describes how to repair it.";
ITEM.blueprintID = "broken_mp7";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();