local COMMAND = Clockwork.command:New("PlyRespawnStay")

COMMAND.tip = "CmdPlyRespawnStay"
COMMAND.text = "CmdPlyRespawnStayDesc"
COMMAND.arguments = 1
COMMAND.access = "o"

COMMAND.alias = {"PlyRStay"}

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if target then
		Clockwork.player:LightSpawn(target, true, true, false)

		Clockwork.player:Notify(player, {"PlayerWasRespawnedToDeath", target:GetName()})
	else
		Clockwork.player:Notify(player, {"NotValidTarget", arguments[1]})
	end
end

COMMAND:Register()
