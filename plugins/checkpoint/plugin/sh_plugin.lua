
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local cwOption = Clockwork.option;
local cwConfig = Clockwork.config;

Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("sh_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");

-- CP version
PLUGIN.CPVersion = "v1.2.3";

--[[
	Chat icon options. Credit to Polis for giving me the chat icon idea.
	A list of icons can be found here: http://www.famfamfam.com/lab/icons/silk/previews/index_abc.png
]]
cwOption:SetKey("default_chat_icon", "user");
cwOption:SetKey("owner_chat_icon", "lightbulb");
cwOption:SetKey("developer_chat_icon", "script_code");
cwOption:SetKey("operator_chat_icon", "eye");
cwOption:SetKey("admin_chat_icon", "star");
cwOption:SetKey("super_admin_chat_icon", "shield");
cwOption:SetKey("vip_chat_icon", "user_green");

-- Various icons (mostly used in notifies)
cwOption:SetKey("invalid_target_icon", "user_red");
cwOption:SetKey("cannot_do_icon", "delete");
cwOption:SetKey("wait_icon", "hourglass");

-- Developer list (to give them a dev icon)
cwOption:SetKey("developers", {"STEAM_0:0:18559166", "STEAM_0:1:37308531", "STEAM_0:0:35869293"});

-- Death notification flag
cwOption:SetKey("death_note_flag", "J");

-- Use single CP admin chat
cwOption:SetKey("use_single_admin_chat", true);

-- Share config key
cwConfig:ShareKey("always_override_chat_icon");

-- Get a player's icon
function PLUGIN:GetPlayerIcon(player)
	local customIcon = player:GetSharedVar("icon");
	local icon = cwOption:GetKey("default_chat_icon");

	if (self.ownerSteamID and player:SteamID() == self.ownerSteamID) then
		icon = cwOption:GetKey("owner_chat_icon");

	elseif (table.HasValue(cwOption:GetKey("developers"), player:SteamID())) then
		icon = cwOption:GetKey("developer_chat_icon");	

	elseif (player:IsSuperAdmin()) then
		icon = cwOption:GetKey("super_admin_chat_icon");

	elseif (player:IsAdmin()) then
		icon = cwOption:GetKey("admin_chat_icon");

	elseif (player:IsUserGroup("operator")) then
		icon = cwOption:GetKey("operator_chat_icon");
	
	elseif (player:IsUserGroup("vip")) then
	icon = cwOption:GetKey("vip_chat_icon");
	
	elseif (customIcon != "") then
		icon = customIcon;

	elseif (cwConfig:Get("use_admin_approve"):Get() and player:GetData("admin_approved", false)) then
		icon = "new";
	end;

	local newIcon = Clockwork.plugin:Call("AdjustPlayerIcon", player, icon);

	if (newIcon and newIcon != "") then
		return newIcon;
	else
		return icon;
	end;
end;

-- Get if an admin is on, and how many
function PLUGIN:IsAdminOnline(player)
	local adminsOnline = 0;
	local players = _player.GetAll();
	
	for k, ply in pairs(players) do
		if (player and player == ply) then
			continue;
		end;
		if (Clockwork.player:IsAdmin(ply)) then
			adminsOnline = adminsOnline + 1;
		end;
	end;

	if (adminsOnline > 0) then
		return true, adminsOnline;
	else
		return false, adminsOnline;
	end;
end;

-- Get all admins
function PLUGIN:GetAllAdmins()
	local admins = {};
	local players = _player.GetAll();
	for k, ply in pairs(players) do
		if (Clockwork.player:IsAdmin(ply)) then
			admins[#admins + 1] = ply;
		end;
	end;
	return admins;
end;

-- Adjust the admin chat
function PLUGIN:AdjustAdminChat()
	Clockwork.command.stored["su"] = nil;
	Clockwork.command.stored["ad"] = nil;
	Clockwork.command.stored["op"] = nil;

	local tbl = {"Op", "Ad", "Su"}
	for k, cmd in pairs(tbl) do
		local COMMAND = Clockwork.command:New(cmd);
		COMMAND.tip = "Privately talk to other admins in admin chat.";
		COMMAND.text = "<string Msg>";
		COMMAND.access = "o";
		COMMAND.arguments = 1;

		-- Called when the command has been run.
		function COMMAND:OnRun(player, arguments)
			local listeners = PLUGIN:GetAllAdmins();
			Clockwork.chatBox:Add(listeners, player, "cp_adminchat", table.concat(arguments, " "));
		end;
		COMMAND:Register();
	end;
end;

function PLUGIN:AdjustKick()
	local command = Clockwork.command:FindByID("PlyKick");
	if (command) then
		command.OnRun = function(COMMAND, player, arguments)
			local target = Clockwork.player:FindByID(arguments[1]);
			local reason = table.concat(arguments, " ", 2);
			
			if (!reason or reason == "") then
				reason = "N/A";
			end;
			
			if (target) then
				if (!Clockwork.player:IsProtected(arguments[1])) then
					Clockwork.player:NotifyAll(player:Name().." has kicked '"..target:Name().."' ("..reason..").");
					target:Kick(reason);
					PLUGIN:PlayerLog(target, "kick", reason, player);
					target.kicked = true;
				else
					Clockwork.player:Notify(player, target:Name().." is protected!");
				end;
			else
				Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
			end;
		end;
	end;
end;