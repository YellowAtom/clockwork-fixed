local COMMAND = Clockwork.command:New("PGI");
COMMAND.tip = "Gets a player's IC name, OOC name and steam ID and optionally his health and armor.";
COMMAND.text = "[anything HP/Armor]"
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.command:FindByID("PlyGetInfo"):OnRun(player, arguments);
end;

COMMAND:Register();