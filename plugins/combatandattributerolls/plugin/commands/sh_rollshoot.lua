--[[
© 2015 CloudSixteen.com do not share, re-distribute or modify
without permission of its author (kurozael@gmail.com).


Clockwork was created by Conna Wiles (also known as kurozael.)
http://cloudsixteen.com/license/clockwork.html
--]]


local Clockwork = Clockwork;


local COMMAND = Clockwork.command:New("RollAttack");
COMMAND.tip = "Roll for an attack.";
COMMAND.text = "[one of the following; handgunsingle, handgunburst, smgburst, smgauto, riflesingle, rifleburst, rifleauto, handguncalledsingle, handguncalledburst, smgcalledburst, smgcalledauto, riflecalledsingle, riflecalledburst, riflecalledauto, handgunaimedsingle, handgunaimedburst, smgaimedburst smgaimedauto, rifleaimedsingle, rifleaimedburst, rifleaimedauto, sniper, aimedsniper, grenade, melee, vortessence, shotgun, calledshotgun, aimedshotgun ";


-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
local number = math.Clamp(math.floor(tonumber(100)), 1, 100)
local roll = math.random(1, number)
local atbs = math.floor(Clockwork.attributes:Fraction(player, ATB_STRENGTH, 100, 0)) / 4
local atba = math.floor(Clockwork.attributes:Fraction(player, ATB_ACROBATICS, 100, 0)) / 4
local atbm = math.floor(Clockwork.attributes:Fraction(player, ATB_MEDICAL, 100, 0)) / 4
local atbg = math.floor(Clockwork.attributes:Fraction(player, ATB_AGILITY, 100, 0)) / 4
local atbe = math.floor(Clockwork.attributes:Fraction(player, ATB_ENDURANCE, 100, 0)) / 4
local atbd = math.floor(Clockwork.attributes:Fraction(player, ATB_DEXTERITY, 100, 0)) / 4
local ws = player:GetCharacterData("weaponskill")
local bs = player:GetCharacterData("ballisticsskill")
local hs = player:GetCharacterData("handgunsskill")
local rs = player:GetCharacterData("riflesskill")
local ss = player:GetCharacterData("snipersskill")
local vm = player:GetCharacterData("vortessencemastery")
local handgunsingle = 15
local handgunburst = 0
local smgburst = 10
local smgauto = 0
local riflesingle = 20
local rifleburst = 15
local rifleauto = 0
local vorti = 0
local vortifar = -10
local riflecloseauto = 10
local smgcloseauto = 10
local aimedsingle = 35
local aimedburst = 30
local aimedauto = 15
local handgunaimedsingle = 30
local handgunaimedburst = 20
local rifleaimedsingle = 35
local rifleaimedburst = 30
local rifleaimedauto = 15
local smgaimedburst = 25
local rifleaimedcloseauto = 25
local smgaimedauto = 15
local smgaimedcloseauto = 25
local handguncalledsingle = -10
local handguncalledburst = -20
local smgcalledauto = -25
local smgcalledburst = -15
local smgsingle = 15
local smgaimedsingle = 30
local smgcalledsingle = -10
local riflecalledauto = -25
local riflecalledsingle = -10
local riflecalledburst = -15
local riflecalledcloseauto = -10
local smgcalledcloseauto = -10
local grenade = math.Clamp(math.floor(tonumber(5)), 5, 5)
local trace = player:GetEyeTraceNoCursor()
local range = player:GetShootPos():Distance(trace.HitPos)
local rangemod = math.Round(range / 28, 1 )
local sniperrangemod = math.Round(range / 130, 1 )
local gunrangemod = math.Round(rangemod - 20, 1 ) 
local smggunrangemod = math.Round(rangemod - 15, 1 ) 
local shotgunrangemod = math.Round(rangemod - 10, 1 ) 
local riflegunrangemod = math.Round(rangemod - 25, 1 ) 
local naderangemod = math.Round(range / 14, 1 )
local autoCQBrangemod = math.Round(naderangemod - 10, 1 ) 
local vortrangemod = math.Round(naderangemod - 30, 1 )
local snipersnapshot = -20
local aimedsniper = -5
local snipersnapshotclose = -50
local aimedclosesniper = -35
local unskillsnipersnapshot = -50
local unskillaimedsniper = -35
local unskillsnipersnapshotclose = -50
local unskillaimedclosesniper = -40

if (arguments[1]) then

