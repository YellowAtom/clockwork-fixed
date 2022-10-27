
local COMMAND = Clockwork.command:New("PlyViewRecord");
COMMAND.tip = "View someone's player record (even if they are offline).";
COMMAND.text = "<string Name>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	local steamID = nil;
	local steamName = nil;
	
	if (target) then
		steamID = target:SteamID();
		steamName = target:SteamName();
	elseif (string.find(arguments[1], "STEAM_(%d+):(%d+):(%d+)")) then
		steamID = arguments[1]
	else
		player:CPNotify(arguments[1].." is not a valid character or steamID!", Clockwork.option:GetKey("invalid_target_icon"));
	end;

	local player_records_table = Clockwork.option:GetKey("cp_player_records_table");
	local queryObj = Clockwork.database:Select(player_records_table);
		queryObj:AddWhere("_SteamID = ?", steamID);
		queryObj:SetCallback(function(result)
			if (Clockwork.database:IsResult(result)) then
				local recordTable = Clockwork.player:ConvertDataString(nil, result[1]._Record);
				Clockwork.datastream:Start(player, "view_player_record", {steamID, recordTable, steamName});
			else
				if (steamName) then
					player:CPNotify("No record found for "..steamName..".");
				else
					player:CPNotify("No record found for "..arguments[1]..".");
				end;
			end;
		end);
	queryObj:Pull();
end;

COMMAND:Register();