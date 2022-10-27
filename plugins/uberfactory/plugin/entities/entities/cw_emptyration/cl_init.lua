--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

include("shared.lua");

function ENT:HUDPaintTargetID(x, y, alpha)
	local colorTargetID = Clockwork.option:GetColor("target_id");
	local colorWhite = Clockwork.option:GetColor("white");
	
	y = Clockwork.kernel:DrawInfo("Ration", x, y, colorTargetID, alpha);
	
	local item1 = "<empty>";
	local item2 = "<empty>";
		
	if (self:GetDTBool(1)) then
		item1 = "Breen's Water";
	end;
		
	if (self:GetDTBool(2)) then
		item2 = "Citizen Supplements";
	end;
	
	y = Clockwork.kernel:DrawInfo("Items: "..item1..", "..item2, x, y, colorWhite, alpha);
	
	if (self:GetDTBool(1) and self:GetDTBool(2)) then
		y = Clockwork.kernel:DrawInfo("Ready for packing!", x, y, colorWhite, alpha);
	end;
end;

function ENT:Draw()
	self:DrawModel();
end;

