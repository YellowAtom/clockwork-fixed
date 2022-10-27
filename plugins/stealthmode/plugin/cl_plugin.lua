
local playerMeta = FindMetaTable("Player");

function playerMeta:IsStealthMode()
	return self.cwStealthMode;
end;

--[[ Clockwork.chatBox:RegisterClass("sm_connect", nil, function(info)
	local filtered = (CW_CONVAR_SHOWAURA:GetInt() == 0) or info.filtered;
	local icon = info.data.icon or "user_add";

	Clockwork.chatBox:Add(filtered, "icon16/"..icon..".png", Color(150, 150, 200, 255), info.text.." has connected to the server.");
end);--]] 

Clockwork.chatBox:RegisterClass("sm_disconnect", "ooc", function(info)
	local filtered = (CW_CONVAR_SHOWAURA:GetInt() == 0) or info.filtered;
			
	Clockwork.chatBox:Add(filtered, "icon16/user_delete.png", Color(200, 150, 200, 255), info.text);
end);

Clockwork.setting:AddCheckBox("Framework", "Stealth Mode", "cwStealthMode", "Hide yourself from join/leave messages, the scoreboard; and hide your chat icon.", function()
	return Clockwork.Client:GetUserGroup() == "vip" or Clockwork.Client:IsAdmin();
end);
