local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("chargetcombatskills");
COMMAND.tip = "Check a characters weapon and ballistics skills.";
COMMAND.text = "<string Name>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)

local target = Clockwork.player:FindByID( arguments[1] )



if (target) then
local ws = target:GetCharacterData("weaponskill")
local bs = target:GetCharacterData("ballisticsskill")
local rs = target:GetCharacterData("riflesskill")
local hs = target:GetCharacterData("handgunsskill")
local ss = target:GetCharacterData("snipersskill")

	Clockwork.player:Notify(player, "They have a handguns skill of "..hs..", a submachine guns skill of "..bs..",  a rifles skill of "..rs..", a sniper rifles skill of "..ss.."  and a weapon skill of "..ws..".");
		else
			Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
		end;

end;

COMMAND:Register();