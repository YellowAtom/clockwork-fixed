
-- Called when Clockwork has loaded all of the entities.
function cwDynamicAdverts:ClockworkInitPostEntity()
	self:LoadDynamicAdverts()
end

-- Called when a player's data stream info should be sent.
function cwDynamicAdverts:PlayerSendDataStreamInfo(player)
	Clockwork.datastream:Start(player, "DynamicAdverts", self.storedList)
end
