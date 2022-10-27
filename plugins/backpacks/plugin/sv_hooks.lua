
local Clockwork = Clockwork;
local PLUGIN = PLUGIN;

-- Called when a player's character data should be saved.
function PLUGIN:PlayerSaveCharacterData(player, data)
	if (data["backpackTable"]) then
		for k, v in pairs (data["backpackTable"]) do
			data["backpackTable"][k] = math.Clamp(math.Round(v), 0, 10);
		end;
	else
		data["backpackTable"] = {};
	end;
end;

-- Ensure there are no problems int he backpack table, otherwise fix them
function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	if (firstSpawn) then
		local tempTable = {};
		for _, items in pairs(player:GetInventory()) do
			for _, item in pairs(items) do
				if (item("slot") and item("slotSpace")) then
					if (item:GetData("equipped", false)) then
						local space = tempTable[item("slot")] or 0;
						if (space + item("slotSpace") <= 10) then
							tempTable[item("slot")] = space + item("slotSpace");
						else
							item:SetData("equipped", false);
						end;
					end;
				else
					break;
				end;
			end;
		end;

		player:SetCharacterData("backpackTable", tempTable);
	end;
end;

-- Called when a player's character data should be restored.
function PLUGIN:PlayerRestoreCharacterData(player, data)
	data["backpackTable"] = data["backpackTable"] or {};
end;