if string.lower(arguments[1]) == "aimedsniper" then
	if rangemod >= 20 then
	--	if ss >= 1 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a well placed sniper shot, they achieved " .. roll + aimedsniper + ss -  math.Round(sniperrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a well placed sniper shot, they achieved " .. roll + aimedsniper + ss - smath.Round(sniperrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
--		else
--Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a well placed sniper shot but is untrained, they achieved " .. roll + unskillaimedsniper + ss - math.Round(sniperrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
--Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a well placed sniper shot but is untrained, they achieved " .. roll + unskillaimedsniper + ss - math.Round(sniperrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
--		end
else
	--	if ss >= 1 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a close range well placed sniper shot, they achieved " .. roll + aimedclosesniper + ss .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a close range well placed sniper shot, they achieved " .. roll + aimedclosesniper + ss .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
	--	else
--Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a close range well placed sniper shot but is untrained, they achieved " .. roll + unskillaimedclosesniper + ss .. " after modifiers! Initial Roll: " .. roll .. ".")
--Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a close range well placed sniper shot but is untrained, they achieved " .. roll + unskillaimedclosesniper + ss .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
	--	end;
end
return
end

if string.lower(arguments[1]) == "sniper" then
	if rangemod >= 20 then
	--	if ss >= 1 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a sniper snapshot, they achieved " .. roll + snipersnapshot + ss .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a  sniper snapshot, they achieved " .. roll + snipersnapshot + ss .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
	--	else
--Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a sniper snapshot and is untrained, they achieved " .. roll + unskillsnipersnapshot + ss .. " after modifiers! Initial Roll: " .. roll .. ".")
--Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a  sniper snapshot and is untrained, they achieved " .. roll + unskillsnipersnapshot + ss .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
	--	end
else
	--	if ss >= 1 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a close range sniper snapshot, they achieved " .. roll + snipersnapshotclose + ss .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a close range sniper snapshot, they achieved " .. roll + snipersnapshotclose + ss .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
	--	else
--Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a close range sniper snapshot and is untrained, they achieved " .. roll + unskillsnipersnapshotclose + ss .. " after modifiers! Initial Roll: " .. roll .. ".")
--Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a close range  sniper snapshot and is untrained, they achieved " .. roll + unskillsnipersnapshotclose + ss .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

	--	end
end
return
end

if string.lower(arguments[1]) == "vortessence" then
if rangemod >= 20 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with the vortessence, they achieved " .. roll + vorti + vm - math.Round(vortrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with the vortessence, they achieved " .. roll + vorti + vm - math.Round(vortrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with the vortessence, they achieved " .. roll + vorti + vm - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with the vortessence, they achieved " .. roll + vorti + vm - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
end
return
end

if string.lower(arguments[1]) == "handgunsingle" then

if rangemod >= 15 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a single handgun shot, they achieved " .. roll + handgunsingle + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a single handgun shot, they achieved " .. roll + handgunsingle + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a single handgun shot, they achieved " .. roll + handgunsingle + hs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a single handgun shot, they achieved " .. roll + handgunsingle + hs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

return
end


if string.lower(arguments[1]) == "handgunburst" then
if rangemod >= 15 then


Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted a burst fire attack with their handgun, they achieved" .. roll + handgunburst + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted a burst fire attack with their handgun, they achieved " .. roll + handgunburst + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted a burst fire attack with their handgun, they achieved" .. roll + handgunburst + hs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted a burst fire attack with their handgun, they achieved " .. roll + handgunburst + hs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

return
end

if string.lower(arguments[1]) == "smgsingle" then

if rangemod >= 15 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted a semi-automatic fire attack with their smg, they achieved" .. roll + smgsingle + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted a semi-automatic fire attack with their smg, they achieved " .. roll + smgsingle + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted a semi-automatic fire attack with their smg, they achieved" .. roll + smgsingle + bs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted a semi-automatic fire attack with their smg, they achieved " .. roll + smgsingle + bs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end

if string.lower(arguments[1]) == "smgburst" then

if rangemod >= 15 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted a burst fire attack with their smg, they achieved" .. roll + smgburst + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted a burst fire attack with their smg, they achieved " .. roll + smgburst + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted a burst fire attack with their smg, they achieved" .. roll + smgburst + bs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted a burst fire attack with their smg, they achieved " .. roll + smgburst + bs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end


if string.lower(arguments[1]) == "smgauto" then
if rangemod >= 10 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted an automatic attack with their SMG, they achieved,  " .. roll + smgauto + bs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted an automatic fire attack with their SMG, they achieved " .. roll + smgauto + bs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted an automatic attack with their SMG, they achieved,  " .. roll + smgcloseauto + bs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted an automatic fire attack with their SMG, they achieved " .. roll + smgcloseauto + bs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)



end
return
end


if string.lower(arguments[1]) == "riflesingle" then

if rangemod >= 20 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a single rifle shot, they achieved " .. roll + riflesingle + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a single rifle shot, they achieved " .. roll + riflesingle + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted to attack with a single rifle shot, they achieved " .. roll + riflesingle + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted to attack with a single rifle shot, they achieved " .. roll + riflesingle + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

return
end


if string.lower(arguments[1]) == "rifleburst" then

if rangemod >= 20 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted a burst fire rifle attack, they achieved" .. roll + rifleburst + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted a burst fire rifle attack, they achieved " .. roll + rifleburst + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted a burst fire rifle attack, they achieved" .. roll + rifleburst + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted a burst fire rifle attack, they achieved " .. roll + rifleburst + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end

if string.lower(arguments[1]) == "rifleauto" then

if rangemod >= 10 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted an automatic fire rifle attack, they achieved" .. roll + rifleauto + rs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted an automatic fire rifle attack, they achieved " .. roll + rifleauto + rs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " attempted an automatic fire rifle attack, they achieved" .. roll + riflecloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "attempted an automatic fire rifle attack, they achieved " .. roll + riflecloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end


if string.lower(arguments[1]) == "shotgun" then

if rangemod >= 10 then


Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a shotgun attack, they achieved,  " .. roll + rifleauto + rs - math.Round(shotgunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a shotgun attack, they achieved " .. roll + rifleauto + rs - math.Round(shotgunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)


else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a shotgun attack, they achieved,  " .. roll + riflecloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a shotgun attack, they achieved " .. roll + riflecloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)


