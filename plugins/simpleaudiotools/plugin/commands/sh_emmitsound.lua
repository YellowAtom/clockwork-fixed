--[[
	Created by Silverdisc. Do not redistribute without my permission.
	Edits are fine, as long as you leave my name in the credits.
--]]

local COMMAND = Clockwork.command:New("EmmitSound");
COMMAND.tip = "Emmits a sound (sound is attached to you)";
COMMAND.flags = CMD_DEFAULT;
COMMAND.text = "<string Path> [int Distance=70 (50-100)] [int Pitch=100 (30-255)]";
COMMAND.access = "o";
COMMAND.arguments = 1;
COMMAND.optionalArguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local soundLevel = tonumber(arguments[2] or 70);
	local pitch = tonumber(arguments[3] or 100);
	if( pitch > 29 and pitch < 256  ) then
		player:EmitSound(arguments[1], soundLevel, pitch);
	else
		Clockwork.player:Notify(player, "The pitch needs to be between 30 and 255!");
	end;
end;

COMMAND:Register();