local COMMAND = Clockwork.command:New("ResetQuota")
COMMAND.tip = "Reset a player's beating quota."
COMMAND.text = "<string Player>"
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_FALLENOVER)
COMMAND.arguments = 1

function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if (target) then
		target:Notify(player:Name() .. " has reset your beating quota.")
		player:Notify("You have reset " .. target:Name() .. "'s beating quota.")
		target:SetCharacterData("quota", 0)
		target:SetCharacterData("quotamax", math.random(1, 9))
	end
	if not target then
		player:Notify(arguments[1] .. " is not a valid character!")
	end
end

COMMAND:Register()