
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local cwOption = Clockwork.option;
local cwConfig = Clockwork.config;

local playerMeta = FindMetaTable("Player");

cwConfig:Add("admin_help_interval", 10);
cwConfig:Add("use_admin_approve", true);
cwConfig:Add("use_death_notifications", true);
cwConfig:Add("use_cp_notify", true);
cwConfig:Add("allow_admin_sent", false);
cwConfig:Add("allow_admin_swep", false);
cwConfig:Add("allow_operator_sent", false);
cwConfig:Add("allow_operator_swep", false);
cwConfig:Add("global_echo", false);
cwConfig:Add("disable_player_punching", true);
cwConfig:Add("always_override_chat_icon", false, true);

-- Admin and owner connect icons
cwOption:SetKey("admin_connect_icon", "star");
cwOption:SetKey("operator_connect_icon", "eye");
cwOption:SetKey("owner_connect_icon", "lightbulb");
cwOption:SetKey("super_admin_connect_icon", "shield");
cwOption:SetKey("developer_connect_icon", "application_xp_terminal");
cwOption:SetKey("vip_connect_icon", "user_green");

-- Disable players punching each other
cwOption:SetKey("disable_player_punching", true);

-- Table to save player records in
cwOption:SetKey("cp_player_records_table", "playerrecords");

local cfgUseCPNotify = cwConfig:Get("use_cp_notify");

function playerMeta:CPNotify(text, icon)
	if (cfgUseCPNotify:Get()) then
		if (icon) then
			local data = {icon = icon};
			Clockwork.chatBox:Add(self, nil, "cp_notify", text, data);
		else
			Clockwork.chatBox:Add(self, nil, "cp_notify", text);
		end;
	else
		Clockwork.player:Notify(self, text);
	end;
end;

local cfgAllowAdminSENT = cwConfig:Get("allow_admin_sent");
local cfgAllowOperatorSENT = cwConfig:Get("allow_operator_sent");

function PLUGIN:PlayerSpawnSENT(player, class)
	if (player:IsSuperAdmin()) then
		return true;
	elseif (player:IsAdmin() and cfgAllowAdminSENT:Get()) then
		return true;
	elseif (player:IsUserGroup("operator") and cfgAllowOperatorSENT:Get()) then
		return true;
	end;
end;


local cfgAllowAdminSWEP = cwConfig:Get("allow_admin_swep");
local cfgAllowOperatorSWEP = cwConfig:Get("allow_operator_swep");

function PLUGIN:PlayerSpawnSWEP(player, weapon)
	if (player:IsSuperAdmin()) then
		return true;
	elseif (player:IsAdmin() and cfgAllowAdminSWEP:Get()) then
		return true;
	elseif (player:IsUserGroup("operator") and cfgAllowOperatorSWEP:Get()) then
		return true;
	end;
end;

function PLUGIN:PlayerGiveSWEP(player, weapon)
	if (player:IsSuperAdmin()) then
		return true;
	elseif (player:IsAdmin() and cfgAllowAdminSWEP:Get()) then
		return true;
	elseif (player:IsUserGroup("operator") and cfgAllowOperatorSWEP:Get()) then
		return true;
	end;
end;

