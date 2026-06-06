local COMMAND = Clockwork.command:New("TextRemove")

COMMAND.tip = "Remove a surface text."
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local position = player:GetEyeTraceNoCursor().HitPos
	local nearbyTexts = {}

	for k, v in pairs(cwSurfaceTexts.storedList) do
		if v.position:Distance(position) <= 256 then
			table.insert(nearbyTexts, {
				index = k,
				text = v.text,
				position = v.position,
				scale = v.scale or 0.25,
			})
		end
	end

	if #nearbyTexts > 0 then
		Clockwork.datastream:Start(player, "TextRemoveSelection", nearbyTexts)
	else
		Clockwork.player:Notify(player, "There were no surface texts near this position.")
	end
end

COMMAND:Register()
