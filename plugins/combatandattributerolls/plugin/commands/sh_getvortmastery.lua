local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("getvortmastery");
COMMAND.tip = "Check your vortessence mastery.";
COMMAND.text = "<none>";
COMMAND.flags = CMD_DEFAULT;


-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)

local ws = player:GetCharacterData("vortessencemastery")

	Clockwork.player:Notify(player, "You have a vortessence mastery of "..ws..".");
end;

COMMAND:Register();