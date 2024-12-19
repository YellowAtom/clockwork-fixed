
function cwDelayLOOC:ClockworkConfigChanged(key, data, previousValue, newValue)
	if key == "looc_interval" then
		for k, v in pairs(cwPlayer.GetAll()) do
			v.cwNextTalkLOOC = nil
		end
	end
end

function cwDelayLOOC:PlayerCanSayLOOC(player, text)
	local libconfig = Clockwork.config
	local interval = libconfig:Get("looc_interval"):Get()
	local libplayer = Clockwork.player
	local curTime = CurTime()

	if player.cwNextTalkLOOC ~= nil and curTime < player.cwNextTalkLOOC and not player:IsAdmin(player) then
		libplayer:Notify(player, "You cannot cannot talk in LOOC for another " .. math.ceil(player.cwNextTalkLOOC - curTime) .. " second(s)!")

		return false
	end

	player.cwNextTalkLOOC = curTime + interval
end
