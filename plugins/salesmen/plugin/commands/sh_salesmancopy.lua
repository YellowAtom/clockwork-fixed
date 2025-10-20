local COMMAND = Clockwork.command:New("SalesmanCopy")

COMMAND.tip = "Copy a salesman's data for later use with SalesmanPaste."
COMMAND.text = "< None >"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "s"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = player:GetEyeTraceNoCursor().Entity

	if IsValid(target) then
		if target:GetClass() == "cw_salesman" then
			-- Use the existing function to get salesman data
			local salesmanData = cwSalesmen:GetTableFromEntity(target)

			-- Store in player clipboard (following generic items pattern)
			player.cwSalesmanClipboard = salesmanData

			Clockwork.player:Notify(player, "Salesman data copied successfully! Use SalesmanPaste to create a duplicate.")
		else
			Clockwork.player:Notify(player, "This entity is not a salesman!")
		end
	else
		Clockwork.player:Notify(player, "You must look at a valid entity!")
	end
end

COMMAND:Register()
