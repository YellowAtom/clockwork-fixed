
PLUGIN:SetGlobalAlias("cwDelayLOOC")

Clockwork.kernel:IncludePrefixed("sv_hooks.lua")

if SERVER then
	Clockwork.config:Add("looc_interval", 1)
else
	Clockwork.config:AddToSystem("Local out-of-character interval", "looc_interval", "The time that a player has to wait to locally speak out-of-character again (seconds).\nSet to 0 for never.", 0, 7200)
end
