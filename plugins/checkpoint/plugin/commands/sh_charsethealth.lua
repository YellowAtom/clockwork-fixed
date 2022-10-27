
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("CharSetHealth");
COMMAND.tip = "Sets a character's health.";
COMMAND.text = "<string Name> [int Amount]";
COMMAND.access = "o";
COMMAND.arguments = 1;
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target:Alive()) then
			local amount = tonumber(arguments[2]);		
			if (!amount) then
				amount = target:GetMaxHealth();
			else
				amount = math.Clamp(math.Round(amount), 1, target:GetMaxHealth());
			end;

			local icon = "add";
			if (amount < target:Health()) then
				icon = "delete";
			end;

			target:SetHealth(amount);

			if (target != player) then
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has set "..target:Name().."'s health to "..amount..".", icon);
						end;
					end;
				end;

				player:CPNotify("You have set "..target:Name().."'s health to "..amount..".", icon);
				target:CPNotify(player:Name().." has set your health to "..amount..".", icon);
			else
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player) then
							v:CPNotify(player:Name().." has set their health to "..amount..".", icon);
						end;
					end;
				end;

				player:CPNotify("You have set your health to "..amount..".", icon);
			end;
		else
			player:CPNotify(target:Name().." is dead!", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();