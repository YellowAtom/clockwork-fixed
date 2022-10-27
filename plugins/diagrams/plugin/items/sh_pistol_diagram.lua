--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("diagram_base");
ITEM.name = "Pistol Diagram";
ITEM.model = "models/props_lab/bindergraylabel01a.mdl";
ITEM.weight = 1;
ITEM.cost = 200;
ITEM.batch = 1;
ITEM.access = "v";
ITEM.business = true;
ITEM.spawnType = "misc";
ITEM.spawnValue = 2;
ITEM.description = "A booklet with various instructions on how to craft a pistol.";
ITEM.blueprintID = "pistol";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();