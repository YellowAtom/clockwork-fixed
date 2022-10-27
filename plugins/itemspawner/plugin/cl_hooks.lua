
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

Clockwork.datastream:Hook("ItemSpawnsESPInfo", function(data)
	PLUGIN.itemSpawns = data;
end);

function PLUGIN:GetAdminESPInfo(info)
	if (!Clockwork.Client:IsSuperAdmin()) then
		return;
	end;
	
	if (self.itemSpawns) then
		for k, spawn in pairs(self.itemSpawns) do
			info[#info + 1] = {
				position = spawn.pos + Vector(0, 0, 0),
				text = "Itemspawn #"..k.." ("..spawn.radiusX.."x"..spawn.radiusY.."; NSR: "..spawn.noSpawnRadius..")"
			};
		end;
	end;
end;

function PLUGIN:HUDPaintForeground()
	if (!Clockwork.Client:IsSuperAdmin()) then
		return;
	end;
	
	if (self.itemSpawns and Clockwork.plugin:Call("PlayerCanSeeAdminESP")) then
		for k, spawn in pairs(self.itemSpawns) do
			local pos = spawn.pos; local radiusX = spawn.radiusX; local radiusY = spawn.radiusY;
			local corner1 = (pos + Vector(radiusX, radiusY, -30)):ToScreen();
			local corner2 = (pos + Vector(radiusX, -radiusY, -30)):ToScreen();
			local corner3 = (pos + Vector(-radiusX, -radiusY, -30)):ToScreen();
			local corner4 = (pos + Vector(-radiusX, radiusY, -30)):ToScreen();

			surface.SetDrawColor(255, 255, 255, 255);
			if (corner1.visible and corner2.visible) then
				surface.DrawLine(corner1.x, corner1.y, corner2.x, corner2.y);
			end;
			if (corner2.visible and corner3.visible) then
				surface.DrawLine(corner2.x, corner2.y, corner3.x, corner3.y);
			end;
			if (corner3.visible and corner4.visible) then
				surface.DrawLine(corner3.x, corner3.y, corner4.x, corner4.y);
			end;
			if (corner4.visible and corner1.visible) then
				surface.DrawLine(corner4.x, corner4.y, corner1.x, corner1.y);
			end;

			local noSpawnRadius = spawn.noSpawnRadius
			corner1 = (pos + Vector(noSpawnRadius, noSpawnRadius, -30)):ToScreen();
			corner2 = (pos + Vector(noSpawnRadius, -noSpawnRadius, -30)):ToScreen();
			corner3 = (pos + Vector(-noSpawnRadius, -noSpawnRadius, -30)):ToScreen();
			corner4 = (pos + Vector(-noSpawnRadius, noSpawnRadius, -30)):ToScreen();

			surface.SetDrawColor(255, 0, 0, 255);
			if (corner1.visible and corner2.visible) then
				surface.DrawLine(corner1.x, corner1.y, corner2.x, corner2.y);
			end;
			if (corner2.visible and corner3.visible) then
				surface.DrawLine(corner2.x, corner2.y, corner3.x, corner3.y);
			end;
			if (corner3.visible and corner4.visible) then
				surface.DrawLine(corner3.x, corner3.y, corner4.x, corner4.y);
			end;
			if (corner4.visible and corner1.visible) then
				surface.DrawLine(corner4.x, corner4.y, corner1.x, corner1.y);
			end;
		end;
	end;
end;