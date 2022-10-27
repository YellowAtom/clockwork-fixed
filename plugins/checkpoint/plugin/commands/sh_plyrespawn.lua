
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyRespawn");
COMMAND.tip = "Respawns a player.";
COMMAND.text = "<string Name>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		target:Spawn();		

		if (target != player) then
			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player and v != target) then
						v:CPNotify(player:Name().." has respawned "..target:Name()..".", "arrow_refresh");
					end;
				end;
			end;

			player:CPNotify("You have respawned "..target:Name()..".", "arrow_refresh");
			target:CPNotify(player:Name().." has respawned you.", "arrow_refresh");
		else
			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player) then
						v:CPNotify(player:Name().." has respawned themself.", "arrow_refresh");
					end;
				end;
			end;

			player:CPNotify("You have respawned yourself.", "arrow_refresh");
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();