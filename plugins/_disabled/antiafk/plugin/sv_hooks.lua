
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

Clockwork.config:Add("afk_time", 900);

local afkTime = Clockwork.config:Get("afk_time");

function PLUGIN:PlayerThink(player, curTime)
	local aimVector = tostring(player:GetAimVector());
	local posVector = tostring(player:GetPos());

	if (!player.nextCheckAFK or
		(player.lastAimVector != aimVector and player.lastPos != posVector)) then
		player.nextCheckAFK = curTime + afkTime:Get();
		player.lastAimVector = aimVector;
		player.lastPosVector = posVector;
	end;
	
	if (curTime >= player.nextCheckAFK and !player.isAFK) then
		player.isAFK = curTime;
		player:SetSharedVar("IsAFK", true);
		if _player.GetCount() >= 25 then
			if (player:GetFaction() == FACTION_MPF or player:GetFaction() == FACTION_OTA) and !Clockwork.player:IsAdmin(player) then
				timer.Simple(600, function()
					if (IsValid(player) and player.isAFK) then
						player:Kick("Don't go AFK on a Civil Protection/OTA unit.");
					end;
				end);
			elseif (player:GetFaction() == FACTION_CITIZEN) and !Clockwork.player:IsAdmin(player) then
				timer.Simple(1800, function()
					if (IsValid(player) and player.isAFK) then
						player:Kick("Kicked for being AFK too long.");
					end;
				end);
			end;
		end;
	elseif (curTime < player.nextCheckAFK and player.isAFK) then
		player.isAFK = 0;
		player:SetSharedVar("IsAFK", false);
	end;
end;