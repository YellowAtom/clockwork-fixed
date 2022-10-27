
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlySend");
COMMAND.tip = "Sends a player to the target's location.";
COMMAND.text = "<string PlayerName> <string TargetName>";
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local tpTarget = Clockwork.player:FindByID(arguments[1]);
	
	if (tpTarget) then
		local posTarget = Clockwork.player:FindByID(arguments[2]);
		if (posTarget) then
			if (not (player == posTarget and player == tpTarget)) then
				if (posTarget != tpTarget) then
					local pos = posTarget:GetAimVector() * Vector(1, 1, 0);
					pos = posTarget:GetPos() + pos:GetNormalized() * Vector(35, 35, 0) + Vector(0, 0, 8);
					tpTarget:SetPos(pos);

					if (tpTarget != player and posTarget != player) then
						if (Clockwork.config:Get("global_echo"):Get()) then
							for k, v in pairs(_player.GetAll()) do
								if (v != player and v != tpTarget and v != posTarget) then
									v:CPNotify(player:Name().." has send "..tpTarget:Name().." to "..posTarget:Name()..".", "group_go");
								end;
							end;
						end;
						player:CPNotify("You have send "..tpTarget:Name().." to "..posTarget:Name()..".", "group_go");
						tpTarget:CPNotify(player:Name().." has send you to "..posTarget:Name()..".", "group_go");
						posTarget:CPNotify(player:Name().." has send "..tpTarget:Name().." to you.", "group_go");
					elseif (tpTarget != player) then
						if (Clockwork.config:Get("global_echo"):Get()) then
							for k, v in pairs(_player.GetAll()) do
								if (v != player and v != tpTarget and v != posTarget) then
									v:CPNotify(player:Name().." has send "..tpTarget:Name().." to their location.", "group_go");
								end;
							end;
						end;
						player:CPNotify("You have send "..tpTarget:Name().." to your location.", "group_go");
						tpTarget:CPNotify(player:Name().." has send you to their location.", "group_go");
					elseif (posTarget != player) then
						if (Clockwork.config:Get("global_echo"):Get()) then
							for k, v in pairs(_player.GetAll()) do
								if (v != player and v != tpTarget and v != posTarget) then
									v:CPNotify(player:Name().." has send themself to "..posTarget:Name()..".", "group_go");
								end;
							end;
						end;
						player:CPNotify("You have send yourself to "..posTarget:Name()..".", "group_go");
						posTarget:CPNotify(player:Name().." has send themself to you.", "group_go");
					end;	
				else
					player:CPNotify("You cannot send a player to himself.", Clockwork.option:GetKey("cannot_do_icon"));
				end;		
			else
				player:CPNotify("At least one target must be another player.", Clockwork.option:GetKey("cannot_do_icon"));
			end;
		else
			player:CPNotify(arguments[2].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();