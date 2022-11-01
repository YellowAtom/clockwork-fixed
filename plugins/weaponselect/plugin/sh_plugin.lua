
PLUGIN:SetGlobalAlias("cwWeaponSelect")

Clockwork.kernel:IncludePrefixed("cl_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_plugin.lua")
Clockwork.kernel:IncludePrefixed("cl_hooks.lua")
Clockwork.config:ShareKey("weapon_selection_multi")

if CLIENT then
	cwWeaponSelect.displaySlot = 0
	cwWeaponSelect.displayFade = 0
	cwWeaponSelect.displayAlpha = 0
	cwWeaponSelect.displayDelay = 0
	cwWeaponSelect.weaponPrintNames = {}
end
