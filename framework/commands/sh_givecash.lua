local COMMAND = Clockwork.command:New("GiveCash")

COMMAND.tip = "CmdGiveCash"
COMMAND.text = "CmdGiveCashDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.alias = {"GiveTokens", "GiveCredits", "GiveChips", "GiveCaps", "GiveDollars"}
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = player:GetEyeTraceNoCursor().Entity
	local cash = math.floor(tonumber(arguments[1] or 0))

	if target and target:IsPlayer() then
		if target:GetShootPos():Distance(player:GetShootPos()) <= 192 then
			if cash and cash >= 1 then
				if Clockwork.player:CanAfford(player, cash) then
					local playerName = player:Name()
					local targetName = target:Name()

					if not Clockwork.player:DoesRecognise(player, target) then
						targetName = Clockwork.player:GetUnrecognisedName(target, true)
					end

					if not Clockwork.player:DoesRecognise(target, player) then
						playerName = Clockwork.player:GetUnrecognisedName(player, true)
					end

					Clockwork.player:GiveCash(player, -cash)
					Clockwork.player:GiveCash(target, cash)

					Clockwork.player:Notify(player, {"YouGaveCashTo", Clockwork.kernel:FormatCash(cash, nil, true), targetName})

					Clockwork.player:Notify(target, {"YouWereGivenCashBy", Clockwork.kernel:FormatCash(cash, nil, true), playerName})
				else
					local amount = cash - player:GetCash()
					player:NotifyMissingCash(amount)
				end
			else
				Clockwork.player:Notify(player, {"NotValidAmount"})
			end
		else
			Clockwork.player:Notify(player, {"TargetIsTooFarAway"})
		end
	else
		Clockwork.player:Notify(player, {"MustLookAtValidTarget"})
	end
end

COMMAND:Register()
