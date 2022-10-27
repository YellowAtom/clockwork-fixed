local PLUGIN = PLUGIN;

function PLUGIN:SavePianos()
	local pianos = {};
	
	for k, v in pairs(ents.FindByClass("gmt_instrument_piano")) do
		pianos[#pianos + 1] = {
			angles = v:GetAngles(),
			position = v:GetPos()
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/pianos/"..game.GetMap(), pianos);
end;

function PLUGIN:LoadPianos()
	local pianos = Clockwork.kernel:RestoreSchemaData( "plugins/pianos/"..game.GetMap() );
	
	for k, v in pairs(pianos) do
		local entity = ents.Create("gmt_instrument_piano");
		
		entity:SetPos(v.position);
		entity:Spawn();
		
		local physicsObject = entity:GetPhysicsObject();		
		if (IsValid(physicsObject)) then
			physicsObject:EnableMotion(false);
		end;
		
		if (IsValid(entity)) then
			entity:SetAngles(v.angles);
		end;
	end;
end;