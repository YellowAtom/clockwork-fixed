--[[
	Author: Arbiter
	Clockwork Version: 0.88a.

	Credits:	A small part of this code comes from kurozael's DoorCommands Plugin.
				Heavily based off the works of Cervidae Kosmonaut in Faction Doors.
--]]

-- A function to load the door data.
function PLUGIN:LoadDoorData()
	self.personalDoors = {}

	local positions = {}
	local personalDoors = Clockwork.kernel:RestoreSchemaData("plugins/personaldoors/" .. game.GetMap())

	for k, v in pairs(ents.GetAll()) do
		if (IsValid(v)) then
			local position = v:GetPos()

			if (position) then
				positions[tostring(position)] = v
			end
		end
	end

	for k, v in pairs(personalDoors) do
		local entity = positions[tostring(v.position)]

		if (IsValid(entity) and !self.personalDoors[entity]) then
			if (Clockwork.entity:IsDoor(entity)) then
				local owners = {}

				for k2, v2 in pairs(v.owners)do
					local owningPerson = v2

					table.insert(owners, owningPerson)

					if(not entity._OwningPersons)then
						entity._OwningPersons = {}
					end

					entity._OwningPersons[string.lower(tostring(owningPerson))] = true
				end

				v.owners = owners

				self.personalDoors[entity] = v

				if(v.startLocked)then
					entity:Fire("Lock", "", 0)
				else
					entity:Fire("Unlock", "", 0)
				end
			end
		end
	end
end

-- A function to save the door data.
function PLUGIN:SaveDoorData()
	local personalDoors = {}

	for k, v in pairs(self.personalDoors) do
		local data = {
			owners = {},
			position = v.position,
			startLocked = v.startLocked
		}

		for k2, v2 in pairs(v.owners)do
			table.insert(data.owners, v2)
		end

		personalDoors[#personalDoors + 1] = data
	end

	Clockwork.kernel:SaveSchemaData("plugins/personaldoors/"..game.GetMap(), personalDoors)
end