function PLUGIN:PhysgunPickup(ply, ent)
	for k, v in pairs(NoGrabEnts) do
		if (v == ent) then
			return false;
		end;
	end;
end;