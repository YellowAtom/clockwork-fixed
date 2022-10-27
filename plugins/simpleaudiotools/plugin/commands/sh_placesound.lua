--[[
	Created by Silverdisc. Do not redistribute without my permission.
	Edits are fine, as long as you leave my name in the credits.
--]]

local COMMAND = Clockwork.command:New("PlaceSound");
COMMAND.tip = "Plays a sound at where you are aiming (not persistent)";
COMMAND.flags = CMD_DEFAULT;
COMMAND.text = "<string Path> [int Level=70 (60-90)] [int Pitch=100 (30-255)]";
COMMAND.access = "o";
COMMAND.arguments = 1;
COMMAND.optionalArguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local soundLevel = tonumber(arguments[2] or 70);
	local pitch = tonumber(arguments[3] or 100);
	local trace = player:GetEyeTraceNoCursor();
	if (player:GetShootPos():Distance(trace.HitPos) <= 2000) then
		if( pitch > 29 and pitch < 256  ) then
			sound.Play(arguments[1], trace.HitPos, soundLevel, pitch);
		else
			Clockwork.player:Notify(player, "The pitch needs to be between 30 and 255!");
		end;
	else
		Clockwork.player:Notify(player, "You cannot play a sound that far away!");
	end;
end;

COMMAND:Register();