
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("CharUnpill");
COMMAND.tip = "Unpill a player.";
COMMAND.text = "<string Name>";
COMMAND.access = "s";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		pk_pills.restore(target,true)
		if target == player then
			Clockwork.player:Notify(player, "You have un-pilled yourself.");
		else
			Clockwork.player:Notify(player, "You have un-pilled "..arguments[1]..".");
		end
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
	end
end;

COMMAND:Register();