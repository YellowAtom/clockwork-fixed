local Clockwork = Clockwork;

local ITEM = Clockwork.item:New("equipable_item_base", true);
ITEM.name = "Backpack Base";
ITEM.uniqueID = "backpack_base";
ITEM.model = "models/props_c17/suitcase_passenger_physics.mdl";
ITEM.actualWeight = 2; -- The real, actual weight of the item (as opposed to the perceived weight)
ITEM.invSpace = 4; -- The amount of additional space this item gives when equipped
ITEM.slot = "back"; -- The slot it goes in
ITEM.slotSpace = 10; -- The amount of space it takes up in said slot
ITEM.useText = "Equip";
ITEM.category = "Storage";
ITEM.description = "A nice black backpack that can hold stuff.";

ITEM:AddData("PerceivedWeight", -1, true);
ITEM:AddData("AddInvSpace", 0, true);
ITEM:AddData("Equipped", false, true);

-- Called when the player equips the item.
function ITEM:OnWearEquipableItem(player, bIsWearing)
	if (bIsWearing) then
		-- Occupy slot on the player's backpack table
		local backpackTable = player:GetCharacterData("backpackTable");
		backpackTable[self("slot")] = math.Clamp((backpackTable[self("slot")] or 0) + self("slotSpace"), 0, 10);
		player:SetCharacterData("backpackTable", backpackTable);
		self:SetData("Equipped", true);

		if (self.OnEquip) then
			self:OnEquip(player);
		end;
	else
		-- Free slot on the player's backpack table
		local backpackTable = player:GetCharacterData("backpackTable");
		backpackTable[self("slot")] = math.Clamp(backpackTable[self("slot")] - self("slotSpace"), 0, 10);
		player:SetCharacterData("backpackTable", backpackTable);

		if (self.OnUnequip) then
			self:OnUnequip(player);
		end;
	end;
end;

function ITEM:GetPerceivedWeight()
	if (self:GetData("Equipped") == true) then
		return 0;
	else
		return self("actualWeight");
	end;
end;
ITEM:AddQueryProxy("weight", ITEM.GetPerceivedWeight);

function ITEM:GetAddInvSpace()
	if (self:GetData("Equipped") == true) then
		return self("invSpace");
	else
		return 0;
	end;
end;
ITEM:AddQueryProxy("addInvSpace", ITEM.GetAddInvSpace);

-- Called when the player tries to equip the item.
function ITEM:CanPlayerWear(player, itemEntity)
	if (self.CanEquip and !self:CanEquip(player)) then
		return false;
	end;

	local backpackTable = player:GetCharacterData("backpackTable");
	
		if (!backpackTable or !backpackTable[self("slot")] or (backpackTable[self("slot")] + self("slotSpace") <= 10)) then
			return true;
		else
			Clockwork.player:Notify(player, "You can't wear anything more in this slot!");
		end;

	return false;
end;

-- Called when a player has unequipped the item.
function ITEM:OnPlayerUnequipped(player, extraData)
	if (player:GetInventoryWeight() + self("actualWeight") > (player:GetMaxWeight() - self("addInvSpace"))) then
		Clockwork.player:Notify(player, "You don't have enough inventory space to unequip this!");
		return false;
	end;
	
	self:SetData("Equipped", false);
	self:OnWearItem(player, false);
	player:RebuildInventory();
end;

function ITEM:CanGiveStorage(player, storageTable)
	if (player:IsWearingItem(self)) then
		Clockwork.player:Notify(player, "You cannot store this while you are wearing it!");
		return false;
	end;
end;

-- Called when a player attempts to take the item from storage.
function ITEM:CanTakeStorage(player, storageTable)
	local target = Clockwork.entity:GetPlayer(storageTable.entity);
	
	if (target) then
		if (target:GetInventoryWeight() > (target:GetMaxWeight() - self("addInvSpace"))) then
			return false;
		end;
	end;
end;

if (SERVER) then
	function ITEM:OnInstantiated()
		-- Set initial value of the perceived weight
		if (self:GetData("PerceivedWeight") == -1) then
			self:SetData("PerceivedWeight", self("actualWeight"));
		end;
	end;
else
	function ITEM:GetClientSideInfo()
		if (!self:IsInstance()) then 
			return; 
		end;

		local clientSideInfo = ""
		
		clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Maximum Carry Weight: "..math.Round(self("invSpace")));
		clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Slot: "..self("slot").." ("..self("slotSpace").."/10)");

		if (self:GetData("Equipped", false)) then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Is Wearing: Yes");
		else
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Is Wearing: No");
		end;
		
		return (clientSideInfo != "" and clientSideInfo);
	end;
end;

Clockwork.item:Register(ITEM);