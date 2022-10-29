
local PLUGIN = PLUGIN;

if not pk_pills then
	MsgC(Color(255, 50, 50), "[Morph-Mod Enforcer] Pill Pack not found, not loading!\n")
	return
end

Clockwork.kernel:IncludePrefixed("sv_hooks.lua");