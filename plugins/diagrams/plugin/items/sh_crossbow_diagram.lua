--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("diagram_base");
ITEM.name = "Crossbow Diagram";
ITEM.model = "models/props_lab/binderredlabel.mdl";
ITEM.weight = 0.20;
ITEM.cost = 880;
ITEM.batch = 1;
ITEM.access = "v";
ITEM.business = true;
ITEM.spawnType = "misc";
ITEM.spawnValue = 1;
ITEM.description = "A large red book with the words 'Crossbow Diagram by Harold Pair' written on it in yellow marker.";
ITEM.blueprintID = "broken_crossbow";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();