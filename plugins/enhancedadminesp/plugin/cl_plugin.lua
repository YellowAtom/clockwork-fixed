
Clockwork.setting:AddCheckBox("Admin ESP", "Show Prop Entities.", "cwPropESP", "Whether or not to view props in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client)
end)

Clockwork.setting:AddCheckBox("Admin ESP", "Enable the SpawnESP.", "cwSpawnESP", "Whether or not to view spawnpoints in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client)
end)

Clockwork.setting:AddCheckBox("Admin ESP", "Show Clockwork Entities.", "cwEntESP", "Whether or not to view clockwork entities in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client)
end)

Clockwork.setting:AddCheckBox("Admin ESP", "Show Piano Entities.", "cwPianoESP", "Whether or not to view pianos in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client)
end)

Clockwork.setting:AddCheckBox("Admin ESP", "Show NPC Entities.", "cwNPCESP", "Whether or not to view NPCs in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client)
end)
