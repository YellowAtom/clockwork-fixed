local COMMAND = Clockwork.command:New("StorageClose")

COMMAND.tip = "CmdStorageClose"
COMMAND.flags = CMD_DEFAULT

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local storageTable = player:GetStorageTable()

	if storageTable then
		Clockwork.storage:Close(player, true)
	else
		Clockwork.player:Notify(player, {"YouHaveNoStorageOpen"})
	end
end

COMMAND:Register()
