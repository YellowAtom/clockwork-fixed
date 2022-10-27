local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("chargetvortessencemastery");
COMMAND.tip = "Check a characters vortessence mastery.";
COMMAND.text = "<string Name>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)

local target = Clockwork.player:FindByID( arguments[1] )



if (target) then
local ws = target:GetCharacterData("vortessencemastery")
	Clockwork.player:Notify(player, "They have a vortessence mastery of "..ws..".");
		else
			Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
		end;

end;

COMMAND:Register();