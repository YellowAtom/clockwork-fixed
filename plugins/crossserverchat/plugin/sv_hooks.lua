
-- Called when the Clockwork database has connected.
function cwXCS:ClockworkDatabaseConnected()
	if not Clockwork.database:IsSQLite() then
		local CREATE_MESSAGES_TABLE = [[
			CREATE TABLE IF NOT EXISTS `]] .. Clockwork.config:Get("mysql_xsc_table"):Get() .. [[` (
				`_Key` int(11) NOT NULL AUTO_INCREMENT,
				`_ServerName` varchar(255) NOT NULL,
				`_PlayerName` varchar(255) NOT NULL,
				`_Text` text NOT NULL,
				`_Color` varchar(255) NOT NULL,
				PRIMARY KEY (`_Key`)
			) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;]]
		Clockwork.database:Query(string.gsub(CREATE_MESSAGES_TABLE, "%s", " "), nil, nil, true)
	else
		MsgC(Color(255, 255, 0), "[CrossServerChat] This plugin will not load with SQLite!\n")
	end
end

-- Called when a player attempts to say something out-of-character.
function cwXCS:PlayerCanSayOOC(player, text)
	if not Clockwork.database:IsSQLite() then
		local curTime = CurTime()
		local playerName = player:Name()
		local serverName = Clockwork.config:Get("cross_server_chat_name"):Get()
		local teamColor = Clockwork.json:Encode(cwTeam.GetColor(player:Team()))

		if Clockwork.config:Get("cross_server_chat_enabled"):Get() and playerName ~= "" and serverName ~= "" and text ~= "" then
			if not player.nextTalkOOC or curTime > player.nextTalkOOC then
				local queryObj = Clockwork.database:Insert("messages")
				queryObj:SetValue("_ServerName", serverName)
				queryObj:SetValue("_PlayerName", playerName)
				queryObj:SetValue("_Text", text)
				queryObj:SetValue("_Color", teamColor)
				queryObj:Push()
			end
		end
	end
end

-- Called each tick.
function cwXCS:Tick()
	if not Clockwork.database:IsSQLite() then
		local curTime = CurTime()

		if Clockwork.config:Get("cross_server_chat_enabled"):Get() then
			if not self.cwNextQueryChat or curTime >= self.cwNextQueryChat then
				self:QueryChat()
			end
		end
	end
end
