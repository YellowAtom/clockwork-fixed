local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyGetInfo");
COMMAND.tip = "Gets a player's IC name, OOC name and steam ID and optionally his health and armor.";
COMMAND.text = "[anything HP/Armor]"
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.entity:GetPlayer(player:GetEyeTraceNoCursor().Entity);
	
	if (target) then
		player:CPNotify("Steam Name: "..target:SteamName().."; Steam ID: "..target:SteamID()..".", "information");
		if (arguments) then
			player:CPNotify("Health: "..target:Health().."; Armor: "..target:Armor(), "information");
		end;
	else
		player:CPNotify("You are not looking at a valid character!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();