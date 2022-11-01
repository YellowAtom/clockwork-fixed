
PLUGIN:SetGlobalAlias("cwStamina")

Clockwork.kernel:IncludePrefixed("sv_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_hooks.lua")
Clockwork.kernel:IncludePrefixed("cl_plugin.lua")
Clockwork.kernel:IncludePrefixed("cl_hooks.lua")

-- Called when the Clockwork shared variables are added.
function cwStamina:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("Stamina", true)
end
