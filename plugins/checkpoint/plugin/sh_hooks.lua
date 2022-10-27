
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local cwOption = Clockwork.option;

function PLUGIN:AdjustCommands(commands)
	local tbl = {"CharBan", "CharUnban"}
	for k, v in pairs(tbl) do
		local command = Clockwork.command:FindByID(v);
		if (command) then
			command.access = "o";
		end;
	end;

	if (cwOption:GetKey("use_single_admin_chat")) then
		self:AdjustAdminChat();
	end;

	self:AdjustKick();
	if (SERVER) then
		self:AdjustBans();
	end;

	commands["plyteleport"] = nil;

	--[[for _k, command in pairs(commands) do
		if (command.access == "s") then
			command.access = "a";
		end;
	end;

	local tbl = {"PlySetGroup", "PlyDemote", "Su"}
	for k, v in pairs(tbl) do
		local command = Clockwork.command:FindByID(v);
		if (command) then
			command.access = "s";
		end;
	end;]]
end;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:String("icon");
end;