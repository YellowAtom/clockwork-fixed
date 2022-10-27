local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

-- Called when a player's character creation info should be adjusted.
function PLUGIN:PlayerAdjustCharacterCreationInfo(player, info, data)
	info.data["CustomizationOptions"] = Clockwork.kernel:Serialize(data.customizationOptions);
	info.data["GlassesOptions"] = Clockwork.kernel:Serialize(data.glassesButton);
end;

-- Called when a player's character screen info should be adjusted.
function PLUGIN:PlayerAdjustCharacterScreenInfo(player, character, info)
	info.customizationOptions = character.data["CustomizationOptions" or ""];
	info.glassesButton = character.data["GlassesOptions" or ""];
end;

-- Called when a player has been ragdolled.
function PLUGIN:PlayerRagdolled(player, state, ragdoll)
	for k, v in pairs(player.customizationOptions) do
		if (k != "Skin") then
		end;
	end;
end;

-- Called just after a player spawns.
function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	local customizationOptions = Clockwork.kernel:Deserialize(player:GetCharacterData("CustomizationOptions") or "");
	local glassesButton = Clockwork.kernel:Deserialize(player:GetCharacterData("GlassesOptions") or "");
	
	player:SetSharedVar("requiresGlasses", 0);
	
	if player:GetCharacterData("wearingLenses") == "Yes" then
		player:SetSharedVar("wearingLenses", 1);
	else
		player:SetSharedVar("wearingLenses", 0);
	end;

	for k, v in pairs(customizationOptions) do
		if (k == "Skin") then
			timer.Simple(.1, function()
				if (IsValid(player)) then
					player:ClockworkSetSkin(v);
				end;
			end);
		else
			timer.Simple(.1, function()
				if (IsValid(player)) then
					player:SetBodygroup(k, v);
				end;
			end);
		end;
	end;

	player.customizationOptions = customizationOptions;
	Clockwork.datastream:Start(player, "CustomizationOptions", customizationOptions);
	
	for k, v in pairs(glassesButton) do
		if (k == "Glasses" and v == 1) then
			if (!player:HasItemByID("fruity_glasses")) then
				player:GiveItem("fruity_glasses");
			end;
			
			player:SetSharedVar("requiresGlasses", 1);
		end;
	end;

	player.glassesButton = glassesButton;
	Clockwork.datastream:Start(player, "GlassesOptions", glassesButton);
	
	if (player:GetSharedVar("requiresGlasses") == 1 and player:GetBodygroup(6) == 0) then
		timer.Simple(1, function()
			if (IsValid(player)) then
				Clockwork.player:Notify(player, "I need my glasses on to see properly..");
			end;
		end);
	end;
end;

function PLUGIN:PlayerCharacterLoaded(player)
	local customizationOptions = Clockwork.kernel:Deserialize(player:GetCharacterData("CustomizationOptions") or "");
	local glassesButton = Clockwork.kernel:Deserialize(player:GetCharacterData("GlassesOptions") or "");
	
	player:SetSharedVar("requiresGlasses", 0);
	
	for k, v in pairs(customizationOptions) do
		if (k == "Skin") then
			timer.Simple(.1, function()
				if (IsValid(player)) then
					player:ClockworkSetSkin(v);
				end;
			end);
		else
			timer.Simple(.1, function()
				if (IsValid(player)) then
					player:SetBodygroup(k, v);
				end;
			end);
		end;
	end;

	player.customizationOptions = customizationOptions;
	Clockwork.datastream:Start(player, "CustomizationOptions", customizationOptions);
	
	for k, v in pairs(glassesButton) do
		if (k == "Glasses" and v == 1) then
			player:SetSharedVar("requiresGlasses", 1);
		end;
	end;

	player.glassesButton = glassesButton;
	Clockwork.datastream:Start(player, "GlassesOptions", glassesButton);
end;

Clockwork.datastream:Hook("CustomizationOptions", function(player, data)
	for k, v in pairs(data) do
		if (k == "Skin") then
			player:ClockworkSetSkin(v);
		elseif (tonumber(k) and tonumber(v)) then
			player:SetBodygroup(k, v);
		end;
	end;

	player.customizationOptions = data;
	player:SetCharacterData("CustomizationOptions", Clockwork.kernel:Serialize(data));
end);