local PLUGIN = PLUGIN;


-- Called when a player's character data should be restored.
function PLUGIN:PlayerRestoreCharacterData(player, data)
	if ( !data["ballisticsskill"] ) then
		data["ballisticsskill"] = 0;
	end;
	if ( !data["snipersskill"] ) then
		data["snipersskill"] = 0;
	end;
	if ( !data["handgunsskill"] ) then
		data["handgunsskill"] = 0;
	end;
	if ( !data["riflesskill"] ) then
		data["riflesskill"] = 0;
	end;
	if ( !data["weaponskill"] ) then
		data["weaponskill"] = 0;
	end;
	if ( !data["vortessencemastery"] ) then
		data["vortessencemastery"] = 0;
	end;
end;

-- Called when a player's shared variables should be set.
function PLUGIN:PlayerSetSharedVars(player, curTime)
	player:SetSharedVar( "ballisticsskill", math.Round( player:GetCharacterData("ballisticsskill") ) );
	player:SetSharedVar( "handgunsskill", math.Round( player:GetCharacterData("handgunsskill") ) );
	player:SetSharedVar( "riflesskill", math.Round( player:GetCharacterData("riflesskill") ) );
	player:SetSharedVar( "snipersskill", math.Round( player:GetCharacterData("snipersskill") ) );
	player:SetSharedVar( "weaponskill", math.Round( player:GetCharacterData("weaponskill") ) );
	player:SetSharedVar( "vortessencemastery", math.Round( player:GetCharacterData("vortessencemastery") ) );
end;