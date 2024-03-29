local COMMAND = Clockwork.command:New("StorageTakeCash")

COMMAND.tip = "CmdStorageTakeCash"
COMMAND.text = "CmdStorageTakeCashDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local storageTable = player:GetStorageTable()

	if storageTable then
		local target = storageTable.entity
		local cash = math.floor(tonumber(arguments[1]))
		if target and not IsValid(target) or not Clockwork.config:Get("cash_enabled"):Get() then return end

		if cash and cash > 1 and cash <= storageTable.cash then
			if not storageTable.CanTakeCash or storageTable.CanTakeCash(player, storageTable, cash) ~= false then
				if not target or not target:IsPlayer() then
					Clockwork.player:GiveCash(player, cash, nil, true)
					Clockwork.storage:UpdateCash(player, storageTable.cash - cash)
				else
					Clockwork.player:GiveCash(player, cash, nil, true)
					Clockwork.player:GiveCash(target, -cash, nil, true)
					Clockwork.storage:UpdateCash(player, target:GetCash())
				end

				if storageTable.OnTakeCash and storageTable.OnTakeCash(player, storageTable, cash) then
					Clockwork.storage:Close(player)
				end
			end
		end
	else
		Clockwork.player:Notify(player, {"YouHaveNoStorageOpen"})
	end
end

COMMAND:Register()
