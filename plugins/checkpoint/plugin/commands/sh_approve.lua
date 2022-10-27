
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;
local cwOption = Clockwork.option;

local COMMAND = Clockwork.command:New("Approve");
COMMAND.tip = "Approves a new player, allowing him full access to everything.";
COMMAND.text = "[string Name]";
COMMAND.access = "o";
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (arguments[1]) then
		local target = Clockwork.player:FindByID(arguments[1]);
	
		if (target) then
			if (!target:GetData("admin_approved", false)) then
				target:SetData("admin_approved", true);

				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has approved "..target:Name()..".", "accept");
						end;
					end;
				end;

				PLUGIN:PlayerLog(target, "approve", "", player);

				player:CPNotify("You have approved "..target:Name()..".", "accept");
				target:CPNotify(player:Name().." has approved you.", "accept");

				Clockwork.plugin:Call("PlayerApproved", target);
			else
				player:CPNotify(target:Name().." has already been approved.", cwOption:GetKey("cannot_do_icon"));
			end;
		else
			player:CPNotify(arguments[1].." is not a valid character!", cwOption:GetKey("invalid_target_icon"));
		end;
	else
		if (IsValid(PLUGIN.LastUnapprovedSpawn)) then
			local target = PLUGIN.LastUnapprovedSpawn;
			target:SetData("admin_approved", true);

			if (Clockwork.config:Get("global_echo"):Get()) then
				for k, v in pairs(_player.GetAll()) do
					if (v != player and v != target) then
						v:CPNotify(player:Name().." has approved "..target:Name()..".", "accept");
					end;
				end;
			end;

			PLUGIN:PlayerLog(target, "approve", "", player);

			player:CPNotify("You have approved "..target:Name()..".", "accept");
			target:CPNotify(player:Name().." has approved you.", "accept");

			Clockwork.plugin:Call("PlayerApproved", target);
		end;
	end;
end;

COMMAND:Register();