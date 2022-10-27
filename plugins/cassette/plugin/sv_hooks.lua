local Clockwork = Clockwork;
local PLUGIN = PLUGIN;

-- Called when OpenAura has loaded all of the entities.
function PLUGIN:ClockworkInitPostEntity()
    self:LoadCassettes();
end;

-- Called when data should be saved.
function PLUGIN:SaveData()
	self:SaveCassettes();
end;