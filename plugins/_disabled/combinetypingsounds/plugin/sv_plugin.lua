local PLUGIN = PLUGIN;

-- Called when a player's typing display has started.
function PLUGIN:PlayerStartTypingDisplay(player, code)
	local faction = player:GetFaction();
	if ( faction == FACTION_MPF or faction == FACTION_OTA ) then
			if (!player.typingBeep) then
				player.typingBeep = true;				
				player:EmitSound("npc/overwatch/radiovoice/on3.wav");
			end;
	end;
end;

-- Called when a player's typing display has finished.
function PLUGIN:PlayerFinishTypingDisplay(player, textTyped)
	local faction = player:GetFaction();
	if ( faction == FACTION_MPF or faction == FACTION_OTA and textTyped ) then
		if (player.typingBeep) then
			player:EmitSound("npc/overwatch/radiovoice/off4.wav");
		end;
	end;
	player.typingBeep = nil;
end;