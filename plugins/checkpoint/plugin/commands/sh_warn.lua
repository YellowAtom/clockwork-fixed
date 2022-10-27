
local Clockwork = Clockwork;
local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("Warn");
COMMAND.tip = "Gives a player a formal warning.";
COMMAND.text = "<string Name> <string Warning>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if (target) then
		if (!Clockwork.player:IsProtected(arguments[1])) then
			if (!Clockwork.player:IsAdmin(target)) then
				local warning = table.concat(arguments, " ", 2);
				if (warning) then
					local listeners = PLUGIN:GetAllAdmins();
					Clockwork.chatBox:Add(listeners, player, "cp_warn_admin", warning,
						{targetName = target:Name(), targetColor = _team.GetColor(target:Team())});
					Clockwork.chatBox:Add(target, player, "cp_warn_player", warning);

					PLUGIN:PlayerLog(target, "warn", warning, player);
				else
					player:CPNotify("You did not specify a valid warning!", "error");
				end;
			else
				player:CPNotify(target:Name().." is an admin!", Clockwork.option:GetKey("invalid_target_icon"));
			end;
		else
			player:CPNotify(target:Name().." is protected!", "shield");
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();