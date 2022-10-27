local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("getcombatskills");
COMMAND.tip = "Check your weapon and ballistics skills.";
COMMAND.text = "<none>";
COMMAND.flags = CMD_DEFAULT;


-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)

local ws = player:GetCharacterData("weaponskill")
local bs = player:GetCharacterData("ballisticsskill")
local ss = player:GetCharacterData("snipersskill")
local hs = player:GetCharacterData("handgunsskill")
local rs = player:GetCharacterData("riflesskill")

	Clockwork.player:Notify(player, "You have a handguns skill of "..hs..", a submachine guns skill of "..bs..", a rifles skill of "..rs..", a sniper rifles skill of "..ss..", and a weapon skill of "..ws..".");
end;

COMMAND:Register();