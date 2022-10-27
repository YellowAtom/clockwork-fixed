
function PLUGIN:ChatBoxAdjustInfo(info)
	if (info.class == "connect" or info.class == "disconnect") then
		info.bShouldSend = false;
	end;
end;

function PLUGIN:PlayerDataLoaded(player)
	local stealthMode = player:GetInfoNum("cwStealthMode", 0);

	if (stealthMode and stealthMode == 1 and ( player:GetUserGroup() == "vip" or player:IsAdmin() )) then
		player.cwStealthMode = true;

		Clockwork.datastream:Start(nil, "ToggleStealthMode", {player = player, b = true});
	end;

--[[ 	if (!player:IsStealthMode()) then
		Clockwork.chatBox:Add(nil, nil, 'sm_connect', player:SteamName()..' has connected to the server.');
	end;--]] 
end;

function PLUGIN:PlayerDisconnected(player)
	if (player:HasInitialized() and !player:IsStealthMode()) then
		Clockwork.chatBox:Add(nil, nil, "sm_disconnect", player:SteamName().." has disconnected from the server.");
	end;
end;

Clockwork.datastream:Hook("ToggleStealthMode", function(player, data)
	if (player:GetUserGroup() != "vip" and !player:IsAdmin()) then return; end;

	player.cwStealthMode = data[1];

	Clockwork.datastream:Start(nil, "ToggleStealthMode", {player = player, b = data[1]});
end);
