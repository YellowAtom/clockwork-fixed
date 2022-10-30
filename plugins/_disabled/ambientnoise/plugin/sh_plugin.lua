local PLUGIN = PLUGIN;
local Clockwork = Clockwork;
--[[
function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Bool("ChatterEnabled");
end;]]

Clockwork.kernel:IncludePrefixed("sv_hooks.lua");