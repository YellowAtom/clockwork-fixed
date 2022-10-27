
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlySetIcon");
COMMAND.tip = "Sets a player's chat icon.";
COMMAND.text = "<string Name> <string Icon>";
COMMAND.access = "s";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		local icon = arguments[2]
		string.gsub(icon, "^icon16/", "");
		string.gsub(icon, ".png$", "");

		if (icon != "") then
			if (icon == "none") then
				target:SetData("icon", nil);
			else
				target:SetData("icon", icon);
			end;

			if (target != player) then
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has set "..target:Name().."'s icon to "..icon..".", "images");
						end;
					end;
				end;

				player:CPNotify("You have set "..target:Name().."'s icon to "..icon..".", "images");
				target:CPNotify(player:Name().." has set your icon to "..icon..".", "images");
			else
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player) then
							v:CPNotify(player:Name().." has set their icon to "..icon..".", "images");
						end;
					end;
				end;

				player:CPNotify("You have set your icon to "..icon..".", "images");
			end;
		else
			player:CPNotify(icon.." is not a valid icon!", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();