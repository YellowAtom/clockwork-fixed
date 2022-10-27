local PLUGIN = PLUGIN;

Clockwork.setting:AddCheckBox("AdminESP", "Enable the ItemESP.", "cwItemESP", "Whether or not to view items in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client);
end);
Clockwork.setting:AddCheckBox("AdminESP", "Enable the PropESP.", "cwPropESP", "Whether or not to view props in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client);
end);
Clockwork.setting:AddCheckBox("AdminESP", "Enable the SpawnESP.", "cwSpawnESP", "Whether or not to view spawnpoints in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client);
end);
Clockwork.setting:AddCheckBox("AdminESP", "Enable the SaleESP.", "cwSaleESP", "Whether or not to view salesmen in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client);
end);
Clockwork.setting:AddCheckBox("AdminESP", "Enable the cwEntESP.", "cwEntESP", "Whether or not to view clockwork entities in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client);
end);
Clockwork.setting:AddCheckBox("AdminESP", "Enable the PianoESP.", "cwPianoESP", "Whether or not to view pianos in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client);
end);
Clockwork.setting:AddCheckBox("AdminESP", "Enable the NPCESP.", "cwNPCESP", "Whether or not to view NPCs in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client);
end);

Clockwork.config:AddToSystem("[ESP]ItemESP Red", "itemesp_r", "The red color value for the ItemESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]ItemESP Green", "itemesp_g", "The green color value for the ItemESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]ItemESP Blue", "itemesp_b", "The blue color value for the ItemESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]PropESP Red", "propesp_r", "The red color value for the PropESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]PropESP Green", "propesp_g", "The green color value for the PropESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]PropESP Blue", "propesp_b", "The blue color value for the PropESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]CashESP Red", "cashesp_r", "The red color value for the CashESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]CashESP Green", "cashesp_g", "The green color value for the CashESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]CashESP Blue", "cashesp_b", "The blue color value for the CashESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]ShipmentESP Red", "shipmentesp_r", "The red color value for the ShipmentESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]ShipmentESP Green", "shipmentesp_g", "The green color value for the ShipmentESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]ShipmentESP Blue", "shipmentesp_b", "The blue color value for the ShipmentESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]VendingESP Red", "vendingesp_r", "The red color value for the VendingESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]VendingESP Green", "vendingesp_g", "The green color value for the VendingESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]VendingESP Blue", "vendingesp_b", "The blue color value for the VendingESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]BookESP Red", "bookesp_r", "The red color value for the BookESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]BookESP Green", "bookesp_g", "The green color value for the BookESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]BookESP Blue", "bookesp_b", "The blue color value for the BookESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]cwEntESP Red", "cwentesp_r", "The red color value for the cwEntESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]cwEntESP Green", "cwentesp_g", "The green color value for the cwEntESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]cwEntESP Blue", "cwentesp_b", "The blue color value for the cwEntESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]PianoESP Red", "pianoesp_r", "The red color value for the PianoESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]PianoESP Green", "pianoesp_g", "The green color value for the PianoESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]PianoESP Blue", "pianoesp_b", "The blue color value for the PianoESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]SpawnESP Red", "spawnesp_r", "The red color value for the SpawnESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]SpawnESP Green", "spawnesp_g", "The green color value for the SpawnESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]SpawnESP Blue", "spawnesp_b", "The blue color value for the SpawnESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]SalesmanESP Red", "salesmanesp_r", "The red color value for the SalesmanESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]SalesmanESP Green", "salesmanesp_g", "The green color value for the SalesmanESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]SalesmanESP Blue", "salesmanesp_b", "The blue color value for the SalesmanESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]LockedESP Red", "lockedesp_r", "The red color value for locked/off entities", 0, 255)
Clockwork.config:AddToSystem("[ESP]LockedESP Green", "lockedesp_g", "The green color value for locked/off entities", 0, 255)
Clockwork.config:AddToSystem("[ESP]LockedESP Blue", "lockedesp_b", "The blue color value for locked/off entities", 0, 255)
Clockwork.config:AddToSystem("[ESP]UnlockedESP Red", "unlockedesp_r", "The red color value for unlocked/on entities", 0, 255)
Clockwork.config:AddToSystem("[ESP]UnlockedESP Green", "unlockedesp_g", "The green color value for unlocked/on entities", 0, 255)
Clockwork.config:AddToSystem("[ESP]UnlockedESP Blue", "unlockedesp_b", "The blue color value for unlocked/on entities", 0, 255)
Clockwork.config:AddToSystem("[ESP]NPCESP Red", "npcesp_r", "The red color value for the NPCESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]NPCESP Green", "npcesp_g", "The green color value for the NPCESP", 0, 255)
Clockwork.config:AddToSystem("[ESP]NPCESP Blue", "npcesp_b", "The blue color value for the NPCESP", 0, 255)