end

return
end

if string.lower(arguments[1]) == "aimedshotgun" then

if rangemod >= 10 then


Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted an aimed shotgun attack, they achieved,  " .. roll + rifleaimedauto + rs - math.Round(shotgunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted an aimed shotgun attack, they achieved " .. roll + rifleaimedauto + rs - math.Round(shotgunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)


else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted an aimed shotgun attack, they achieved,  " .. roll + rifleaimedcloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted an aimed shotgun attack, they achieved " .. roll + rifleaimedcloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)


end

return
end

if string.lower(arguments[1]) == "calledshotgun" then

if rangemod >= 10 then


Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a called shotgun attack, they achieved,  " .. roll + riflecalledauto + rs - math.Round(shotgunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a called shotgun attack, they achieved " .. roll + riflecalledauto + rs - math.Round(shotgunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)


else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a called shotgun attack, they achieved,  " .. roll + riflecalledcloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a called shotgun attack, they achieved " .. roll + riflecalledcloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)


end

return
end



if string.lower(arguments[1]) == "handgunaimedsingle" then
if rangemod >= 15 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has taken a single, aimed handgun shot, they achieved " .. roll + handgunaimedsingle + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has taken a single, aimed handgun shot, they achieved " .. roll + handgunaimedsingle + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


else

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has taken a single, aimed handgun shot, they achieved " .. roll + handgunaimedsingle + hs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has taken a single, aimed handgun shot, they achieved " .. roll + handgunaimedsingle + hs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end


return
end


if string.lower(arguments[1]) == "handgunaimedburst" then

if rangemod >= 15 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired an aimed burst from their handgun, they achieved " .. roll + handgunaimedburst + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has fired an aimed burst from their handgun, they achieved " .. roll + handgunaimedburst + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired an aimed burst from their handgun, they achieved " .. roll + handgunaimedburst + hs .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has fired an aimed burst from their handgun, they achieved " .. roll + handgunaimedburst + hs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end

if string.lower(arguments[1]) == "smgaimedsingle" then

if rangemod >= 15 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired an aimed semi-automatic SMG attack, they achieved " .. roll + smgaimedsingle + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has fired an aimed semi-automatic SMG attack, they achieved " .. roll + smgaimedsingle + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired an aimed semi-automatic SMG attack, they achieved " .. roll + smgaimedsingle + bs .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has fired an aimed semi-automatic SMG attack, they achieved " .. roll + smgaimedsingle + bs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end
return
end

if string.lower(arguments[1]) == "smgaimedburst" then

if rangemod >= 15 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired an aimed burst of SMG bullets, they achieved " .. roll + smgaimedburst + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has fired an aimed burst of SMG bullets, they achieved " .. roll + smgaimedburst + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired an aimed burst of SMG bullets, they achieved " .. roll + smgaimedburst + bs .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has fired an aimed burst of SMG bullets, they achieved " .. roll + smgaimedburst + bs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end
return
end


