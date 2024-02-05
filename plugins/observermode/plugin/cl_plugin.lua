local noTarget = Clockwork.kernel:CreateClientConVar("cwNoTarget", 1, true, true);

Clockwork.config:AddToSystem("Observer Reset", "observer_reset", "Whether or not observer mode resets the player's position to where they were originally.", true)

Clockwork.setting:AddCheckBox("Framework", "Enable NPC No-Target in Observer.", "cwNoTarget", "Whether or not you will be targeted by NPCs in Observer.", function()
	return Clockwork.Client:IsAdmin() or Clockwork.Client:IsUserGroup("operator")
end)