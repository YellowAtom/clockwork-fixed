
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local cwOption = Clockwork.option;
local cwConfig = Clockwork.config;

--[[
	Disable punching players
]]
function PLUGIN:PlayerCanPunchEntity(player, entity)
	if (entity:IsPlayer() and cwConfig:Get("disable_player_punching"):Get()) then
		return false;
	end;
end;

function PLUGIN:PlayerCanPunchKnockout(player, entity)
	if (entity:IsPlayer() and cwConfig:Get("disable_player_punching"):Get()) then
		return false;
	end;
end;
--[[
	Disable punching players
]]

--[[
	Frozen player (and anti-charswap) things.
]]
function PLUGIN:PlayerCanUseCommand(player, commandTable, arguments)
	if (commandTable.name == "CharFallOver" and player:IsFrozen()) then
		return false;
	end;
end;

function PLUGIN:PlayerCanSwitchCharacter(player, character)
	if (player:IsFrozen()) then
		return false;
	end;

	-- Force character no-swap time
	if (player.noCharSwap and player.noCharSwap > CurTime()) then
		return false;
	end;
end;
--[[
	End frozen player (and anti-charswap) things.
]]

--[[
	Admin Approve and first join
]]
function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	if (firstSpawn) then
		if (cwConfig:Get("use_admin_approve"):Get() and !player:GetData("admin_approved", false)) then
			self:DoUnapprovedPlayerSpawn(player);
		end;
	end;

	if (firstSpawn and !player:GetData("firstJoinEntry", false)) then
		self:PlayerLog(player, "firstJoin");
		player:SetData("firstJoinEntry", os.time());
	end;
end;
--[[
	End Admin Approve and first join
]]

--[[
	Death notifications
]]
function PLUGIN:PlayerDeath(player, attacker, inflictor, damageInfo)
	if (cwConfig:Get("use_death_notifications"):Get()) then
		local attackerName = ""; local attackerColor = Color(255, 255, 255, 255);
		local playerName = player:Name(); local playerColor = team.GetColor(player:Team());

		if (attacker:IsPlayer()) then
			attackerName = attacker:Name();
			attackerColor = team.GetColor(attacker:Team());
		else
			attackerName = attacker:GetClass();
			attackerColor = playerColor;
		end;

		local listeners = {};
		local players = _player.GetAll();
		for k, ply in pairs(players) do
			if (Clockwork.player:HasFlags(ply, cwOption:GetKey("death_note_flag"))) then
				listeners[#listeners + 1] = ply;
			end;
		end;

		Clockwork.plugin:Call("AdjustDeathNotificationListeners", listeners, player, attacker, inflictor, damageInfo);

		local data = {playerName = playerName, playerColor = playerColor, attackerName = attackerName, attackerColor = attackerColor};
		Clockwork.chatBox:Add(listeners, nil, "cp_deathnotification", "", data);
	end;
end;
--[[
	End death notifications
]]


function PLUGIN:ChatBoxAdjustInfo(info)
	-- Disable old connect message
	if (info.class == "connect") then
		info.bShouldSend = false;
	end;

	if (info.speaker) then
		local muteTable = info.speaker:GetData("mute_table", {});

		if (muteTable.all and (muteTable.all == true or muteTable.all > CurTime())) then
			info.bShouldSend = false;
		elseif (muteTable and muteTable[info.class]) then
			if (muteTable[info.class] == true or muteTable[info.class] > CurTime()) then
				info.bShouldSend = false;
			end;
		end;
	end;
end;

--[[
	Updated join message
]]
function PLUGIN:PlayerDataLoaded(player)
	timer.Simple(2, function()
		if (!player:IsStealthMode()) then
			local name = player:SteamName();
			data = {icon = nil};
			if (player:IsSuperAdmin() or player:IsAdmin() or player:IsUserGroup("operator")) then
				local group = "Operator";
				data.icon = cwOption:GetKey("operator_connect_icon");

				if (player:SteamID() == cwConfig:Get("owner_steamid"):Get()) then
					group = "The Man Himself";
					data.icon = cwOption:GetKey("owner_connect_icon");
				elseif (player:IsSuperAdmin()) then
					group = "Super Admin";
					data.icon = cwOption:GetKey("super_admin_connect_icon");
				elseif (player:IsAdmin()) then
					group = "Admin";
					data.icon = cwOption:GetKey("admin_connect_icon");
				end;

				name = name.." ("..group..")";
			end;

			local newName = Clockwork.plugin:Call("AdjustPlayerConnectMessage", player, name, data);

			if (newName) then
				Clockwork.chatBox:Add(nil, nil, "cp_connect", newName, data);
			else
				Clockwork.chatBox:Add(nil, nil, "cp_connect", name, data);
			end;
		end;
	end);
end;
--[[
	End updated join message
]]

--[[
	Custom icon
]]
function PLUGIN:PlayerSetSharedVars(player, curTime)
	local icon = player:GetData("icon");
	if (icon) then
		player:SetSharedVar("icon", icon);
	else
		player:SetSharedVar("icon", "");
	end;
end;
--[[
	End custom icon
]]

--[[
	Player Record
]]
function PLUGIN:ClockworkDatabaseConnected()
	local PLAYER_RECORDS_TABLE_QUERY = [[
		CREATE TABLE IF NOT EXISTS `]]..cwOption:GetKey("cp_player_records_table")..[[` (
		`_Record` text NOT NULL,
		`_SteamID` varchar(60) NOT NULL,
		PRIMARY KEY (`_SteamID`))
	]];

	Clockwork.database:Query(string.gsub(PLAYER_RECORDS_TABLE_QUERY, "%s", " "), nil, nil, true);
end;

function PLUGIN:PlayerBanned(player, duration, reason, bannedBy)
	self:PlayerLog(player, "ban", reason, bannedBy, {duration = duration});
end;

local init = false; -- Ensure everything is setup, even after a lua refresh
function PLUGIN:Think()
	if (!init) then
		-- Pre Checkpoint Init
		Clockwork.plugin:Call("PreCheckpointInit", self);

		-- Flag to receive death notifications
		Clockwork.flag:Add(cwOption:GetKey("death_note_flag"), "Death Notification", "Get Death Notifications when someone dies.");

		-- Adjust commands
		Clockwork.plugin:Call("AdjustCommands", Clockwork.command.stored);

		-- Save the owners steam ID
		self.ownerSteamID = cwConfig:Get("owner_steamid"):Get();

		-- Post Checkpoint Init
		Clockwork.plugin:Call("PostCheckpoitnInit", self);
		
		print("[CP] Checkpoint "..self.CPVersion.." initialized.");

		init = true;
	end;
end;

Clockwork.datastream:Hook("owner_steamid", function(player, data)
	Clockwork.datastream:Start(player, "owner_steamid", {cwConfig:Get("owner_steamid"):Get()});
end);