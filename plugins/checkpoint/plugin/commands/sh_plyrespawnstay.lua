
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyRespawnStay");
COMMAND.tip = "Respawns a player on their current position.";
COMMAND.text = "<string Name>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		local pos = target:GetPos() + Vector(0, 0, 8);
		local angles = target:GetAngles();
		local eyeAngles = target:EyeAngles();

		target:Spawn();		
		target:SetPos(pos);
		target:SetAngles(angles);
		target:SetEyeAngles(eyeAngles);

		if (target != player) then
			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player and v != target) then
						v:CPNotify(player:Name().." has respawned "..target:Name().." on their location.", "arrow_down");
					end;
				end;
			end;

			player:CPNotify("You have respawned "..target:Name().." on their location.", "arrow_down");
			target:CPNotify(player:Name().." has respawned you on your location.", "arrow_down");
		else
			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player) then
						v:CPNotify(player:Name().." has respawned themself on their location.", "arrow_down");
					end;
				end;
			end;

			player:CPNotify("You have respawned yourself on your location.", "arrow_down");
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();