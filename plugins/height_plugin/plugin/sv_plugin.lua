local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

-- Another Spawn Check
function PLUGIN:PlayerSpawn(player)
	-- Calls my awesome function
	PLUGIN:SetCustomHeight(player);
end;

-- Processes the player for their height and scales them
function PLUGIN:SetCustomHeight(player, height)
	-- Sets the specified height
	local foundHeight;
	-- Initalize Scale Variable
	local scale;
	-- MODIFY the table for additional heights and their scales
	local heightTable = {
		["4'10"] = 0.88,
		["4'11"] = 0.89,
		["5'0"] = 0.90,
		["5'1"] = 0.91,
		["5'2"] = 0.92,
		["5'3"] = 0.93,
		["5'4"] = 0.94,
		["5'5"] = 0.95,
		["5'6"] = 0.96,
		["5'7"] = 0.97,
		["5'8"] = 0.98,
		["5'9"] = 0.99,
		["5'10"] = 1.00,
		["5'11"] = 1.01,
		["6'0"] = 1.02,
		["6'1"] = 1.03,
		["6'2"] = 1.04,
		["6'3"] = 1.05,
		["6'4"] = 1.06
	};
	-- Table of the bones to modify
	local boneTable = { 
		"ValveBiped.Bip01_Head1",
		"ValveBiped.Bip01_Neck1",
		"ValveBiped.Bip01_Spine4",
		"ValveBiped.Bip01_Spine2",
		"ValveBiped.Bip01_Spine1",
		"ValveBiped.Bip01_Spine",
		"ValveBiped.Bip01_R_UpperArm",
		"ValveBiped.Bip01_R_Forearm",
		"ValveBiped.Bip01_R_Hand",
		"ValveBiped.Bip01_L_UpperArm",
		"ValveBiped.Bip01_L_Forearm",
		"ValveBiped.Bip01_L_Hand",
		"ValveBiped.Bip01_R_Thigh",
		"ValveBiped.Bip01_R_Calf",
		"ValveBiped.Bip01_R_Foot",
		"ValveBiped.Bip01_R_Toe0",
		"ValveBiped.Bip01_L_Thigh",
		"ValveBiped.Bip01_L_Calf",
		"ValveBiped.Bip01_L_Foot",
		"ValveBiped.Bip01_L_Toe0"
	};
	-- Gets height
	if (height) then
		foundHeight = height;
	--else
		-- Gets the Physical Description since its not specified
	--	local physDesc = player:GetSharedVar("PhysDesc");
		-- Searches the string for the height
	--	foundHeight = string.match(physDesc, "%d'?%d%d?");
	end;
	-- Set the scale on the player and their bones
	if (heightTable[foundHeight]) then
		scale = heightTable[foundHeight];
		player:SetModelScale(scale, 1);
		for k,v in pairs(boneTable) do
			local boneID = player:LookupBone(v);
			local boneScale = 1/scale;
			player:ManipulateBoneScale(boneID, Vector(boneScale, boneScale, boneScale));
		end;
	end;
end;