if string.lower(arguments[1]) == "smgaimedauto" then

if rangemod >= 10 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted an aimed SMG automatic fire attack, they achieved " .. roll + smgaimedauto + bs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted an aimed SMG automatic fire attack, they achieved " .. roll + smgaimedauto + bs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted an aimed SMG automatic fire attack, they achieved " .. roll + smgaimedcloseauto + bs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted an aimed SMG automatic fire attack, they achieved " .. roll + smgaimedcloseauto + bs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

end


return
end



if string.lower(arguments[1]) == "rifleaimedsingle" then
if rangemod >= 20 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has taken a single, aimed shot with their rifle, they achieved " .. roll + rifleaimedsingle + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has taken a single, aimed shot with their rifle, they achieved " .. roll + rifleaimedsingle + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has taken a single, aimed shot with their rifle, they achieved " .. roll + rifleaimedsingle + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has taken a single, aimed shot with their rifle, they achieved " .. roll + rifleaimedsingle + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

return
end


if string.lower(arguments[1]) == "rifleaimedburst" then
if rangemod >= 20 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired an aimed burst from their rifle, they achieved " .. roll + rifleaimedburst + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has fired an aimed burst from their rifle, they achieved " .. roll + rifleaimedburst + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired an aimed burst from their rifle, they achieved " .. roll + rifleaimedburst + rs .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has fired an aimed burst from their rifle, they achieved " .. roll + rifleaimedburst + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())



end
return
end


if string.lower(arguments[1]) == "rifleaimedauto" then
if rangemod >= 10 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted an aimed automatic fire attack with their rifle, they achieved " .. roll + rifleaimedauto + rs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted an aimed automatic fire attack with their rifle, they achieved " .. roll + rifleaimedauto + rs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)


else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted an aimed automatic fire attack with their rifle, they achieved " .. roll + rifleaimedcloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted an aimed automatic fire attack with their rifle, they achieved " .. roll + rifleaimedcloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

end

return
end



if string.lower(arguments[1]) == "handguncalledsingle" then
if rangemod >= 15 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a single called shot with a handgun, they achieved " .. roll + handguncalledsingle + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a single called shot with a handgun, they achieved " .. roll + handguncalledsingle + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a single called shot with a handgun, they achieved " .. roll + handguncalledsingle + hs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a single called shot with a handgun, they achieved " .. roll + handguncalledsingle + hs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end


return
end


if string.lower(arguments[1]) == "handguncalledburst" then
if rangemod >= 15 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired a called burst attack with their handgun, they achieved " .. roll + handguncalledburst + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "had fired a called burst attack with their handgun, they achieved " .. roll + handguncalledburst + hs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired a called burst attack with their handgun, they achieved " .. roll + handguncalledburst + hs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "had fired a called burst attack with their handgun, they achieved " .. roll + handguncalledburst + hs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end

if string.lower(arguments[1]) == "smgcalledsingle" then
if rangemod >= 15 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired a called semi-automatic SMG attack, they achieved " .. roll + smgcalledsingle + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "had fired a called semi-automatic SMG attack, they achieved " .. roll + smgcalledsingle + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired a called semi-automatic SMG attack, they achieved " .. roll + smgcalledsingle + bs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "had fired a called semi-automatic SMG attack, they achieved " .. roll + smgcalledsingle + bs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end

if string.lower(arguments[1]) == "smgcalledburst" then
if rangemod >= 15 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired a called smg burst attack, they achieved " .. roll + smgcalledburst + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "had fired a called smg burst attack, they achieved " .. roll + smgcalledburst + bs - math.Round(smggunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired a called smg burst attack, they achieved " .. roll + smgcalledburst + bs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "had fired a called smg burst attack, they achieved " .. roll + smgcalledburst + bs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end


if string.lower(arguments[1]) == "smgcalledauto" then
if rangemod >= 10 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a called SMG automatic fire attack, they achieved " .. roll + smgcalledauto + bs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a called smg automatic fire attack roll, they achieved " .. roll + smgcalledauto + bs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a called SMG automatic fire attack, they achieved " .. roll + smgcalledcloseauto + bs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a called smg automatic fire attack roll, they achieved " .. roll + smgcalledcloseauto + bs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)


end

return
end


