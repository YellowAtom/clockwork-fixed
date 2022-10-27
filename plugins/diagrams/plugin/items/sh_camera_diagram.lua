local ITEM = Clockwork.item:New("diagram_base");
ITEM.name = "Camera Diagram";
ITEM.model = "models/props_lab/bindergreen.mdl";
ITEM.weight = 0.1;
ITEM.business = false;
ITEM.spawnType = "misc";
ITEM.spawnValue = 5;
ITEM.description = "A skinny green book with a large camera on the front of it underneath the title 'How To Fix Your Camera - For Dummies'.";
ITEM.blueprintID = "camera";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();