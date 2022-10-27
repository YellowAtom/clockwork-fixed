--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

function PLUGIN:SaveFactoryDispensers()
	local dispensers = {};
	
	for k, v in pairs(ents.FindByClass("cw_factorydispenser")) do
		dispensers[#dispensers + 1] = {
			type = v:GetSpawnType(),
			angles = v:GetAngles(),
			position = v:GetPos()
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/factorydispensers/"..game.GetMap(), dispensers);
end;

function PLUGIN:LoadFactoryDispensers()
	local dispensers = Clockwork.kernel:RestoreSchemaData( "plugins/factorydispensers/"..game.GetMap() );
	
	for k, v in pairs(dispensers) do
		local entity = ents.Create("cw_factorydispenser");
		
		entity:SetPos(v.position);
		entity:Spawn();
		
		if (IsValid(entity)) then
			entity:SetAngles(v.angles);
			entity:SetSpawnType(v.type);
		end;
	end;
end;

function PLUGIN:SaveFactoryRationDispensers()
	local dispensers = {};
	
	for k, v in pairs(ents.FindByClass("cw_factoryrationdispenser")) do
		dispensers[#dispensers + 1] = {
			count = v:GetRationCount(),
			angles = v:GetAngles(),
			locked = v:IsLocked(),
			position = v:GetPos()
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/factoryrationdispensers/"..game.GetMap(), dispensers);
end;

function PLUGIN:LoadFactoryRationDispensers()
	local dispensers = Clockwork.kernel:RestoreSchemaData( "plugins/factoryrationdispensers/"..game.GetMap() );
	
	for k, v in pairs(dispensers) do
		local entity = ents.Create("cw_factoryrationdispenser");
		
		entity:SetPos(v.position);
		entity:Spawn();
		
		if (IsValid(entity)) then
			entity:SetAngles(v.angles);
			entity:SetRationCount(v.count);
			
			if (!v.locked) then
				entity:Unlock();
			else
				entity:Lock();
			end;
		end;
	end;
end;

function PLUGIN:SaveBigFactoryDispensers()
	local dispensers = {};
	
	for k, v in pairs(ents.FindByClass("cw_bigfactorydispenser")) do
		dispensers[#dispensers + 1] = {
			type = v:GetSpawnType(),
			angles = v:GetAngles(),
			position = v:GetPos()
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/bigfactorydispensers/"..game.GetMap(), dispensers);
end;

function PLUGIN:LoadBigFactoryDispensers()
	local dispensers = Clockwork.kernel:RestoreSchemaData( "plugins/bigfactorydispensers/"..game.GetMap() );
	
	for k, v in pairs(dispensers) do
		local entity = ents.Create("cw_bigfactorydispenser");
		
		entity:SetPos(v.position);
		entity:Spawn();
		
		if (IsValid(entity)) then
			entity:SetAngles(v.angles);
			entity:SetSpawnType(v.type);
		end;
	end;
end;