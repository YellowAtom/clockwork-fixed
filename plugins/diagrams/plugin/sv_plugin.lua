function PLUGIN:PlayerRestoreCharacterData(player, data)
	if (!data["KnownBlueprints"]) then
		data["KnownBlueprints"] = {};
	end;
end;

function PLUGIN:PlayerCharacterInitialized(player)
	player:NetworkBlueprints();
end;

local playerMeta = FindMetaTable("Player");

function playerMeta:NetworkBlueprints()
	local knownBlueprints = self:GetCharacterData("KnownBlueprints");

	Clockwork.datastream:Start(self, "AllBlueprints", knownBlueprints);
end;