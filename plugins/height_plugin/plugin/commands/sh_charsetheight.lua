local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("CharSetHeight");
COMMAND.tip = "Sets the specific height of a player.";
COMMAND.text = "<string PlayerName> <string Height>";
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	local height = arguments[2];
	if (target) then
		if (height) then
			PLUGIN:SetCustomHeight(target, height);
			Clockwork.player:Notify(player, target:Name().." is now "..height);
		else
			Clockwork.player:Notify(player, arguments[2].." is not a valid height!");
		end;
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;

COMMAND:Register();