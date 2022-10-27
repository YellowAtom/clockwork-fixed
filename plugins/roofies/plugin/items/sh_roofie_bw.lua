--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Breen's Water";
ITEM.uniqueID = "roofie_bw";
ITEM.cost = 300;
ITEM.business = true;
ITEM.batch = 1;
ITEM.access = "q";
ITEM.model = "models/props_lunk/popcan01a.mdl";
ITEM.weight = 0.6;
ITEM.useSound = "vo/npc/male01/whoops01.wav"
ITEM.useText = "Drink";
ITEM.category = "Consumables";
ITEM.description = "A blue aluminium can, it swishes when you shake it.";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:GiveItem(Clockwork.item:CreateInstance("Empty Breen's Water Can"), true)
	Clockwork.player:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, 180);
	Clockwork.player:Notify(player, "You've been drugged! This is bad!");
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

-- Called when the item's functions should be edited.
function ITEM:OnEditFunctions(functions)
	if (Schema:PlayerIsCombine(Clockwork.Client, false)) then
		for k, v in pairs(functions) do
			if (v == "Drink") then functions[k] = nil; end;
		end;
	end;
end;

ITEM:Register();