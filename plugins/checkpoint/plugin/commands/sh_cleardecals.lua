
local COMMAND = Clockwork.command:New("ClearDecals");
COMMAND.tip = "Runs r_cleardecals on all players.";
COMMAND.access = "o";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local players = _player.GetAll();
	for k, v in pairs(players) do
		v:ConCommand("r_cleardecals");
		--v:CPNotify(player:Name().." has cleared all decals.", "bin");
	end;
end;

COMMAND:Register();