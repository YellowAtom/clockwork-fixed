--[[
	Author: Arbiter
	Clockwork Version: 0.88a.

	Credits:	A small part of this code comes from kurozael's DoorCommands Plugin.
				Heavily based off the works of Cervidae Kosmonaut in Faction Doors.
--]]

local PLUGIN = PLUGIN

local COMMAND = Clockwork.command:New("DoorSetAccess")
COMMAND.tip = "Allow a Player to have access to a door."
COMMAND.text = "<string Name> [bool StartLocked]"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"
COMMAND.arguments = 1
COMMAND.optionalArguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local owningGuy = Clockwork.player:FindByID(arguments[1]);
	local owningPerson = owningGuy:Name()

	local door = player:GetEyeTraceNoCursor().Entity
	local lowerName = string.lower(owningPerson)

	if (IsValid(door) and Clockwork.entity:IsDoor(door)) then
		if (not door._OwningPersons or not door._OwningPersons[lowerName]) then
			local owners = {}

			if(not door._OwningPersons)then
				door._OwningPersons = {}
			end

			door._OwningPersons[lowerName] = true

			if (not Clockwork.entity:IsDoorUnownable(door))then
				Clockwork.entity:SetDoorUnownable(door, true)
			end

			if(PLUGIN.personalDoors[door])then
				owners = PLUGIN.personalDoors[door]
			end

			table.insert(owners, owningPerson)

			PLUGIN.personalDoors[door] = {
				owners = owners,
				position = door:GetPos(),
				startLocked = Clockwork.kernel:ToBool(arguments[2])
			}
			PLUGIN:SaveDoorData()

			Clockwork.player:Notify(player, "You have allowed '".. owningPerson .."' access to this door.")
		else
			Clockwork.player:Notify(player, "This Player already has access to this door!")
		end
	else
		Clockwork.player:Notify(player, "This is not a valid door!")
	end
end

COMMAND:Register();