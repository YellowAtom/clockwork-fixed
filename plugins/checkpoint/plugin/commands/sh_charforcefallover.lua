
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("CharForceFallOver");
COMMAND.tip = "Forces a player to fallover.";
COMMAND.text = "<string Name> [int Time]";
COMMAND.access = "o";
COMMAND.arguments = 1;
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target:Alive()) then
			if (!target:IsFrozen()) then
				local time = tonumber(arguments[2]);		
				if (!time) then
					time = 0;
				else
					time = math.max(math.Round(time), 0);
				end;

				local icon = "arrow_up";
				if (time > 0) then
					icon = "arrow_down";
				end;

				Clockwork.player:SetRagdollState(target, RAGDOLL_KNOCKEDOUT, time);

				if (target != player) then
					if (Clockwork.config:Get("global_echo"):Get()) then
						for k, v in pairs(_player.GetAll()) do
							if (v != player and v != target) then
								v:CPNotify(player:Name().." has forced "..target:Name().." to fallover for "..time.."s.", icon);
							end;
						end;
					end;

					player:CPNotify("You have forced "..target:Name().." to fallover for "..time.."s.", icon);
					target:CPNotify(player:Name().." has forced you to fallover for "..time.."s.", icon);
				else
					if (Clockwork.config:Get("global_echo"):Get()) then
						for k, v in pairs(_player.GetAll()) do
							if (v != player) then
								v:CPNotify(player:Name().." has forced themself to fallover for "..time.."s.", icon);
							end;
						end;
					end;

					player:CPNotify("You have forced yourself to fallover for "..time.."s.", icon);
				end;
			else
				player:CPNotify(target:Name().." is frozen!", Clockwork.option:GetKey("cannot_do_icon"));
			end;
		else
			player:CPNotify(target:Name().." is dead!", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();