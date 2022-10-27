
local Clockwork = Clockwork;
local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("PlyAddNote");
COMMAND.tip = "Adds a note on a player's record.";
COMMAND.text = "<string Name/SteamID> <string Note>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local identifier = arguments[1];
	local target = Clockwork.player:FindByID(identifier)

	if (target) then
		if (!Clockwork.player:IsProtected(identifier)) then
			local note = table.concat(arguments, " ", 2);
			if (note) then
				PLUGIN:PlayerLog(target, "note", note, player);
				player:CPNotify("You have added a note to "..target:Name()..".", "note");
			else
				player:CPNotify("You did not specify a valid note!", "note_delete");
			end;
		else
			player:CPNotify(target:Name().." is protected!", "shield");
		end;
	elseif (string.find(identifier, "STEAM_(%d+):(%d+):(%d+)")) then
		local note = table.concat(arguments, " ", 2);
		if (note) then
			local players = _player.GetAll();
			local identifier = string.upper(identifier);
			for k, v in pairs(players) do
				if (v:SteamID() == identifier) then
					PLUGIN:PlayerLog(v, "note", note, player);
					return;
				end;
			end;

			local queryObj = Clockwork.database:Select(playersTable);
				queryObj:AddWhere("_SteamID = ?", identifier);
				queryObj:SetCallback(function(result)	
					local steamName = identifier;
					if (Clockwork.database:IsResult(result)) then
						steamName = result[1]._SteamName;
					end;

					PLUGIN:OfflinePlayerLog(steamName, identifier, "note", note, player:SteamName());
					player:CPNotify("You have added a note to "..steamName..".", "note");
				end);
			queryObj:Pull();
		else
			player:CPNotify("You did not specify a valid note!", "note_delete");
		end;
	else
		player:CPNotify(identifier.." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

COMMAND:Register();