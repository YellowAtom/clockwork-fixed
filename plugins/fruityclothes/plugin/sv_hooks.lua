--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local PLUGIN = PLUGIN;

local Clockwork = Clockwork;

local CurTime = CurTime;

local math = math;
local Clamp = math.Clamp;

-- Called when a player has been ragdolled.
function PLUGIN:PlayerRagdolled(player, state, ragdoll)
	local modelGroups = player:GetCharacterData("bodygroups");
	local model = player:GetModel();
	local items = player:GetInventory();

	if( modelGroups and modelGroups[model] )then
		for bodyGroup, bodyGroupState in pairs(modelGroups[model])do
			ragdoll.entity:SetBodygroup(tonumber(bodyGroup), bodyGroupState);
		end;
	end;

	for k, itemList in pairs(items) do
		for k, item in pairs(itemList) do
			if (!item:IsBasedFrom("torso_base")) then
				break;
			elseif (item:GetData("equipped") and item:GetData("armor")) then
				item:SetData("armor", math.Clamp(player:Armor(), 0, item("maxArmor")));
			end;
		end;
	end;

	self:SaveClothesArmor(player);
end;

function PLUGIN:PostPlayerDeath(player)
	local ragdoll = player:GetRagdollEntity();

	if (!IsValid(ragdoll)) then return; end;

	local modelGroups = player:GetCharacterData("bodygroups");
	local model = ragdoll:GetModel();
	if( modelGroups and modelGroups[model] )then
		for bodyGroup, bodyGroupState in pairs(modelGroups[model])do
			ragdoll:SetBodygroup(tonumber(bodyGroup), bodyGroupState);
		end;
	end;
end;

-- Called when the player takes damage
function PLUGIN:EntityTakeDamage(entity, damageInfo)
	if (entity:IsPlayer()) then
		local attacker = damageInfo:GetAttacker();
		if (attacker:IsPlayer() or attacker:IsNPC()) then
		
		local items = entity:GetInventory();
			for k, itemList in pairs(items) do
				for k, item in pairs(itemList) do
					if (!item:IsBasedFrom("torso_base")) then
						break;
					elseif (item:GetData("equipped") and item:GetData("armor")) then
						if (item and item("protection") and item("protection") > 0) then
							damageInfo:ScaleDamage(1 - math.Clamp(item("protection"), 0, 1));
						end;
					end;
				end;
			end;
		end;
	end;
end;

-- Called when a player's default skin is needed
function PLUGIN:GetPlayerDefaultSkin(player)
	-- Check for a player-adjustable skin first
	local toggleSkin = player:GetCharacterData("toggle_skin", {});
	toggleSkin = toggleSkin[player:GetModel()];
	if (toggleSkin) then
		return toggleSkin;
	end;
	-- Check for a personal skin
	local skin = player:GetCharacterData("skins", {});
	skin = skin[player:GetModel()];
	if (skin) then
		return skin;
	end;
	-- Check for a class skin
	local class = Clockwork.class:FindByID(player:Team());
	if (class and class.skin) then
		return class.skin;
	end;
	-- Check for a faction skin
	local faction = Clockwork.faction:FindByID(player:GetFaction());
	if (faction and faction.skin) then
		return faction.skin;
	end;
	-- No skin found so return nothing
end;

function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	local items = player:GetInventory();
	for k, itemList in pairs(items) do
		for k, item in pairs(itemList) do
			if (!item:IsBasedFrom("torso_base")) then
				break;
			elseif (item:GetData("equipped") and item:GetData("armor")) then
				player:SetMaxArmor(item("maxArmor"));
					if (item("isAnonymous")) then
						player:SetSharedVar("isConcealed", true);
					else
						player:SetSharedVar("isConcealed", false);
					end;
			else
				player:SetSharedVar("isConcealed", false);
			end;
		end;
	end;

	player:SetBodyGroups();
end;

-- Called when the player's model has been changed
function PLUGIN:PlayerModelChanged(player, model)
	player:SetBodyGroups();
	--player:SetPlayerScale();
end;

Clockwork.datastream:Hook("RequestBodygroups", function(player)
	local bodygroups = {};

	for k, v in pairs(player:GetCharacters()) do
		if (v.data.bodygroups) then
			bodygroups[k] = v.data.bodygroups;
		end;
	end;

	Clockwork.datastream:Start(player, "RequestBodygroups", bodygroups);
end);