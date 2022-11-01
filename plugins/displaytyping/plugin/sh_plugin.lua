
PLUGIN:SetGlobalAlias("cwDisplayTyping")

Clockwork.kernel:IncludePrefixed("cl_hooks.lua")
Clockwork.kernel:IncludePrefixed("sv_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_hooks.lua")
Clockwork.kernel:IncludePrefixed("sh_enum.lua")

function cwDisplayTyping:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("Typing")
end
