--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New("Bird");
	CLASS.color = Color(50, 25, 0, 255);
	CLASS.factions = {FACTION_BIRD};
	CLASS.isDefault = true;
	CLASS.wagesName = "Supplies";
	CLASS.description = "A regular bird.";
	CLASS.defaultPhysDesc = "Wearing birdy clothes.";
CLASS_CITIZEN = CLASS:Register();