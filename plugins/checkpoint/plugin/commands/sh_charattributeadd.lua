
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("CharAttributeAdd");
COMMAND.tip = "Adds the given amount to the player's attribute.";
COMMAND.text = "<string Name> <string Attribute> <int Amount>";
COMMAND.access = "s";
COMMAND.arguments = 3;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		local amount = tonumber(arguments[3]);
		if (amount and amount > 0) then
			local success, err = Clockwork.attributes:Update(target, arguments[2], amount);
			if (!success) then
				if (!err) then
					err = "Something went wrong!"
				end;
			    player:CPNotify(err, Clockwork.option:GetKey("cannot_do_icon"));
			else
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has added "..amount.." to "..target:Name().."'s "..arguments[2]..".", "add");
						end;
					end;
				end;

				player:CPNotify("You have added "..amount.." to "..target:Name().."'s "..arguments[2]..".", "add");
				target:CPNotify(player:Name().." has added "..amount.." to your "..arguments[2]..".", "add");
			end;
		else
			player:CPNotify("You did not specify a valid amount!", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();