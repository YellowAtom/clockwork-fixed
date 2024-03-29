local COMMAND = Clockwork.command:New("PlySetHealth")

COMMAND.tip = "CmdPlySetHealth"
COMMAND.text = "CmdPlySetHealthDesc"
COMMAND.arguments = 2
COMMAND.access = "o"

COMMAND.alias = {"PlyHealth"}

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])
	local health = tonumber(arguments[2])

	if isnumber(health) then
		target:SetHealth(health)

		Clockwork.player:Notify(player, {"PlayersHealthWasSet", target:GetName(), health})

		Clockwork.player:Notify(target, {"YourHealthWasSet", health, player:GetName()})
	end
end

COMMAND:Register()
