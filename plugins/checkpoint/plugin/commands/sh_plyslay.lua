
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlySlay");
COMMAND.tip = "Slays a player.";
COMMAND.text = "<string Name>";
COMMAND.access = "a";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target:Alive()) then
			target:Kill();		

			if (target != player) then
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has slayed "..target:Name()..".", "cancel");
						end;
					end;
				end;

				player:CPNotify("You have slayed "..target:Name()..".", "cancel");
				target:CPNotify(player:Name().." has slayed you.", "cancel");
			else
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player) then
							v:CPNotify(player:Name().." has slayed themself.", "cancel");
						end;
					end;
				end;

				player:CPNotify("You have slayed yourself.", "cancel");
			end;
		else
			player:CPNotify(target:Name().." is already dead!", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();