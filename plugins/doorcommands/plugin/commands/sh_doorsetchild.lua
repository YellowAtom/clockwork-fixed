local COMMAND = Clockwork.command:New("DoorSetChild")

COMMAND.tip = "Add a child to the active parent door."
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "a"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local door = player:GetEyeTraceNoCursor().Entity

	if IsValid(door) and Clockwork.entity:IsDoor(door) then
		if IsValid(player.cwParentDoor) then
			if cwDoorCmds.parentData[door] ~= player.cwParentDoor then
				if player.cwParentDoor ~= door then
					cwDoorCmds.parentData[door] = player.cwParentDoor
					Clockwork.entity:SetDoorParent(door, player.cwParentDoor)
					Clockwork.player:Notify(player, "You have added this as a child to the active parent door.")
					cwDoorCmds.infoTable = cwDoorCmds.infoTable or {}
					table.insert(cwDoorCmds.infoTable, door)
					Clockwork.datastream:Start(player, "doorParentESP", cwDoorCmds.infoTable)
				else
					Clockwork.player:Notify(player, "You cannot parent the active parent door to itself!")
				end
			else
				Clockwork.player:Notify(player, "This door is already a child to the active parent door!")
			end
		else
			Clockwork.player:Notify(player, "You have not selected a valid parent door!")
		end
	else
		Clockwork.player:Notify(player, "This is not a valid door!")
	end
end

COMMAND:Register()
