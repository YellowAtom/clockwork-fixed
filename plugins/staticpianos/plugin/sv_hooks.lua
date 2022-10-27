--[[
	© March 2014 Polis
    You may re-distribute this plugin with permission from the author.
--]]

local PLUGIN = PLUGIN;

function PLUGIN:ClockworkInitPostEntity()
	self:LoadPianos();
end;

function PLUGIN:PostSaveData()
	self:SavePianos();
end;
