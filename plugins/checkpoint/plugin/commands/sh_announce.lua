
local COMMAND = Clockwork.command:New("Announce");
COMMAND.tip = "Announce something to everyone on the server.";
COMMAND.text = "<string Text>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.chatBox:Add(nil, nil, "cp_announce", arguments[1]);
end;

COMMAND:Register();