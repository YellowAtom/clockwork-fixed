
local COMMAND = Clockwork.command:New("StopQueue");
COMMAND.tip = "Stops all current sound queues on all players.";
COMMAND.access = "a";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.datastream:Start(nil, "stop_queue", {true});
	
	--player:CPNotify("You have stopped all sound queues.", "sound_mute");
end;

COMMAND:Register();