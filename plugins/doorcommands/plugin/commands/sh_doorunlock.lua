local COMMAND = Clockwork.command:New("DoorUnlock")

COMMAND.tip = "Unlock a door."
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local door = player:GetEyeTraceNoCursor().Entity

	if IsValid(door) and Clockwork.entity:IsDoor(door) then
		door:EmitSound("doors/door_latch3.wav")
		door:Fire("Unlock", "", 0)
		Clockwork.player:Notify(player, "You have unlocked the target door.")
	else
		Clockwork.player:Notify(player, "This is not a valid door!")
	end
end

COMMAND:Register()
