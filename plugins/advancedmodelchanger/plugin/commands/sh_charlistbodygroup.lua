
local COMMAND = Clockwork.command:New("CharListBodyGroups");
COMMAND.tip = "Lists all valid bodygroups for a characters current model.";
COMMAND.text = "<string Name>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		local text = "Available bodygroups for '"..target:GetModel().."':";
		
		for i = 0, target:GetNumBodyGroups() - 1 do
			text = text.."\n "..i.." = "..target:GetBodygroupName(i).."(0-"..(target:GetBodygroupCount(i) - 1)..")";
		end;
		
		Clockwork.player:Notify(player, text);
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;

COMMAND:Register();