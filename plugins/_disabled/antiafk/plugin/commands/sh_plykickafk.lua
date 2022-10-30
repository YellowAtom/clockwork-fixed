
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyKickAFK");
COMMAND.tip = "Kick all AFK players from the server.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = nil;
	local players = _player.GetAll();

	for _, ply in pairs(players) do
		if (ply.isAFK and (!target or target.isAFK > ply.isAFK)) then
			if (!Clockwork.player:IsAdmin(ply)) then
				target = ply;
			end;
		end;
	end;
	
	if (target) then
		Clockwork.player:NotifyAll(player:Name().." has kicked '"..target:Name().."' (AFK).");
		target:Kick("You were kicked for being AFK");
		target.kicked = true;
	else
		Clockwork.player:Notify(player, "No players are away from keyboard.");
	end;
end;

COMMAND:Register();