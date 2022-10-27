local PLUGIN = PLUGIN;

-- For skins

-- Called just after a player spawns.
function PLUGIN:GetPlayerDefaultSkin(player)
	local skins = player:GetCharacterData("Skins");
	local model = player:GetModel();
	
	--Reset the player skin so character changes don't mess anything up.
	--player:SetSkin(0); --0
	
	if( skins and skins[model] )then
			return tonumber(skins[model]);
	end;
end;

-- For bodygroups

-- Called just after a player spawns.
function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	local modelGroups = player:GetCharacterData("BodyGroups");
	local model = player:GetModel();
	
	if( modelGroups and modelGroups[model] )then
		for bodygroupvalue, bodygroupstatevalue in pairs(modelGroups[model])do
			player:SetBodygroup(tonumber(bodygroupvalue), bodygroupstatevalue);
		end;
	end;
end;