local PLUGIN = PLUGIN;

-- Called when Clockwork has loaded all of the entities.
function PLUGIN:ClockworkInitPostEntity()
	self:LoadCampfires();
end;

-- Called just after data should be saved.
function PLUGIN:PostSaveData()
	self:SaveCampfires();
end;

-- A function to load the Union locks.
function PLUGIN:LoadCampfires()
	local campFires = Clockwork.kernel:RestoreSchemaData( "plugins/campfires/"..game.GetMap() );
	
	for k, v in pairs(campFires) do
		local entity = ents.Create("cw_campfire");
		entity:SetAngles(v.angles);
		entity:SetPos(v.position);
		entity:Spawn();
	end;
end;

-- A function to save the Union locks.
function PLUGIN:SaveCampfires()
	local campFires = {};
	
	for k, v in pairs(ents.FindByClass("cw_campfire")) do
		campFires[#campFires + 1] = {
			angles = v:GetAngles(),
			position = v:GetPos(),
			uniqueID = Clockwork.entity:QueryProperty(v, "uniqueID")
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/campfires/"..game.GetMap(), campFires);
end;