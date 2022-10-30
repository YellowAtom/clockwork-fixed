local COMMAND = Clockwork.command:New("CheckQuota")
COMMAND.tip = "Check your current target you need to beat to fill your quota."
COMMAND.text = "<none>"
--COMMAND.access = "a"

-- Called when the command has been run.
-- todo: derma UI for dudes you've beaten?
function COMMAND:OnRun(player)
	if player:GetFaction() ~= FACTION_MPF then
		player:Notify("You are not a member of the force!")

		return
	end

	if player:GetCharacterData("quota") == 99 then
		player:Notify("You do not have a quota to fulfill for now.")

		return
	end
	player:Notify("Your current Beating Quota is (" .. player:GetCharacterData("quota") .. "/" .. player:GetCharacterData("quotamax") .. ").")
end

COMMAND:Register()