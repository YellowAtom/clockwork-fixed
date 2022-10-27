--[[
	Created by Silverdisc. Do not redistribute without my permission.
	Edits are fine, as long as you leave my name in the credits.
--]]

local COMMAND = Clockwork.command:New("PlaySoundGlobal");
COMMAND.tip = "Plays a sound to everyone on the server.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.text = "<string Path>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	for k, v in pairs(_player.GetAll()) do
		Clockwork.player:PlaySound(v, arguments[1]);
	end;
end;

COMMAND:Register();