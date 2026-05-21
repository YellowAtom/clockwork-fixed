local COMMAND = Clockwork.command:New("InvAction")

COMMAND.tip = "CmdInvAction"
COMMAND.text = "CmdInvActionDesc"
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_FALLENOVER)
COMMAND.arguments = 2
COMMAND.optionalArguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local itemAction = string.lower(arguments[1])
	local itemTable = player:FindItemByID(arguments[2], tonumber(arguments[3]))

	if itemTable then
		local customFunctions = itemTable("customFunctions")

		if customFunctions then
			for k, v in pairs(customFunctions) do
				if string.lower(v) == itemAction then
					if itemTable.OnCustomFunction then
						itemTable:OnCustomFunction(player, v)

						return
					end
				end
			end
		end

		if itemAction == "destroy" then
			if Clockwork.plugin:Call("PlayerCanDestroyItem", player, itemTable) then
				Clockwork.item:Destroy(player, itemTable)
			end
		elseif itemAction == "drop" then
			local position = player:GetEyeTraceNoCursor().HitPos

			if player:GetShootPos():Distance(position) <= 192 then
				if Clockwork.plugin:Call("PlayerCanDropItem", player, itemTable, position) then
					Clockwork.item:Drop(player, itemTable)
				end
			else
				Clockwork.player:Notify(player, {"CannotDropItemFar"})
			end
		elseif itemAction == "use" then
			if player:InVehicle() and itemTable("useInVehicle") == false then
				Clockwork.player:Notify(player, {"CannotUseItemInVehicle"})

				return
			end

			if Clockwork.plugin:Call("PlayerCanUseItem", player, itemTable) then return Clockwork.item:Use(player, itemTable) end
		else
			Clockwork.plugin:Call("PlayerUseUnknownItemFunction", player, itemTable, itemAction)
		end
	else
		Clockwork.player:Notify(player, {"YouHaveNoInstanceOfThisItem"})

		-- Self-heal ghost items: if the client sent a valid uniqueID and itemID
		-- but the server doesn't have it, send InvTake to purge the phantom.
		local uniqueID = arguments[2]
		local itemID = tonumber(arguments[3])

		if uniqueID and itemID and Clockwork.item:FindByID(uniqueID) then
			Clockwork.datastream:Start(player, "InvTake", {uniqueID, itemID})
			Clockwork.kernel:PrintLog(LOGTYPE_MINOR, player:Name() .. " had ghost item purged: " .. uniqueID .. " (ID: " .. itemID .. ")")
		end
	end
end

COMMAND:Register()
