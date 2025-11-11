local noTarget = Clockwork.kernel:CreateClientConVar("cwNoTarget", 1, true, true);
local observerReset = Clockwork.kernel:CreateClientConVar("cwObserverReset", 1, true, true)

-- Old observer reset global toggle
-- Clockwork.config:AddToSystem("Observer Reset", "observer_reset", "Whether or not observer mode resets the player's position to where they were originally.", true)

Clockwork.setting:AddCheckBox("Framework", "Enable Observer Reset", "cwObserverReset", "Whether or not observer mode resets the player's position to where they were originally.", function()
	return ULib and ULib.ucl and ULib.ucl.query and ULib.ucl.query(LocalPlayer(), "cw - observer")
end)

Clockwork.setting:AddCheckBox("Framework", "Enable Observer NPC No-Target.", "cwNoTarget", "Whether or not you will be targeted by NPCs in Observer.", function()
	return ULib and ULib.ucl and ULib.ucl.query and ULib.ucl.query(LocalPlayer(), "cw - observer")
end)