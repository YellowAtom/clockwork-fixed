
-- Called when Clockwork has loaded all of the entities.
function cwAreaDisplays:ClockworkInitPostEntity()
	self:LoadAreaDisplays()
end

-- Called when a player's data stream info should be sent.
function cwAreaDisplays:PlayerSendDataStreamInfo(player)
	Clockwork.datastream:Start(player, "AreaDisplays", self.storedList)
end
