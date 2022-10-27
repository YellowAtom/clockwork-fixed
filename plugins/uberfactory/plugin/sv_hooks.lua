--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

local PLUGIN = PLUGIN;

function PLUGIN:ClockworkInitPostEntity()
	self:LoadFactoryDispensers();
	self:LoadFactoryRationDispensers();
	self:LoadBigFactoryDispensers();
end;

function PLUGIN:PostSaveData()
	self:SaveFactoryDispensers();
	self:SaveFactoryRationDispensers();
	self:SaveBigFactoryDispensers();
end;

--function PLUGIN:PlayerUseRation(player)
	--player:GiveItem(Clockwork.item:CreateInstance("breens_water"), true);
--end;