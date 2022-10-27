
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyForceChar");
COMMAND.tip = "Forces a player to use a character and prevents them from switching for the given time.";
COMMAND.text = "<string Name> <string CharName> [int Time] [bool Stay]";
COMMAND.access = "a";
COMMAND.arguments = 2;
COMMAND.optionalArguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		local charName = string.lower(arguments[2]);
		local characters = target:GetCharacters();
		local char = nil;

		for k, v in pairs(characters) do
			if (string.lower(v.name) == charName) then
				char = v;
				break;
			elseif (string.find(string.lower(v.name), charName)) then
				if (!char or string.len(char.name) > string.len(v.name)) then
					char = v;
				end;
			end;
		end;

		if (char) then
			local oldName = player:Name();

			
			local pos = target:GetPos() + Vector(0, 0, 8);
			local angles = target:GetAngles();
			local eyeAngles = target:EyeAngles();

			if (!target:Alive()) then
				target:Spawn();		
			end;

			Clockwork.player:LoadCharacter(target, char.characterID, nil, nil, true);

			if (arguments[4] and
				((tonumber(arguments[4]) and tonumber(arguments[4]) != 0) or 
				arguments[4] == "true" or arguments[4] == true)) then

				target:SetPos(pos);
				target:SetAngles(angles)
				target:SetEyeAngles(eyeAngles)
			end;

			local time = tonumber(arguments[3]);		
			if (time) then
				player.noCharSwap = CurTime() + math.max(math.Round(time), 0);
			end;

			if (target != player) then
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has forced "..oldName.." to use "..target:Name()..".", "group_go");
						end;
					end;
				end;

				player:CPNotify("You have forced "..oldName.." to use "..target:Name()..".", "group_go");
				target:CPNotify(player:Name().." has forced you to use "..target:Name()..".", "group_go");
			else
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player) then
							v:CPNotify(oldName.." has forced themself to use "..player:Name()..".", "group_go");
						end;
					end;
				end;

				player:CPNotify("You have forced yourself to use "..player:Name()..".", "group_go");
			end;
		else
			player:CPNotify(target:Name().." does not have a character with name "..charName..".", "group_delete");
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();