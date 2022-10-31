local COMMAND = Clockwork.command:New("SetClass")

COMMAND.tip = "CmdSetClass"
COMMAND.text = "CmdSetClassDesc"
COMMAND.flags = CMD_HEAVY
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local class = Clockwork.class:FindByID(arguments[1])

	if player:InVehicle() then
		Clockwork.player:Notify(player, {"CannotActionRightNow"})

		return
	end

	if class then
		local limit = Clockwork.class:GetLimit(class.name)

		if Clockwork.plugin:Call("PlayerCanBypassClassLimit", player, class.index) then
			limit = game.MaxPlayers()
		end

		if cwTeam.NumPlayers(class.index) < limit then
--			local previousTeam = player:Team()

			if player:Team() ~= class.index and Clockwork.kernel:HasObjectAccess(player, class) then
				if Clockwork.plugin:Call("PlayerCanChangeClass", player, class) then
					local wasSuccess, fault = Clockwork.class:Set(player, class.index, nil, true)

					if not wasSuccess then
						Clockwork.player:Notify(player, fault)
					end
				end
			else
				Clockwork.player:Notify(player, {"YouHaveNoAccessToClass"})
			end
		else
			Clockwork.player:Notify(player, {"TooManyCharactersWithClass"})
		end
	else
		Clockwork.player:Notify(player, {"ClassNotValid"})
	end
end

COMMAND:Register()
