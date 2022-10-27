
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyTp");
COMMAND.tip = "Teleports a player to your crosshair.";
COMMAND.text = "<string Name>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target != player) then
			local pos = player:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 8);
			target:SetPos(pos);

			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player and v != target) then
						v:CPNotify(player:Name().." has teleported "..target:Name().." to their location.", icon);
					end;
				end;
			end;

			player:CPNotify("You have teleported "..target:Name().." to your location.", icon);
			target:CPNotify(player:Name().." has teleported you to their location.", icon);
		else
			player:CPNotify("You cannot /PlyTp yourself. Use instead.", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();