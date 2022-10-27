--[[
	Plugin made by Ghost for Undetermined Gaming
	CharUnPK Command
--]]

local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("CharUnPK");
COMMAND.tip = "UnPKs a character.";
COMMAND.text = "<string Name>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local charName = string.lower(arguments[1]);
	for k, v in pairs(player.GetAll()) do
		if (v:HasInitialized()) then
			if (string.lower(v:Name()) == charName) then
				Clockwork.player:NotifyAll(player:Name().." unPKed the character '"..arguments[1].."'.");
				PLUGIN:UnPKPlayer(charName, charName:GetRagdollEntity());
				
				return;
			else
				for k2, v2 in pairs(v:GetCharacters()) do
					if (string.lower(v2.name) == charName) then
						Clockwork.player:NotifyAll(player:Name().." unPKed the character '"..arguments[1].."'.");
						PLUGIN:UnPKPlayer(charName, charName:GetRagdollEntity());
						
						v2.data["permakilled"] = false;
						
						return;
					end;
				end;
			end;
		end;
	end;
	
	local charactersTable = Clockwork.config:Get("mysql_characters_table"):Get();
	local charName = arguments[1];
	
	local queryObj = Clockwork.database:Select(charactersTable);
		queryObj:SetCallback(function(result)
			if (Clockwork.database:IsResult(result)) then
				local queryObj = Clockwork.database:Update(charactersTable);
					queryObj:Replace("_Data", "\"permakilled\":true", "\"permakilled\":false");
					queryObj:AddWhere("_Name = ?", charName);
				queryObj:Push();
				
				Clockwork.player:NotifyAll(player:Name().." unPKed the character '"..arguments[1].."'.");
			else
				Clockwork.player:Notify(player, "This is not a valid character!");
			end;
		end);
		queryObj:AddWhere("_Name = ?", charName);
	queryObj:Pull();
end;

COMMAND:Register();