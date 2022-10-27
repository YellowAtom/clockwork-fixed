
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyBring");
COMMAND.tip = "Bring a player to your location.";
COMMAND.text = "<string Name>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target != player) then
			local pos = player:GetAimVector() * Vector(1, 1, 0);
			pos = player:GetPos() + pos:GetNormalized() * Vector(35, 35, 0) + Vector(0, 0, 8);
			target:SetPos(pos);

			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player and v != target) then
						v:CPNotify(player:Name().." has brought "..target:Name().." to their location.", "group_go");
					end;
				end;
			end;

			player:CPNotify("You have brought "..target:Name().." to your location.", "group_go");
			target:CPNotify(player:Name().." has brought you to their location.", "group_go");
		else
			player:CPNotify("You cannot /PlyBring yourself.", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();