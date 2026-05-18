
PLUGIN:SetGlobalAlias("cwPickupObjects")

Clockwork.kernel:IncludePrefixed("cl_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_hooks.lua")
Clockwork.kernel:IncludePrefixed("cl_hooks.lua")

if SERVER then
	util.AddNetworkString("cwPickupRotate")
end

-- Called when the Clockwork shared variables are added.
function cwPickupObjects:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Bool("IsDragged", true)
	playerVars:Bool("IsHolding", true)
end
