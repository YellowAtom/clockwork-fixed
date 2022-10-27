
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("CharPill");
COMMAND.tip = "Pill a player.";
COMMAND.text = "<string Name> <string Pill>";
COMMAND.access = "s";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	local pill = arguments[2]	
	
	if (target) then
		pk_pills.apply(target,pill,"force")
		if target == player then
			Clockwork.player:Notify(player, "You have pilled yourself with: "..arguments[2]..".");
		else
			Clockwork.player:Notify(player, "You have pilled "..arguments[1].." with: "..arguments[2]..".");
		end
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
	end
end;

COMMAND:Register();