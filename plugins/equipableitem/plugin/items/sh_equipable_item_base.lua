local ITEM = Clockwork.item:New(nil, true);
ITEM.name = "Equipable Item Base";
ITEM.uniqueID = "equipable_item_base";
ITEM.model = "models/gibs/hgibs.mdl";
ITEM.weight = 0.5;
ITEM.useText = "Equip";
ITEM.description = "A base for equipable items.";

ITEM:AddData("equipped", false, true);

-- Called when the player equips the item.
-- Override this function if you need to add your own behaviour for when a player equips/unequips this item
function ITEM:OnWearEquipableItem(player, bIsWearing) end;

-- Called when the player tries to equip the item.
-- Override this functions if you need to add your own behaviour for if a player can equip this item
-- Returning false will keep a player from equipping it, returning true or nil will allow him to equip it
function ITEM:CanPlayerWear(player, itemEntity) end;

-- Called when a player equips the item.
function ITEM:OnWearItem(player, bIsWearing)
	self:SetData("equipped", bIsWearing);
	self:OnWearEquipableItem(player, bIsWearing);
end;

function ITEM:HasPlayerEquipped(player, bIsValidWeapon)
	return self:GetData("equipped", false);
end;

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	if (player:Alive() and !player:IsRagdolled()) then
		if (self:GetData("equipped") != true) then
			if (self:CanPlayerWear(player, itemEntity) != false) then
				self:SetData("equipped", true);
				self:OnWearItem(player, true);
				player:RebuildInventory();
				return true;
			end;
		else
			Clockwork.player:Notify(player, "You are already wearing this item!");
		end;
	else
		Clockwork.player:Notify(player, "You cannot do this action at the moment!");
	end;
	
	return false;
end;

function ITEM:OnPlayerUnequipped(player, extraData)
	self:OnWearItem(player, false);
	player:RebuildInventory();
end;

function ITEM:OnStorageGive(player, storageTable)
	if (self:GetData("equipped") == true) then
		self:OnWearItem(player, false);
	end;
end;

function ITEM:OnDrop(player, position)
	if (self:GetData("equipped") == true) then
		self:OnWearItem(player, false);
	end;
end;

Clockwork.item:Register(ITEM);