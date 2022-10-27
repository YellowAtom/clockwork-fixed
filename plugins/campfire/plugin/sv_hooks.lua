local PLUGIN = PLUGIN;

-- Called when Clockwork has loaded all of the entities.
function PLUGIN:ClockworkInitPostEntity()
	PLUGIN:LoadCampfires()
end;

-- Called just after data should be saved.
function PLUGIN:PostSaveData()
	PLUGIN:SaveCampfires();
end;

-- Called when a player initially spawns.
function PLUGIN:PlayerInitialSpawn(player)
	timer.Simple( 1, function() 
		for k, v in ipairs(ents.FindByClass("cw_campfire")) do
			v:stopFire();
			v:startFire();
		end;
	end);
end;