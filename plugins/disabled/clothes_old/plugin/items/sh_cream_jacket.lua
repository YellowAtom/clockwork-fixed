--[[
	© 2016 TeslaCloud Studios.
	Private code for Global Cooldown community.
	Stealing Lua cache is not nice lol.
	get a life kiddos.
--]]

local ITEM = Clockwork.item:New("bodygroup_base")
	ITEM.name = "Cream Jacket"
	ITEM.model = "models/props_c17/SuitCase_Passenger_Physics.mdl"
	ITEM.weight = 0.1
	ITEM.description = "A cream coloured jacket with a C17 patch sewn on the arm."
	ITEM.customFunctions = {"Remove"};
	ITEM.useSound = "npc/combine_soldier/zipline_clothing2.wav";
	
	ITEM.bodyGroup = 1
	ITEM.bodyGroupVal = 6
	ITEM.access = "7";
	ITEM.cost = 120;
	ITEM.business = true;
	
	if (SERVER) then
		function ITEM:OnCustomFunction(player)
			if (self:HasPlayerEquipped(player) and self.bodyGroup != -1) then
				player:SetBodygroupClothes(self, true)
			end
		end;
	end;
ITEM:Register();