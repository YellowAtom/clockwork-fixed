
-- A function to load the surface texts.
function cwSurfaceTexts:LoadSurfaceTexts()
	self.storedList = Clockwork.kernel:RestoreSchemaData("plugins/texts/" .. game.GetMap())
end

-- A function to save the surface texts.
function cwSurfaceTexts:SaveSurfaceTexts()
	Clockwork.kernel:SaveSchemaData("plugins/texts/" .. game.GetMap(), self.storedList)
end

Clockwork.datastream:Hook("TextRemoveSelected", function(player, data)
	if not Clockwork.player:IsAdmin(player) and not Clockwork.player:IsOperator(player) then return end

	local removed = 0

	for k, index in pairs(data) do
		if cwSurfaceTexts.storedList[index] then
			Clockwork.datastream:Start(nil, "SurfaceTextRemove", cwSurfaceTexts.storedList[index].position)
			cwSurfaceTexts.storedList[index] = nil
			removed = removed + 1
		end
	end

	if removed > 0 then
		if removed == 1 then
			Clockwork.player:Notify(player, "You have removed " .. removed .. " surface text.")
		else
			Clockwork.player:Notify(player, "You have removed " .. removed .. " surface texts.")
		end
	else
		Clockwork.player:Notify(player, "No texts were removed.")
	end

	cwSurfaceTexts:SaveSurfaceTexts()
end)