function PLUGIN:DoUnapprovedPlayerSpawn(player)
	-- Notify the player
	player:CPNotify("You have not been approved by an admin yet.", "new");
	-- Get list of admins
	local listeners = self:GetAllAdmins();
	-- Check if there are admins online
	if (#listeners > 0) then
		-- Notify admins
		local data = {color = _team.GetColor(player:Team()), ooc = player:SteamName()}
		Clockwork.chatBox:Add(listeners, nil, "cp_unapprovedplayer", player:Name(), data);
		-- Notify the player an admin will check him out
		player:CPNotify("An admin should check you out shortly, otherwise use /adminhelp to contact one.", "user_go");
	else
		-- Notify player no admins are currently one
		player:CPNotify("No admins are currently online. You can still roleplay while waiting for one to get on.", Clockwork.option:GetKey("wait_icon"));
	end;

	self.LastUnapprovedSpawn = player;
end;

function PLUGIN:Log(steamID, data)
	local player_records_table = cwOption:GetKey("cp_player_records_table");

	local queryObj = Clockwork.database:Select(player_records_table);
		queryObj:AddWhere("_SteamID = ?", steamID);
		queryObj:SetCallback(function(result)
			if (Clockwork.database:IsResult(result)) then
				local recordTable = Clockwork.player:ConvertDataString(nil, result[1]._Record);
				table.insert(recordTable, data);

				local queryObj = Clockwork.database:Update(player_records_table);
					queryObj:AddWhere("_SteamID = ?", steamID);
					queryObj:SetValue("_Record", Clockwork.json:Encode(recordTable));
				queryObj:Push();
			else
				local recordTable = {data};
				local queryObj = Clockwork.database:Insert(player_records_table);
					queryObj:SetValue("_SteamID", steamID);
					queryObj:SetValue("_Record", Clockwork.json:Encode(recordTable));
				queryObj:Push();
			end;
		end);
	queryObj:Pull();
end;

function PLUGIN:PlayerLog(player, logType, text, addedBy, data)
	-- Setup text
	if (!data) then
		data = {}
	elseif (type(data) != "table") then
		data = {data};
	end;

	data.time = os.time();
	data.player = player:Name();
	data.logType = logType;
	data.text = text;

	if (addedBy) then
		data.addedBy = addedBy:SteamName();
	end;

	--Write into the SQL
	self:Log(player:SteamID(), data);
end;

function PLUGIN:OfflinePlayerLog(name, steamID, logType, text, addedByName, data)
	-- Setup text
	if (!data) then
		data = {}
	elseif (type(data) != "table") then
		data = {data};
	end;

	data.time = os.time();
	data.player = name
	data.logType = logType;
	data.text = text;

	if (addedByName) then
		data.addedBy = addedByName
	end;

	--Write into the SQL
	self:Log(steamID, data);
end;

function PLUGIN:AdjustBans()-- A function to ban a player.
	function Clockwork.bans:Add(identifier, duration, reason, Callback, bSaveless, bannedBy)
		local steamName = nil;
		local playerGet = Clockwork.player:FindByID(identifier);
		local bansTable = Clockwork.config:Get("mysql_bans_table"):Get();
		local schemaFolder = Clockwork.kernel:GetSchemaFolder();
			
		if (identifier) then
			identifier = string.upper(identifier);
		end;
			
		for k, v in pairs(_player.GetAll()) do
			local playerIP = v:IPAddress();
			local playerSteam = v:SteamID();
				
			if (playerSteam == identifier or playerIP == identifier or playerGet == v) then
				Clockwork.plugin:Call("PlayerBanned", v, duration, reason, bannedBy);
				
				if (playerIP == identifier) then
					identifier = playerIP;
				else
					identifier = playerSteam;
				end;
					
				steamName = v:SteamName();
				v:Kick(reason);
			end;
		end;
			
		if (!reason) then
			reason = "Banned for an unspecified reason.";
		end;
			
		if (steamName) then
			if (duration == 0) then
				self.stored[identifier] = {
					unbanTime = 0,
					steamName = steamName,
					duration = duration,
					reason = reason
				};
			else
				self.stored[identifier] = {
					unbanTime = os.time() + duration,
					steamName = steamName,
					duration = duration,
					reason = reason
				};
			end;
			
			if (!bSaveless) then
				local queryObj = Clockwork.database:Insert(bansTable);
					queryObj:SetValue("_Identifier", identifier);
					queryObj:SetValue("_UnbanTime", self.stored[identifier].unbanTime);
					queryObj:SetValue("_SteamName", self.stored[identifier].steamName);
					queryObj:SetValue("_Duration", self.stored[identifier].duration);
					queryObj:SetValue("_Reason", self.stored[identifier].reason);
					queryObj:SetValue("_Schema", schemaFolder);
				queryObj:Push();
			end;
			
			if (Callback) then
				Callback(steamName, duration, reason);
			end;
			
			return;
		end;
		
		local playersTable = Clockwork.config:Get("mysql_players_table"):Get();
		
		if (string.find(identifier, "STEAM_(%d+):(%d+):(%d+)")) then
			local queryObj = Clockwork.database:Select(playersTable);
				queryObj:AddWhere("_SteamID = ?", identifier);
				queryObj:SetCallback(function(result)
					local steamName = identifier;
					
					if (Clockwork.database:IsResult(result)) then
						steamName = result[1]._SteamName;
					end;
						
					if (duration == 0) then
						self.stored[identifier] = {
							unbanTime = 0,
							steamName = steamName,
							duration = duration,
							reason = reason
						};
					else
						self.stored[identifier] = {
							unbanTime = os.time() + duration,
							steamName = steamName,
							duration = duration,
							reason = reason
						};
					end;

					PLUGIN:OfflinePlayerLog(steamName, identifier, "ban", reason, bannedBy:SteamName(), {duration = duration})
					
					if (!bSaveless) then
						local insertObj = Clockwork.database:Insert(bansTable);
							insertObj:SetValue("_Identifier", identifier);
							insertObj:SetValue("_UnbanTime", self.stored[identifier].unbanTime);
							insertObj:SetValue("_SteamName", self.stored[identifier].steamName);
							insertObj:SetValue("_Duration", self.stored[identifier].duration);
							insertObj:SetValue("_Reason", self.stored[identifier].reason);
							insertObj:SetValue("_Schema", schemaFolder);
						insertObj:Push();
					end;
					
					if (Callback) then
						Callback(steamName, duration, reason);
					end;
				end);
			queryObj:Pull();
			
			return;
		end;
		
		--[[ In this case we're banning them by their IP address. --]]
		if (string.find(identifier, "%d+%.%d+%.%d+%.%d+")) then
			local queryObj = Clockwork.database:Select(playersTable);	
				queryObj:SetCallback(function(result)
					local steamName = identifier;
					local steamID = nil;
					
					if (Clockwork.database:IsResult(result)) then
						steamName = result[1]._SteamName;
						steamID = result[1]._SteamID;
					end;
					
					if (duration == 0) then
						self.stored[identifier] = {
							unbanTime = 0,
							steamName = steamName,
							duration = duration,
							reason = reason
						};
					else
						self.stored[identifier] = {
							unbanTime = os.time() + duration,
							steamName = steamName,
							duration = duration,
							reason = reason
						};
					end;

					if (steamID) then
						PLUGIN:OfflinePlayerLog(steamName, steamID, "ban", reason, bannedBy:SteamName(), {duration = duration})
					end;
					
					if (!bSaveless) then
						local insertObj = Clockwork.database:Insert(bansTable);
							insertObj:SetValue("_Identifier", identifier);
							insertObj:SetValue("_UnbanTime", self.stored[identifier].unbanTime);
							insertObj:SetValue("_SteamName", self.stored[identifier].steamName);
							insertObj:SetValue("_Duration", self.stored[identifier].duration);
							insertObj:SetValue("_Reason", self.stored[identifier].reason);
							insertObj:SetValue("_Schema", schemaFolder);
						insertObj:Push();
					end;
					
					if (Callback) then
						Callback(steamName, duration, reason);
					end;
				end);
				queryObj:AddWhere("_IPAddress = ?", identifier);
			queryObj:Pull();
			
			return;
		end;
		
		if (duration == 0) then
			self.stored[identifier] = {
				unbanTime = 0,
				steamName = steamName,
				duration = duration,
				reason = reason
			};
		else
			self.stored[identifier] = {
				unbanTime = os.time() + duration,
				steamName = steamName,
				duration = duration,
				reason = reason
			};
		end;
		
		if (!bSaveless) then
			local queryObj = Clockwork.database:Insert(bansTable);
				queryObj:SetValue("_Identifier", identifier);
				queryObj:SetValue("_UnbanTime", self.stored[identifier].unbanTime);
				queryObj:SetValue("_SteamName", self.stored[identifier].steamName);
				queryObj:SetValue("_Duration", self.stored[identifier].duration);
				queryObj:SetValue("_Reason", self.stored[identifier].reason);
				queryObj:SetValue("_Schema", schemaFolder);
			queryObj:Push();
		end;
		
		if (Callback) then
			Callback(steamName, duration, reason);
		end;
	end;

	-- A function to remove a ban.
	function Clockwork.bans:Remove(identifier, bSaveless, removedBy)
		local bansTable = Clockwork.config:Get("mysql_bans_table"):Get();
		local schemaFolder = Clockwork.kernel:GetSchemaFolder();

		if (self.stored[identifier]) then
			if (string.find(identifier, "STEAM_(%d+):(%d+):(%d+)")) then
				if (removedBy) then
					PLUGIN:OfflinePlayerLog(self.stored[identifier].steamName, identifier, "unban", nil, removedBy:SteamName());
				else
					PLUGIN:OfflinePlayerLog(self.stored[identifier].steamName, identifier, "unban");
				end;
			end;
			self.stored[identifier] = nil;
			
			if (!bSaveless) then
				local queryObj = Clockwork.database:Delete(bansTable);
					queryObj:AddWhere("_Schema = ?", schemaFolder);
					queryObj:AddWhere("_Identifier = ?", identifier);
				queryObj:Push();
			end;
		end;
	end;

	local command = Clockwork.command:FindByID("PlyBan");
	if (command) then
		command.OnRun = function(COMMAND, player, arguments)
			local schemaFolder = Clockwork.kernel:GetSchemaFolder();
			local duration = tonumber(arguments[2]);
			local reason = table.concat(arguments, " ", 3);
			
			if (!reason or reason == "") then
				reason = nil;
			end;
			
			if (!Clockwork.player:IsProtected(arguments[1])) then
				if (duration) then
					Clockwork.bans:Add(arguments[1], duration * 60, reason, function(steamName, duration, reason)
						if (IsValid(player)) then
							if (steamName) then
								if (duration > 0) then
									local hours = math.Round(duration / 3600);
									
									if (hours >= 1) then
										Clockwork.player:NotifyAll(player:Name().." has banned '"..steamName.."' for "..hours.." hour(s) ("..reason..").");
									else
										Clockwork.player:NotifyAll(player:Name().." has banned '"..steamName.."' for "..math.Round(duration / 60).." minute(s) ("..reason..").");
									end;
								else
									Clockwork.player:NotifyAll(player:Name().." has banned '"..steamName.."' permanently ("..reason..").");
								end;
							else
								Clockwork.player:Notify(player, "This is not a valid identifier!");
							end;
						end;
					end, nil, player);
				else
					Clockwork.player:Notify(player, "This is not a valid duration!");
				end;
			else
				local target = Clockwork.player:FindByID(arguments[1]);
				
				if (target) then
					Clockwork.player:Notify(player, target:Name().." is protected!");
				else
					Clockwork.player:Notify(player, "This player is protected!");
				end;
			end;
		end;
	end;

	command = Clockwork.command:FindByID("PlyUnban")
	if (command) then
		command.OnRun = function(COMMAND, player, arguments)
			local playersTable = Clockwork.config:Get("mysql_players_table"):Get();
			local schemaFolder = Clockwork.kernel:GetSchemaFolder();
			local identifier = string.upper(arguments[1]);
			
			if (Clockwork.bans.stored[identifier]) then
				Clockwork.player:NotifyAll(player:Name().." has unbanned '"..Clockwork.bans.stored[identifier].steamName.."'.");
				Clockwork.bans:Remove(identifier, nil, player);
			else
				Clockwork.player:Notify(player, "There are no banned players with the '"..identifier.."' identifier!");
			end;
		end;
	end;
end;