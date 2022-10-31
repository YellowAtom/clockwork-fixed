local COMMAND = Clockwork.command:New("StorageTakeItem")

COMMAND.tip = "CmdStorageTakeItem"
COMMAND.text = "CmdStorageTakeItemDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.arguments = 2

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local storageTable = player:GetStorageTable()
	local uniqueID = arguments[1]
	local itemID = tonumber(arguments[2])

	if storageTable and (not storageTable.entity or IsValid(storageTable.entity)) then
		local itemTable = Clockwork.inventory:FindItemByID(storageTable.inventory, uniqueID, itemID)

		if not itemTable then
			Clockwork.player:Notify(player, {"StorageHasNoInstance"})

			return
		end

		Clockwork.storage:TakeFrom(player, itemTable)
	else
		Clockwork.player:Notify(player, {"YouHaveNoStorageOpen"})
	end
end

COMMAND:Register()
