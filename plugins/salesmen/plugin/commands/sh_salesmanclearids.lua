local COMMAND = Clockwork.command:New("SalesmanClearIDs")

COMMAND.tip = "Clear all saved salesman import IDs for optimization."
COMMAND.text = "< None >"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "s"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	-- Restore imports storage to check if there's anything to clear
	local imports = Clockwork.kernel:RestoreSchemaData("plugins/salesmen/imports", {})

	if table.Count(imports) == 0 then
		Clockwork.player:Notify(player, "No saved salesman imports to clear.")
		return
	end

	local count = table.Count(imports)

	-- Clear the imports by saving an empty table
	Clockwork.kernel:SaveSchemaData("plugins/salesmen/imports", {})

	Clockwork.player:Notify(player, "Cleared " .. count .. " salesman import(s) from storage.")
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has cleared " .. count .. " salesman import ID(s) from storage for optimization.")
end

COMMAND:Register()
