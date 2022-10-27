local ITEM = Clockwork.item:New("diagram_base");
ITEM.name = "Stunstick Diagram";
ITEM.model = "models/props_lab/binderbluelabel.mdl";
ITEM.weight = 0.5;
ITEM.cost = 100;
ITEM.batch = 1;
ITEM.access = "v";
ITEM.business = true;
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.description = "A lengthy book with information on how to repair a stunstick.";
ITEM.blueprintID = "stunstick";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();