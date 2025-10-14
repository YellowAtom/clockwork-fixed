local COMMAND = Clockwork.command:New("AdvertRemove")

COMMAND.tip = "Remove a dynamic advert."
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "a"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local position = player:GetEyeTraceNoCursor().HitPos
	local nearbyAdverts = {}

	for k, v in pairs(cwDynamicAdverts.storedList) do
		if v.position:Distance(position) <= 256 then
			table.insert(nearbyAdverts, {
				index = k,
				url = v.url,
				position = v.position,
				scale = v.scale or 0.25,
				width = v.width,
				height = v.height
			})
		end
	end

	if #nearbyAdverts > 0 then
		Clockwork.datastream:Start(player, "AdvertRemoveSelection", nearbyAdverts)
	else
		Clockwork.player:Notify(player, "There were no dynamic adverts near this position.")
	end
end

COMMAND:Register()
