
-- A function to load the dynamic adverts.
function cwDynamicAdverts:LoadDynamicAdverts()
	self.storedList = Clockwork.kernel:RestoreSchemaData("plugins/adverts/" .. game.GetMap())
end

-- A function to save the dynamic adverts.
function cwDynamicAdverts:SaveDynamicAdverts()
	Clockwork.kernel:SaveSchemaData("plugins/adverts/" .. game.GetMap(), self.storedList)
end

Clockwork.datastream:Hook("AdvertRemoveSelected", function(player, data)
	if not Clockwork.player:IsAdmin(player) then return end

	local removed = 0

	for k, index in pairs(data) do
		if cwDynamicAdverts.storedList[index] then
			Clockwork.datastream:Start(nil, "DynamicAdvertRemove", cwDynamicAdverts.storedList[index].position)
			cwDynamicAdverts.storedList[index] = nil
			removed = removed + 1
		end
	end

	if removed > 0 then
		if removed == 1 then
			Clockwork.player:Notify(player, "You have removed " .. removed .. " dynamic advert.")
		else
			Clockwork.player:Notify(player, "You have removed " .. removed .. " dynamic adverts.")
		end
	else
		Clockwork.player:Notify(player, "No adverts were removed.")
	end

	cwDynamicAdverts:SaveDynamicAdverts()
end)
