--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

local PLUGIN = PLUGIN;

function PLUGIN:ClockworkInitPostEntity()
	self:LoadGarbageSpawnPoints();
end;

function PLUGIN:Tick()
	local curTime = CurTime();
	
	for k,v in pairs(self.garbagePoints) do
		if (curTime > v.nextSpawn) then
			if (self:haveItemHere(v.position)) then
				self:SpawnGarbage(v);
				v.nextSpawn = curTime + math.Round(Clockwork.config:Get("garbage_respawn_tick"):Get());
				
			else
				v.nextSpawn = curTime + math.Round(Clockwork.config:Get("garbage_respawn_tick"):Get());
			end;
		end;
	end;
end;

function PLUGIN:PlayerTakeGarbage(player, entity)
	local curTime = CurTime();
	
	for k, v in pairs(self.garbagePoints) do
		if (v.position:Distance(entity:GetPos()) <= 10) then
			v.nextSpawn = curTime + math.Round(Clockwork.config:Get("garbage_respawn_tick"):Get());
		end;
	end

	local random = math.random(100);
					
	if (random >= Clockwork.config:Get("garbage_rate"):Get()) then
		local itemTable = player:GiveItem(table.Random(entity.items));

		if (itemTable) then
			Clockwork.player:Notify(player, "You searched the trash and found: "..itemTable("name")..".");
		else
			Clockwork.player:Notify(player, fault);
		end;
	else
		Clockwork.player:Notify(player, "You searched the trash and unfortunately found nothing of use.");
	end;
end;