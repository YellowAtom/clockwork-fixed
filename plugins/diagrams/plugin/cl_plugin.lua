Clockwork.datastream:Hook("AllBlueprints", function(data)
	Clockwork.KnownBlueprints = {};

	for k, v in pairs(data) do
		Clockwork.KnownBlueprints[k] = v;
	end;
end);