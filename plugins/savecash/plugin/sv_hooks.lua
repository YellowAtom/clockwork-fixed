
-- Called when Clockwork has loaded all of the entities.
function cwSaveCash:ClockworkInitPostEntity()
	if Clockwork.config:Get("cash_enabled"):Get() then
		self:LoadCash()
	end
end

-- Called just after data should be saved.
function cwSaveCash:PostSaveData()
	self:SaveCash()
end
