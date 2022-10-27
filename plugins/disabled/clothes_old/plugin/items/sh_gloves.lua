--[[
	© 2016 TeslaCloud Studios.
	Private code for Global Cooldown community.
	Stealing Lua cache is not nice lol.
	get a life kiddos.
--]]

-- Has to be named as a beanie

local ITEM = Clockwork.item:New("bodygroup_base")
	ITEM.name = "Black Gloves"
	ITEM.model = "models/props_c17/SuitCase_Passenger_Physics.mdl"
	ITEM.weight = 0.1
	ITEM.description = "Black gloves."
	ITEM.customFunctions = {"Remove"};
	ITEM.useSound = "npc/combine_soldier/zipline_clothing2.wav";
	
	ITEM.bodyGroup = 3
	ITEM.bodyGroupVal = 1;
	ITEM.access = "7";
	ITEM.cost = 35;
	ITEM.business = true;
	
	if (SERVER) then
		function ITEM:OnCustomFunction(player)
			if (self:HasPlayerEquipped(player) and self.bodyGroup != -1) then
				player:SetBodygroupClothes(self, true)
			end
		end;
	end;
ITEM:Register();