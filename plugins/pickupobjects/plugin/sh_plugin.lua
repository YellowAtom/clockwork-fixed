
PLUGIN:SetGlobalAlias("cwPickupObjects")

Clockwork.kernel:IncludePrefixed("cl_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_hooks.lua")
Clockwork.kernel:IncludePrefixed("cl_hooks.lua")

-- Called when the Clockwork shared variables are added.
function cwPickupObjects:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Bool("IsDragged", true)
end
