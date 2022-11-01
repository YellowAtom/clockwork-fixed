
PLUGIN:SetGlobalAlias("cwDynamicAdverts")

Clockwork.kernel:IncludePrefixed("cl_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_hooks.lua")
Clockwork.kernel:IncludePrefixed("cl_hooks.lua")

cwDynamicAdverts.storedList = {}
