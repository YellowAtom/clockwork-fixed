
-- Called when Clockwork has loaded all of the entities.
function cwDoorCmds:ClockworkInitPostEntity()
	self:LoadDoorData()
	self:LoadParentData()

	if Clockwork.config:Get("doors_save_state"):Get() then
		self:LoadDoorStates()
	end
end

function cwDoorCmds:PostSaveData()
	self:SaveDoorData()
	self:SaveParentData()

	if Clockwork.config:Get("doors_save_state"):Get() and #player.GetAll() > 0 then
		self:SaveDoorStates()
	end
end
