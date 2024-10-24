
-----------------------------------------------------
--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local Clockwork = Clockwork;

local ITEM = Clockwork.item:New(nil, true);
ITEM.name = "Ammo Base";
ITEM.useText = "Load";
ITEM.useSound = false;
ITEM.category = "Ammunition";
ITEM.ammoClass = "pistol";
ITEM.ammoAmount = 0;
ITEM.roundsText = "Rounds";

ITEM:AddData("Rounds", -1, true);
ITEM:AddQueryProxy("ammoAmount", "Rounds", true);

-- A function to get the item's weight.
function ITEM:GetItemWeight()
	return (self.weight / self.ammoAmount) * self:GetData("Rounds");
end;

-- A function to get the item's space.
function ITEM:GetItemSpace()
	return (self.space / self.ammoAmount) * self:GetData("Rounds");
end;

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	local ammoAmount = self("ammoAmount");
	local ammoClass = self("ammoClass");

			player:GiveAmmo(ammoAmount, ammoClass);

			return;
		end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

if (SERVER) then
	function ITEM:OnInstantiated()
		self:SetData("Rounds", self("ammoAmount"));
	end;
else
	function ITEM:GetClientSideInfo()
		return Clockwork.kernel:AddMarkupLine(
			"", self("roundsText")..": "..self("ammoAmount")
		);
	end;
end;

ITEM:Register();
