local COMMAND = Clockwork.command:New("PlyCheckFlags");
COMMAND.tip = "Checks a player's global flags.";
COMMAND.text = "<string Name>";
COMMAND.access = "s";
COMMAND.arguments = 1;
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	if (target) then
		Clockwork.player:NotifyAll(player:Name().." has '"..player:GetFlags().."' global flags.");
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;
COMMAND:Register()