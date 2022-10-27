local COMMAND = Clockwork.command:New("PlyResetFlags");
COMMAND.tip = "Resets a player's flags.";
COMMAND.text = "<string Name>";
COMMAND.access = "s";
COMMAND.arguments = 1;
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	if (target) then
		SetFlags(target, "");
		Clockwork.player:NotifyAll(player:Name().." took all global flags from "..target:Name());
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;
COMMAND:Register();