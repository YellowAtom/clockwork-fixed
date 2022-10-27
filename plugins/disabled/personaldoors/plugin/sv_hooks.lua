--[[
	Author: Arbiter
	Clockwork Version: 0.88a.

	Credits:	A small part of this code comes from kurozael's DoorCommands Plugin.
				Heavily based off the works of Cervidae Kosmonaut in Faction Doors.
--]]

local PLUGIN = PLUGIN

-- Called when Clockwork has loaded all of the entities.
function PLUGIN:ClockworkInitPostEntity()
	self:LoadDoorData()
end

-- Called to check if a player does have door access.
function PLUGIN:PlayerDoesHaveDoorAccess(player, door, access, isAccurate)
	if(door._OwningPersons and access == DOOR_ACCESS_BASIC)then
		local owningPerson = player:Name()

		if(owningPerson and door._OwningPersons[string.lower(owningPerson)])then
			return true
		end
	end
end