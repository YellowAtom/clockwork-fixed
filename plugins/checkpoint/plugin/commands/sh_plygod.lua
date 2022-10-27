
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyGod");
COMMAND.tip = "Toggles godmode for a player.";
COMMAND.text = "<string Name>";
COMMAND.access = "a";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target:Alive()) then

			local icon = "shield_add";
			local text = "given godmode to"
			if (target:HasGodMode()) then
				icon = "shield_delete";
				text = "taken godmode from"
				target:GodDisable();
			else
				target:GodEnable();
			end;

			if (target != player) then
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has "..text.." "..target:Name()..".", icon);
						end;
					end;
				end;

				player:CPNotify("You have "..text.." "..target:Name()..".", icon);
				target:CPNotify(player:Name().." has "..text.." you.", icon);
			else
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player) then
							v:CPNotify(player:Name().." has "..text.." themself.", icon);
						end;
					end;
				end;

				player:CPNotify("You have "..text.." yourself.", icon);
			end;
		else
			player:CPNotify(target:Name().." is dead!", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();