
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyRespawnBring");
COMMAND.tip = "Respawns a player and brings him to your position.";
COMMAND.text = "<string Name>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (player != target) then
			local pos = player:GetAimVector() * Vector(1, 1, 0);
			pos = player:GetPos() + pos:GetNormalized() * Vector(35, 35, 0) + Vector(0, 0, 8);

			target:Spawn();		
			target:SetPos(pos);

			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player and v != target) then
						v:CPNotify(player:Name().." has respawned "..target:Name().." and brought them to their location.", "arrow_rotate_anticlockwise");
					end;
				end;
			end;

			player:CPNotify("You have respawned "..target:Name().." and brought them to your location.", "arrow_rotate_anticlockwise");
			target:CPNotify(player:Name().." has respawned you and brought you to their location.", "arrow_rotate_anticlockwise");
		else
			player:CPNotify("You cannot /PlyRespawnBring yourself. Use /PlyRespawnStay instead.", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();