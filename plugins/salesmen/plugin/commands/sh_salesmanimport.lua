local COMMAND = Clockwork.command:New("SalesmanImport")

COMMAND.tip = "Copy a salesman's data to be exported on other maps with SalesmanExport."
COMMAND.text = "< None >"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "s"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = player:GetEyeTraceNoCursor().Entity

	if IsValid(target) then
		if target:GetClass() == "cw_salesman" then
			-- Get salesman data from the entity (same as salesmancopy)
			local salesmanData = cwSalesmen:GetTableFromEntity(target)

			-- Generate a unique ID for this import
			local importID = "salesman_" .. os.time() .. "_" .. math.random(1000, 9999)

			-- Save to schema imports storage
			local imports = Clockwork.kernel:RestoreSchemaData("plugins/salesmen/imports", {})
			imports[importID] = salesmanData

			-- Save back to file
			Clockwork.kernel:SaveSchemaData("plugins/salesmen/imports", imports)

			Clockwork.player:Notify(player, "Salesman imported with ID: " .. importID)
			Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has imported salesman '" .. salesmanData.name .. "' with ID: " .. importID)
		else
			Clockwork.player:Notify(player, "This entity is not a salesman!")
		end
	else
		Clockwork.player:Notify(player, "You must look at a valid entity!")
	end
end

COMMAND:Register()
