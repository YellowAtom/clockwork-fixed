
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyFreezeTp");
COMMAND.tip = "Freezes or unfreezes a player and teleports them to your crosshair.";
COMMAND.text = "<string Name>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target != player) then
			if (!target:IsFrozen()) then
				Clockwork.player:SetRagdollState(target, RAGDOLL_NONE);
			end;
			
			target:Freeze(!target:IsFrozen());

			local pos = player:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 8);
			target:SetPos(pos);

			local text = "unfrozen";
			local icon = "lock_open";
			if (target:IsFrozen()) then
				text = "frozen";
				icon = "lock_go";
			end;

			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player and v != target) then
						v:CPNotify(player:Name().." has "..text.." "..target:Name().." and teleported them to their location.", icon);
					end;
				end;
			end;

			player:CPNotify("You have "..text.." "..target:Name().." and teleported them to your location.", icon);
			target:CPNotify(player:Name().." has "..text.." you and teleported you to their location.", icon);
		else
			player:CPNotify("You cannot /PlyFreezeTp yourself. Use /PlyFreeze instead.", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();