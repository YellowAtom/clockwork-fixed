
local startTime = os.clock()


cwReloading = false
cwReloaded = false

if Clockwork and Clockwork.kernel then
	MsgC(Color(0, 255, 100, 255), "[Clockwork] Change has been detected! Auto-refreshing...\n")
	cwReloading =  true
else
	MsgC(Color(0, 255, 100, 255), "[Clockwork] The framework is initializing...\n")
	require("cwutil")
end

AddCSLuaFile("external/utf8.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("external/von.lua")

--[[ Include Vercas's serialization library and the Clockwork kernel. --]]
include("external/utf8.lua")
include("external/von.lua")
include("clockwork/framework/sv_cax_patch.lua")
include("clockwork/framework/sv_kernel.lua")

if Clockwork and cwBootComplete then
	MsgC(Color(0, 255, 100, 255), "[Clockwork] Auto-refresh handled server-side in " .. math.Round(os.clock() - startTime, 3) .. " second(s)!\n")
else
	MsgC(Color(0, 255, 100, 255), "[Clockwork] Successfully loaded Clockwork version " .. Clockwork.kernel:GetVersionBuild() .. " in " .. math.Round(os.clock() - startTime, 3) .. " second(s).\n")
end

cwBootComplete = true
if cwReloading then cwReloaded = true end