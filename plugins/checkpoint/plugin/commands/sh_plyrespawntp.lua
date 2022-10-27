
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyRespawnTp");
COMMAND.tip = "Respawns a player on your crosshair location.";
COMMAND.text = "<string Name>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (player != target) then
			local pos = player:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 8);

			target:Spawn();		
			target:SetPos(pos);

			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player and v != target) then
						v:CPNotify(player:Name().." has respawned "..target:Name().." and teleported them to their location.", "arrow_right");
					end;
				end;
			end;

			player:CPNotify("You have respawned "..target:Name().." and teleported them to your location.", "arrow_right");
			target:CPNotify(player:Name().." has respawned you and teleported you to their location.", "arrow_right");
		else
			player:CPNotify("You cannot /PlyRespawnTp yourself. Use /PlyRespawnStay instead.", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();