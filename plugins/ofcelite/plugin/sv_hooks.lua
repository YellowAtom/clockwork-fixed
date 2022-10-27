local PLUGIN = PLUGIN;

-- Called when a player's character has initialized.
function PLUGIN:PlayerCharacterInitialized(player)
	local faction = player:GetFaction();
	
	if (Schema:PlayerIsCombine(player)) then
		for k, v in pairs(Clockwork.class.stored) do
			if (v.factions and table.HasValue(v.factions, faction)) then
				if (#_team.GetPlayers(v.index) < Clockwork.class:GetLimit(v.name)) then
					if (v.index == CLASS_EMP and Schema:IsPlayerCombineRank(player, "OfC")) then
						Clockwork.class:Set(player, v.index); break;
					end;
				end;
			end;
		end;
	end;
end;

-- Called when a player's name has changed.
function PLUGIN:PlayerNameChanged(player, previousName, newName)
	if (Schema:PlayerIsCombine(player)) then
		local faction = player:GetFaction();
		
		if (faction == FACTION_MPF) then
			if (!Schema:IsStringCombineRank(previousName, "OfC") and Schema:IsStringCombineRank(newName, "OfC")) then
				Clockwork.class:Set(player, CLASS_EMP);
			end;
		end;
	end;
end;

-- Called when a player attempts to change class.
function PLUGIN:PlayerCanChangeClass(player, class)
	if (player:GetSharedVar("tied") != 0) then
		Clockwork.player:Notify(player, "You cannot change classes when you are tied!");
		
		return false;
	elseif (Schema:PlayerIsCombine(player)) then
		if (class == CLASS_EMP and !Schema:IsPlayerCombineRank(player, "OfC")) then
			Clockwork.player:Notify(player, "You are not ranked high enough for this class!");
			
			return false;
		elseif (class == CLASS_MPU) then
			if (Schema:IsPlayerCombineRank(player, "OfC")) then
				Clockwork.player:Notify(player, "You are ranked too high for this class!");
				
				return false;
			end;
		end;
	end;
end;