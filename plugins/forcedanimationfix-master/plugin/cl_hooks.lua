Clockwork.datastream:Hook("ForcedAnimResetCycle", function(data)
	if (!IsValid(data.player)) then return; end;
	data.player:SetCycle(0);
end);
