local PLUGIN = PLUGIN;

PLUGIN:SetGlobalAlias("cwHeartBeat");

Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");

-- Called when the Clockwork shared variables are added.
function cwHeartBeat:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Bool("implant", true);
end;