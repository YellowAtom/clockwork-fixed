COMMAND = Clockwork.command:New("ClearPAC");
COMMAND.tip = "Clears your current PAC.";
COMMAND.flags = 5;
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player)
	player:ConCommand("pac_clear_parts")
end;



COMMAND:Register(COMMAND, "ClearPAC");