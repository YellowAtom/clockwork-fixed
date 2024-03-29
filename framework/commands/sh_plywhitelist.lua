local Clockwork = Clockwork

local COMMAND = Clockwork.command:New("PlyWhitelist")
COMMAND.tip = "CmdPlyWhitelist"
COMMAND.text = "CmdPlyWhitelistDesc"
COMMAND.access = "s"
COMMAND.arguments = 2

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if target then
		local factionTable = Clockwork.faction:FindByID(table.concat(arguments, " ", 2))

		if factionTable then
			if factionTable.whitelist then
				if not Clockwork.player:IsWhitelisted(target, factionTable.name) then
					Clockwork.player:SetWhitelisted(target, factionTable.name, true)
					Clockwork.player:SaveCharacter(target)

					Clockwork.player:NotifyAll({"PlayerAddedToWhitelist", player:Name(), target:Name(), factionTable.name})
				else
					Clockwork.player:Notify(player, {"PlayerAlreadyOnWhitelist", target:Name(), factionTable.name})
				end
			else
				Clockwork.player:Notify(player, {"FactionDoesNotHaveWhitelist", factionTable.name})
			end
		else
			Clockwork.player:Notify(player, {"FactionIsNotValid", table.concat(arguments, " ", 2)})
		end
	else
		Clockwork.player:Notify(player, {"NotValidPlayer", arguments[1]})
	end
end

COMMAND:Register()
