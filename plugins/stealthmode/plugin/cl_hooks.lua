
function PLUGIN:Initialize()
	CW_CONVAR_STEALTHMODE = Clockwork.kernel:CreateClientConVar("cwStealthMode", 0, true, true, function(conVar, oldValue, newValue)
		Clockwork.datastream:Start("ToggleStealthMode", {tobool(newValue)});
	end);
end;


function PLUGIN:PlayerShouldShowOnScoreboard(player)
	if (player:IsStealthMode() and Clockwork.Client != player and !Clockwork.player:IsAdmin(Clockwork.Client)) then
		return false;
	end;
end;

function PLUGIN:ChatBoxAdjustInfo(info)
	if (info.speaker and info.speaker:IsStealthMode()) then
		local faction = info.speaker:GetFaction();

		info.icon = "icon16/user.png";

		if (faction and Clockwork.faction.stored[faction]) then
			if (Clockwork.faction.stored[faction].whitelist) then
				info.icon = "icon16/user.png";
			end;
		end;
	end;
end;

Clockwork.datastream:Hook("ToggleStealthMode", function(data)
	if (!IsValid(data.player)) then return; end;

	data.player.cwStealthMode = data.b;
end);
