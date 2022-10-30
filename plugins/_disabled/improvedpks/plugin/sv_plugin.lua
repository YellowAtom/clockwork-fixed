--[[
	Plugin made by Ghost for Undetermined Gaming
	sv_plugin.lua file
--]]

local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

-- A function to permanently kill a player.
function PLUGIN:PKPlayer(player, ragdoll)
	if (player:Alive()) then
		player:Kill();
		ragdoll = player:GetRagdollEntity();
	end;
	
	local inventory = player:GetInventory();
	local cash = player:GetCash();
	local info = {};
	
	if (!player:GetCharacterData("permakilled")) then
		info.inventory = inventory;
		info.cash = cash;
		
		if (!IsValid(ragdoll)) then
			info.entity = ents.Create("cw_belongings");
		end;
		
		Clockwork.plugin:Call("PlayerAdjustPermaKillInfo", player, info);
		
		for k, v in pairs(info.inventory) do
			local itemTable = Clockwork.item:FindByID(k);
			
			if (itemTable and itemTable.allowStorage == false) then
				info.inventory[k] = nil;
			end;
		end;
		
		if (!IsValid(ragdoll)) then
			if (table.Count(info.inventory) > 0 or info.cash > 0) then
				info.entity:SetData(info.inventory, info.cash);
				info.entity:SetPos( player:GetPos() + Vector(0, 0, 48) );
				info.entity:Spawn();
			else
				info.entity:Remove();
			end;
		else
			ragdoll.areBelongings = true;
			ragdoll.inventory = info.inventory;
			ragdoll.cash = info.cash;
		end;
		
		Clockwork.player:SaveCharacter(player);
	end;
end;

-- A function to unPK a player.
function PLUGIN:UnPKPlayer(player, ragdoll)
	if (!player:Alive()) then
		Clockwork.player:LightSpawn(player, true, true);
	end;
	
	if (player:GetCharacterData("permakilled")) then		
		
		player:SetCharacterData("permakilled", false);
		
		Clockwork.player:SaveCharacter(player);
	end;
end;