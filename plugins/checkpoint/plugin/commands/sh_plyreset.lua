
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyReset");
COMMAND.tip = "Reset a player (silent slay + respawn stay).";
COMMAND.text = "<string Name>";
COMMAND.access = "a";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target:Alive()) then
			local pos = target:GetPos() + Vector(0, 0, 8);
			local angles = target:GetAngles();
			local eyeAngles = target:EyeAngles();

			target:KillSilent();
			target:Spawn();
			target:SetPos(pos);
			target:SetAngles(angles);
			target:SetEyeAngles(eyeAngles);

			if (target != player) then
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has reset "..target:Name()..".", "arrow_refresh");
						end;
					end;
				end;

				player:CPNotify("You have reset "..target:Name()..".", "arrow_refresh");
				target:CPNotify(player:Name().." has reset you.", "arrow_refresh");
			else
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player) then
							v:CPNotify(player:Name().." has reset themself.", "arrow_refresh");
						end;
					end;
				end;

				player:CPNotify("You have reset yourself.", "arrow_refresh");
			end;
		else
			player:CPNotify(target:Name().." is already dead!", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();