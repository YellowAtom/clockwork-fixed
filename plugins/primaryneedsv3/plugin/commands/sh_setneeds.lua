local COMMAND = Clockwork.command:New("CharSetNeeds")

COMMAND.tip = "Set all of a player's needs."
COMMAND.text = "<string Name> <number Amount>"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"
COMMAND.arguments = 2

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])
	local amount = arguments[2]

	if not amount then
		amount = 100
	end

	if target then
		target:SetCharacterData("thirst", amount)
		target:SetCharacterData("hunger", amount)
		target:SetCharacterData("sleep", amount)

		if player ~= target then
			Clockwork.player:Notify(target, player:Name() .. " has set all of your needs to " .. amount .. ".")
			Clockwork.player:Notify(player, "You have set all of " .. target:Name() .. "'s needs to " .. amount .. ".")
		else
			Clockwork.player:Notify(player, "You have set all of your own needs to " .. amount .. ".")
		end
	else
		Clockwork.player:Notify(player, arguments[1] .. " is not a valid player!")
	end
end

COMMAND:Register()
