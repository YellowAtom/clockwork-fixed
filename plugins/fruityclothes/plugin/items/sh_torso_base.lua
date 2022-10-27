local PLUGIN = PLUGIN;
local ITEM = Clockwork.item:New(nil, true);
ITEM.name = "Torso Base";
ITEM.uniqueID = "torso_base";
ITEM.model = "models/props_c17/suitcase_passenger_physics.mdl";
ITEM.invSpace = 3; -- The amount of additional space this item gives when equipped
ITEM.weight = 2;
ITEM.useText = "Wear";
ITEM.category = "Clothing";
ITEM.description = "A nice torso that can hold stuff.";
ITEM.bodyGroup = 1; -- Bodygroup category
ITEM.bodyGroupState = 3; -- Bodygroup number
ITEM.bodyGroupName = "torso"; -- torso, legs, hands, headgear, bag, glasses, satchel, pouch, badge, armbands, headstrap, kevlar
ITEM.isAnonymous = false; -- Is the player anonymous when wearing this item?
ITEM.protection = 0;
ITEM.maxArmor = 0;

ITEM:AddData("AddInvSpace", 0, true);
ITEM:AddData("equipped", false, true);
ITEM:AddData("armor", -1, true);

-- Localization
local dataGroup = dataGroupState;
local dataGroupState = dataGroupState;

-- Called when a player wears the accessory.
function ITEM:OnWearItem(player, bIsWearing)
	if (self:GetData("equipped") == false) or (!bIsWearing) then
		self:SetData("armor", math.Clamp(player:Armor(), 0, self("maxArmor")));
		player:SetArmor(0);
		player:SetSharedVar("isConcealed", false);
	else
		player:SetMaxArmor(self("maxArmor"));
		player:SetArmor(self:GetData("armor"));
		player:SetSharedVar("isConcealed", self.isAnonymous);
	end;
end;

-- Called for the client to figure out whether the player has the item equipped or something
function ITEM:HasPlayerEquipped(player, bIsValidWeapon)
	return self:GetData("equipped", false);
end;

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
				player:SetBodygroup(dataGroup, dataGroupState);

				if (PLUGIN:GetAnimatedLegsEnabled()) then
					local model = player:GetModel();
					local data = {}; data[model] = {};
					data[model][tostring(dataGroup)] = dataGroupState;
					data["noReset"] = true;

					Clockwork.datastream:Start(player, "UpdateAnimatedLegs", data);
				end;
				
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

-- Custom function for getting the added inventory space
function ITEM:GetAddInvSpace()
	if (self:GetData("equipped") == true) then
		return self("invSpace");
	else
		return 0;
	end;
end;
ITEM:AddQueryProxy("addInvSpace", ITEM.GetAddInvSpace);

-- Function define when player attempts to wear the item
function ITEM:CanPlayerWear(player, itemEntity)
	if (!self.CanPlayerWearBodyPart or self:CanPlayerWearBodyPart(player, itemEntity) != false) then
		return true;
	end;

	return false;
end;

-- Called when player attempts to wear the item
function ITEM:CanPlayerWearBodyPart(player, itemEntity)
	local items = player:GetInventory();
	for k, itemList in pairs(items) do
		for k, item in pairs(itemList) do
			if (!item:IsBasedFrom("torso_base")) then
				break;
			elseif (item:GetData("equipped") and item("bodyGroupName") == self("bodyGroupName")) then
				Clockwork.player:Notify(player, "I am already wearing something on this part of my body!");
				return false;
			end;
		end;
	end;
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

		if (PLUGIN:GetAnimatedLegsEnabled()) then
			local model = player:GetModel();
			local data = {}; data[model] = {};
			data[model][tostring(dataGroup)] = dataGroupState;
			data["noReset"] = true;

			Clockwork.datastream:Start(player, "UpdateAnimatedLegs", data);
		end;
		
	end;
	
	self:SetData("equipped", false);
	self:OnWearItem(player, false);
	player:SetSharedVar("isConcealed", false);
	player:RebuildInventory();     
end;

-- Called when player attempts to give item to storage
function ITEM:CanGiveStorage(player, storageTable)
	if (self:GetData("equipped", true)) then
		Clockwork.player:Notify(player, "You cannot store this while you are wearing it!");
		return false;
	end;
end;

-- Called when a player attempts to take the item from storage.
function ITEM:CanTakeStorage(player, storageTable)
	local target = Clockwork.entity:GetPlayer(storageTable.entity);
	
	if (target) then
		if (target:GetInventoryWeight() > (target:GetMaxWeight() - self("addInvSpace"))) then
			Clockwork.player:Notify(player, "I don't think I can carry this..");
			return false;
		end;
	end;
end;

-- Called when the item is dropped
function ITEM:OnDrop(player, position)
	if (self:GetData("equipped") == true) then
		Clockwork.player:Notify(player, "You cannot drop this while you are wearing it!");
		return false;
	end;
end;

--Shared functions
if (SERVER) then
	function ITEM:OnInstantiated()
		if (self:GetData("armor") == -1) then
			self:SetData("armor", self("maxArmor"));
		end;
	end;
else
	function ITEM:GetClientSideInfo()
		
		if (!self:IsInstance()) then return; end;

		local clientSideInfo = ""
		
		clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "- Maximum Carry Weight: "..math.Round(self("invSpace")));
		
		if (self:GetData("equipped", true)) then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "- Is Wearing: Yes");
		else
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "- Is Wearing: No");
		end;

		local armor = self:GetData("armor");
		if (self:GetData("equipped", true)) then
			armor = Clockwork.Client:Armor();
		end;
		
		clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "- Armor: "..math.floor(armor));
		clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "- Protection: "..math.floor(100 * self("protection")).."%");
		
		return (clientSideInfo != "" and clientSideInfo);
	end;
end;

Clockwork.item:Register(ITEM);