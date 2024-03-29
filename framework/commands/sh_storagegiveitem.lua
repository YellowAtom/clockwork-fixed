local COMMAND = Clockwork.command:New("StorageGiveItem")

COMMAND.tip = "CmdStorageGiveItem"
COMMAND.text = "CmdStorageGiveItemDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.arguments = 2

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local storageTable = player:GetStorageTable()
	local uniqueID = arguments[1]
	local itemID = tonumber(arguments[2])

	if storageTable and (not storageTable.entity or IsValid(storageTable.entity)) then
		local itemTable = player:FindItemByID(uniqueID, itemID)

		if not itemTable then
			Clockwork.player:Notify(player, {"YouHaveNoInstanceOfThisItem"})

			return
		end

		if storageTable.isOneSided then
			Clockwork.player:Notify(player, {"YouCannotGiveItemsToThisContainer"})

			return
		end

		Clockwork.storage:GiveTo(player, itemTable)
	else
		Clockwork.player:Notify(player, {"YouHaveNoStorageOpen"})
	end
end

COMMAND:Register()