if string.lower(arguments[1]) == "riflecalledsingle" then
if rangemod >= 20 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a single called rifle shot, they achieved " .. roll + riflecalledsingle + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a single called rifle shot, they achieved " .. roll + riflecalledsingle + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a single called rifle shot, they achieved " .. roll + riflecalledsingle + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a single called rifle shot, they achieved " .. roll + riflecalledsingle + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

return
end


if string.lower(arguments[1]) == "riflecalledburst" then
if rangemod >= 20 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired a called burst attack with a rifle, they achieved " .. roll + riflecalledburst + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "had fired a called burst attack with a rifle, they achieved " .. roll + riflecalledburst + rs - math.Round(gunrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has fired a called burst attack with a rifle, they achieved " .. roll + riflecalledburst + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "had fired a called burst attack with a rifle, they achieved " .. roll + riflecalledburst + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end


if string.lower(arguments[1]) == "riflecalledauto" then
if rangemod >= 15 then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a called automatic rifle fire attack, they achieved " .. roll + riflecalledauto + rs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a called automatic rifle fire attack roll, they achieved " .. roll + riflecalledauto + rs - math.Round(autoCQBrangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a called automatic rifle fire attack, they achieved " .. roll + riflecalledcloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has attempted a called automatic rifle fire attack roll, they achieved " .. roll + riflecalledcloseauto + rs .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)


end

return
end

if string.lower(arguments[1]) == "melee" then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has attempted a melee attack, they achieved  " .. roll + ws + math.Round(atbg) .. " after modifiers! Initial Roll: " .. roll .. ".")
Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a melee attack, they achieved " .. roll + ws + math.Round(atbg) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


return
end


if string.lower(arguments[1]) == "grenade" then
if rangemod >= 15 then

Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has thrown a grenade, they achieved " .. roll + math.Round(atbd) - math.Round(naderangemod) .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has thrown a grenade, they achieved " .. roll + math.Round(atbd) - math.Round(naderangemod) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

else
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has thrown a grenade, they achieved " .. roll + math.Round(atbd) .. " after modifiers! Initial Roll: " .. roll .. ".") 
Clockwork.chatBox:AddInRadius(player, "roll", "has thrown a grenade, they achieved " .. roll + math.Round(atbd) .. " after modifiers! Initial Roll: " .. roll .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())


end

return
end
if arguments[1] ~= "melee" or arguments[1] ~= "handgunsingle" or arguments[1] ~= "handgunburst" or arguments[1] ~= "riflesingle" or arguments[1] ~= "rifleburst" or arguments[1] ~= "smgburst" or arguments[1] ~= "sniper" or arguments[1] ~= "smgaimedsingle" or arguments[1] ~= "smgcalledsingle" or arguments[1] ~= "smgsingle" or arguments[1] ~= "aimedsniper" or arguments[1] ~= "smgauto" or arguments[1] ~= "rifleauto" or arguments[1] ~= "handguncalledsingle" or arguments[1] ~= "handguncalledburst" or arguments[1] ~= "smgcalledauto" or arguments[1] ~= "smgcalledburst" or arguments[1] ~= "riflecalledsingle" or arguments[1] ~= "riflecalledburst" or arguments[1] ~= "riflecalledauto" or arguments[1] ~= "grenade" or arguments[1] ~= "handgunaimedsingle" or arguments[1] ~= "handgunaimedburst" or arguments[1] ~= "smgaimedburst" or arguments[1] ~= "smgaimedauto" or arguments[1] ~= "rifleaimedsingle" or arguments[1] ~= "rifleaimedauto" or arguments[1] ~= "shotgun" or arguments[1] ~= "aimedshotgun" or arguments[1] ~= "calledshotgun" or arguments[1] ~= "rifleaimedburst" then
player:Notify(arguments[1] .. " is not a valid attribute or a weapon roll!")
player:Notify("The following arguments are valid: handgunsingle, handgunburst, smgburst, smgauto, riflesingle, rifleburst, rifleauto, handguncalledsingle, handguncalledburst, smgcalledburst, smgcalledauto, riflecalledsingle, riflecalledburst, riflecalledauto, handgunaimedsingle, handgunaimedburst, smgaimedburst, smgaimedauto, rifleaimedsingle, rifleaimedburst, rifleaimedauto, sniper, aimedsniper, grenade, melee, shotgun, calledshotgun, aimedshotgun")


return
end

end;


if not arguments[1] then
Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a generic d100, they rolled " .. roll .. " out of " .. number .. "!")
Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a generic d100, they rolled " .. roll .. " out of " .. number .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
end
end


COMMAND:Register()