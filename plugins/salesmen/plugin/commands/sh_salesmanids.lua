local COMMAND = Clockwork.command:New("SalesmanIDs")

COMMAND.tip = "List all saved salesman import IDs with their names."
COMMAND.text = "< None >"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "s"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	-- Restore imports storage
	local imports = Clockwork.kernel:RestoreSchemaData("plugins/salesmen/imports", {})

	if table.Count(imports) == 0 then
		Clockwork.player:Notify(player, "No saved salesman imports found.")
		return
	end

	-- Build the list
	local message = "Saved Salesman Imports:\n"
	message = message .. string.rep("-", 60) .. "\n"

	for importID, salesmanData in pairs(imports) do
		local name = salesmanData.name or "Unknown"
		message = message .. importID .. " | " .. name .. "\n"
	end

	message = message .. string.rep("-", 60) .. "\n"
	message = message .. "Total: " .. table.Count(imports) .. " salesman(s)"

	Clockwork.player:Notify(player, message)
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has listed all saved salesman import IDs.")
end

COMMAND:Register()
