--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("diagram_base");
ITEM.name = "N.L.A.W Diagram";
ITEM.model = "models/props_lab/bindergraylabel01b.mdl";
ITEM.weight = 1.22;
ITEM.business = false;
ITEM.description = "A mystic book with the letters '32' written on it, along with a small paragraph reading 'The final conclusion; the lamp has seeked knowledge from the fountain of the NLAW.'";
ITEM.blueprintID = "broken_nlaw";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();