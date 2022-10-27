local COMMAND = Clockwork.command:New("PlyAllFlags");
COMMAND.tip = "Give all flags to a player.";
COMMAND.text = "<string Name>";
COMMAND.access = "s";
COMMAND.arguments = 1;
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	if (target) then
		SetFlags(target, allflags);
		Clockwork.player:NotifyAll(player:Name().." gave "..target:Name().." all global flags.");
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;
COMMAND:Register();