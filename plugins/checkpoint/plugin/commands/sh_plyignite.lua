
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyIgnite");
COMMAND.tip = "Ignite or extinguish a player a player.";
COMMAND.text = "<string Name> [int Time]";
COMMAND.access = "a";
COMMAND.arguments = 1;
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target:Alive()) then
			local time = tonumber(arguments[2]);		
			if (!time) then
				time = 0;
			else
				time = math.max(math.Round(time), 0);
			end;

			if (time == 0) then
				target:Extinguish();
			else
				target:Ignite(time);
			end;

			local icon = "weather_rain";
			local text = "extinguished";
			local text2 = ".";
			if (time > 0) then
				icon = "weather_sun";
				text = "ignited";
				text2 = "for "..time.."s.";
			end;

			target:SetArmor(time);

			if (target != player) then
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has "..text.." "..target:Name()..text2, icon);
						end;
					end;
				end;

				player:CPNotify("You have "..text.." "..target:Name()..text2, icon);
				target:CPNotify(player:Name().." has "..text.." you "..text2, icon);
			else
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player) then
							v:CPNotify(player:Name().." has "..text.." you "..text2, icon);
						end;
					end;
				end;

				player:CPNotify("You have "..text.." yourself "..text2, icon);
			end;
		else
			player:CPNotify(target:Name().." is dead!", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();