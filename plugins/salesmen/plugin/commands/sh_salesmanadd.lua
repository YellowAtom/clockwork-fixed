local COMMAND = Clockwork.command:New("SalesmanAdd")

COMMAND.tip = "Add a salesman at your target position."
COMMAND.text = "< None >"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "s"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	player.cwSalesmanSetup = true
	player.cwSalesmanHitPos = player:GetEyeTraceNoCursor().HitPos

	Clockwork.datastream:Start(player, "SalesmanAdd", true)
end

COMMAND:Register()
