--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

include("shared.lua");

function ENT:HUDPaintTargetID(x, y, alpha)
	local colorTargetID = Clockwork.option:GetColor("target_id");
	local colorWhite = Clockwork.option:GetColor("white");
	
	y = Clockwork.kernel:DrawInfo("Finished rations", x, y, colorTargetID, alpha);
	y = Clockwork.kernel:DrawInfo("Filled on "..tostring(self:GetDTInt(1)).."/10", x, y, colorWhite, alpha);

end;

function ENT:Draw()
	self:DrawModel();
end;

