--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("diagram_base");
ITEM.name = ".357 Diagram";
ITEM.model = "models/props_lab/binderredlabel.mdl";
ITEM.weight = 1;
ITEM.cost = 250;
ITEM.batch = 1;
ITEM.access = "v";
ITEM.business = true;
ITEM.spawnType = "misc";
ITEM.spawnValue = 1;
ITEM.description = "A booklet with various instructions on how to repair a .357 magnum revolver.";
ITEM.blueprintID = "357_repair";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();