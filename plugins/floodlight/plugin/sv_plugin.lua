local PLUGIN = PLUGIN;

-- A function to load the union light.
function PLUGIN:LoadFloodLights()
	local floodLights = Clockwork.kernel:RestoreSchemaData( "plugins/floodlights/"..game.GetMap() );

	for k, v in pairs(floodLights) do
		local entity = ents.Create("cw_floodlight");
		
		Clockwork.player:GivePropertyOffline(v.key, v.uniqueID, entity);
		
		entity:SetAngles(v.angles);
		entity:SetPos(v.position);
		entity:Spawn();
		entity:SetDTInt(0, v.state or 1);
		
		if (!v.moveable) then
			local physicsObject = entity:GetPhysicsObject();
			
			if ( IsValid(physicsObject) ) then
				physicsObject:EnableMotion(false);
			end;
		end;
	end;
end;

-- A function to save the union light.
function PLUGIN:SaveFloodLights()
	local floodLights = {};

	for k, v in pairs( ents.FindByClass("cw_floodlight") ) do
		local physicsObject = v:GetPhysicsObject();
		local moveable;
		
		if ( IsValid(physicsObject) ) then
			moveable = physicsObject:IsMoveable();
		end;
		
		floodLights[#floodLights + 1] = {
			key = Clockwork.entity:QueryProperty(v, "key"),
			angles = v:GetAngles(),
			moveable = moveable,
			uniqueID = Clockwork.entity:QueryProperty(v, "uniqueID"),
			position = v:GetPos(),
			state = v:GetDTInt(0)
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/floodlights/"..game.GetMap(), floodLights);
end;