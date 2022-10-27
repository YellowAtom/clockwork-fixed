
local COMMAND = Clockwork.command:New("GetFlags");
COMMAND.tip = "Give all needed flags to yourself.";
COMMAND.access = "s";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local flags = "";
	local flagTable = Clockwork.flag:GetStored();

	for flag, _v in pairs(flagTable) do
		flags = flags..flag;
	end;

	Clockwork.player:GiveFlags(player, flags);

	if (Clockwork.config:Get("global_echo"):Get()) then
		for k, v in pairs(_player.GetAll()) do
			if (v != player) then
				v:CPNotify(player:Name().." has given himself '"..flags.."' flags.", "flag_blue");
			end;
		end;
	end;
	
	player:CPNotify("You have given yourself '"..flags.."' flags.", "flag_blue");
end;

COMMAND:Register();