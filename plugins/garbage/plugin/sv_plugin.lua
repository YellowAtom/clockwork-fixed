--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

Clockwork.config:Add("garbage_respawn_tick", 400);
Clockwork.config:Add("garbage_clean_time", 5, true);
Clockwork.config:Add("garbage_rate", 70);

function PLUGIN:SaveItemAutoSpawnPoints()
	Clockwork.kernel:SaveSchemaData("plugins/garbagepoint/"..game.GetMap(), self.garbagePoints);
end;

function PLUGIN:LoadGarbageSpawnPoints()
	self.garbagePoints = Clockwork.kernel:RestoreSchemaData("plugins/garbagepoint/"..game.GetMap());
	
	if (!self.garbagePoints) then
		self.garbagePoints = {};
	end;
	
	for k, v in pairs(self.garbagePoints) do
		v.nextSpawn = 0;
	end;
end;

function PLUGIN:haveItemHere(position)
	local props = ents.FindInSphere(position,50);
	
	if (props) then
		for k2, v2 in pairs(props) do
			if (IsValid(v2) && v2:GetClass() == "cw_garbage") then
				return false;
			end
		end;
	end;

	return true;
end;

function PLUGIN:SpawnGarbage(pointTable)
	local entity = ents.Create("cw_garbage");
	
	entity:SetPos(pointTable.position);
	entity:Spawn();
	
	if (IsValid(entity)) then
		entity:SetAngles( pointTable.angles );
	end;
end;
