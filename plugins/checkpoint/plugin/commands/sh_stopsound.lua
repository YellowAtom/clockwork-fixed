
local COMMAND = Clockwork.command:New("StopSound");
COMMAND.tip = "Runs stopsound on all players.";
COMMAND.text = "[bool StopQueue]";
COMMAND.access = "o";
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.datastream:Start(nil, "stop_sound", {true});

	if (arguments and arguments[1]) then
		local bool = arguments[1];

		if (bool != "0" and bool != 0 and bool != "false" and bool != false) then
			Clockwork.datastream:Start(nil, "stop_queue", {true});
		end;
	end;
	
	for k, v in pairs(_player.GetAll()) do
		--v:CPNotify(player:Name().." has stopped all sounds.", "sound_mute");
	end;
end;

if (CLIENT) then
	Clockwork.datastream:Hook("stop_sound", function(data)
		Clockwork.Client:ConCommand("stopsound");
	end);
end;

COMMAND:Register();