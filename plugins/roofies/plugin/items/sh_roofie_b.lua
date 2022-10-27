--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("alcohol_base");
ITEM.name = "Beer";
ITEM.uniqueID = "roofie_b";
ITEM.access = "q";
ITEM.business = true;
ITEM.batch = 1;
ITEM.cost = 350;
ITEM.model = "models/props_junk/garbage_glassbottle003a.mdl";
ITEM.useSound = "vo/npc/male01/whoops01.wav"
ITEM.weight = 0.9;
ITEM.category = "Drugs";
ITEM.category = "Consumables";
ITEM.attributes = {Strength = 2};
ITEM.description = "A fresh bottle of beer. Very refeshing.";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:GiveItem(Clockwork.item:CreateInstance("Empty Beer Bottle"), true)
	Clockwork.player:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, 180);
	Clockwork.player:Notify(player, "Oh shit! You've been drugged! This is bad!");
end;

ITEM:Register();