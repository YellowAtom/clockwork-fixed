--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("accessory_base");
ITEM.name = "Heartbeat Scanner";
ITEM.cost = 2000;
ITEM.model = "models/gibs/shield_scanner_gib1.mdl";
ITEM.weight = 1.5;
ITEM.category = "Implants";
ITEM.business = false;
ITEM.description = "A device that allows you to sense the heartbeats of others.";

-- Called when a player wears the accessory.
function ITEM:OnWearAccessory(player, bIsWearing)
	if (bIsWearing) then
		player:SetSharedVar("implant", true);
	else
		player:SetSharedVar("implant", false);
	end;
end;

ITEM:Register();