
local playerMeta = FindMetaTable("Player");

function playerMeta:IsStealthMode()
	return self.cwStealthMode;
end;
