
Clockwork.datastream:Hook("EnteredArea", function(player, data)
	if data[1] and data[2] and data[3] then
		hook.Call("PlayerEnteredArea", Clockwork, player, data[1], data[2], data[3])
	end
end)

-- A function to load the area names.
function cwAreaDisplays:LoadAreaDisplays()
	self.storedList = Clockwork.kernel:RestoreSchemaData("plugins/areas/" .. game.GetMap())
end

-- A function to save the area names.
function cwAreaDisplays:SaveAreaDisplays()
	Clockwork.kernel:SaveSchemaData("plugins/areas/" .. game.GetMap(), self.storedList)
end
