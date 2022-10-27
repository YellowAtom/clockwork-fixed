local COMMAND = Clockwork.command:New("PlyGiveFlags");
COMMAND.tip = "Give flags to a player.";
COMMAND.text = "<string Name> <string Flag(s)>";
COMMAND.access = "s";
COMMAND.arguments = 2;
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	if (target) then
		if (string.find(arguments[2], "a") or string.find(arguments[2], "s")
		or string.find(arguments[2], "o")) then
			Clockwork.player:Notify(player, "You cannot give 'o', 'a' or 's' flags!");
		else
			AddFlags(target, arguments[2]);
			Clockwork.player:NotifyAll(player:Name().." gave "..target:Name().." '"..arguments[2].."' global flags.")
		end;
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;
COMMAND:Register();