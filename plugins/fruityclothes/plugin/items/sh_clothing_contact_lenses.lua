local ITEM = Clockwork.item:New("torso_base");
ITEM.name = "Contact Lenses";
ITEM.cost = 15;
ITEM.access = "7";
ITEM.business = true;
ITEM.batch = 1;
ITEM.uniqueID = "contact_lenses";
ITEM.weight = 0.1;
ITEM.invSpace = 0;
ITEM.useText = "Wear";
ITEM.category = "Clothing - Eyewear";
ITEM.description = "Contact lenses to compensate your loss of perfect vision.";
ITEM.bodyGroup = 6;
ITEM.bodyGroupState = 0;
ITEM.bodyGroupName = "glasses";
ITEM.protection = 0;
ITEM.spawnType = "misc";
ITEM.spawnValue = 7;
ITEM.maxArmor = 0;
ITEM.isAnonymous = false;
 
-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	-- defining the localization
	dataGroupState = self("bodyGroupState");
	dataGroup = self("bodyGroup");
	
	local targetBodyGroups = player:GetCharacterData("bodygroups") or {};
	local model = player:GetModel();
	
	if (player:Alive() and !player:IsRagdolled()) then
		if (self:GetData("equipped") != true) then
			if (!self.CanPlayerWear or self:CanPlayerWear(player, itemEntity) != false) then
				self:SetData("equipped", true);
				self:OnWearItem(player, true);
				player:RebuildInventory();
				
				if( dataGroup < player:GetNumBodyGroups() )then
					targetBodyGroups[model] = targetBodyGroups[model] or {};
                       
					if( dataGroupState == 0 )then
						targetBodyGroups[model][tostring(dataGroup)] = nil;
					else
						targetBodyGroups[model][tostring(dataGroup)] = dataGroupState;
					
					end;
					
				player:SetCharacterData("bodygroups", targetBodyGroups);
				player:SetCharacterData("wearingLenses", "Yes");
				player:SetSharedVar("wearingLenses", 1);
				player:SetBodygroup(dataGroup, dataGroupState);
				
				return true;
				end;
			end;
		else
			Clockwork.player:Notify(player, "You are already wearing this item!");
		end;
	else
		Clockwork.player:Notify(player, "You cannot do this action at the moment!");
	end;
	
	return false;
end;

-- Called when a player has unequipped the item.
function ITEM:OnPlayerUnequipped(player, extraData)
	-- defining the localization
	dataGroupState = 0;
	dataGroup = self("bodyGroup");
	
	local targetBodyGroups = player:GetCharacterData("bodygroups") or {};
	local model = player:GetModel();
	
	if (player:GetInventoryWeight() + self("weight") > (player:GetMaxWeight() - self("addInvSpace"))) then
		Clockwork.player:Notify(player, "You don't have enough inventory space to unequip this!");
		return false;
	end;		
	
	if( dataGroup < player:GetNumBodyGroups() )then
		targetBodyGroups[model] = targetBodyGroups[model] or {};
                       
		if( dataGroupState == 0 )then
			targetBodyGroups[model][tostring(dataGroup)] = nil;
		else
			targetBodyGroups[model][tostring(dataGroup)] = dataGroupState;
		end;
					
		player:SetCharacterData("bodygroups", targetBodyGroups);
		player:SetBodygroup(dataGroup, dataGroupState);
		
	end;
	
	self:SetData("equipped", false);
	self:OnWearItem(player, false);
	player:SetSharedVar("isConcealed", false);
	player:SetCharacterData("wearingLenses", "No");
	player:SetSharedVar("wearingLenses", 0);
	player:RebuildInventory();     
end;

-- Called when a player wears the accessory.
function ITEM:OnWearItem(player, bIsWearing)
	if (self:GetData("equipped") == false) or (!bIsWearing) then
		self:SetData("armor", math.Clamp(player:Armor(), 0, self("maxArmor")));
		player:SetArmor(0);
		player:SetSharedVar("isConcealed", false);
		player:SetSharedVar("wearingLenses", 0);
		player:SetCharacterData("wearingLenses", "No");
	else
		player:SetMaxArmor(self("maxArmor"));
		player:SetArmor(self:GetData("armor"));
		player:SetSharedVar("isConcealed", self.isAnonymous);
		player:SetSharedVar("wearingLenses", 1);
		player:SetCharacterData("wearingLenses", "Yes");
	end;
end;

ITEM:Register();