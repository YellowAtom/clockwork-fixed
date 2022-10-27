--[[
� 2015 CloudSixteen.com do not share, re-distribute or modify
without permission of its author (kurozael@gmail.com).


Clockwork was created by Conna Wiles (also known as kurozael.)
http://cloudsixteen.com/license/clockwork.html
--]]


local Clockwork = Clockwork;


local COMMAND = Clockwork.command:New("RollHitLocation");
COMMAND.tip = "Rolls a Randomised Hit Location for an attack";
COMMAND.text = "Number of shots";


-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)


if (arguments[1]) then

	local shotnum = tonumber(arguments[1])

local function GetWeightedRandomKey( tab )
	local sum = 0
	local hitloc = hitloc
	for _, chance in pairs( tab ) do
		sum = sum + chance
	end

	local select = math.random() * sum

	for key, chance in pairs( tab ) do
		select = select - chance
		if select < 0 then return key end
	end
end

local bodypart = {
	UpperTorso = 24,
	LeftUpperLeg = 6,
	LeftLowerLeg = 5,
	LeftHand = 2,	
	LeftFoot = 2,
	LeftUpperArm = 5,
	LeftForearm = 5,
	LowerTorso = 22,
	RightUpperArm = 5,
	RightForearm = 5,
	RightUpperLeg = 6,
	RightLowereg = 5,		
	RightHand = 2,
	RightFoot = 2,
	Head = 3
}

if shotnum == 1 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

elseif shotnum == 2 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	local hitloc2 = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. " and " .. hitloc2 .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. " and " .. hitloc2 .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

elseif shotnum == 3 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	local hitloc2 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc3 = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 .." and " .. hitloc3 .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 .." and " .. hitloc3 .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

elseif shotnum == 4 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	local hitloc2 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc3 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc4 = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 .." and " .. hitloc4 .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 .." and " .. hitloc4 .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

elseif shotnum == 5 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	local hitloc2 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc3 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc4 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc5 = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 .." and " .. hitloc5 .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 .." and " .. hitloc5 .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

elseif shotnum == 6 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	local hitloc2 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc3 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc4 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc5 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc6 = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 .." and " .. hitloc6 .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 .." and " .. hitloc6 .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

elseif shotnum == 7 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	local hitloc2 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc3 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc4 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc5 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc6 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc7 = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 ..", " .. hitloc6 .." and " .. hitloc7 .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 ..", " .. hitloc6 .." and " .. hitloc7 .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

elseif shotnum == 8 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	local hitloc2 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc3 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc4 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc5 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc6 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc7 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc8 = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 ..", " .. hitloc6 ..", " .. hitloc7 .." and " .. hitloc8 .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 ..", " .. hitloc6 ..", " .. hitloc7 .." and " .. hitloc8 .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

elseif shotnum == 9 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	local hitloc2 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc3 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc4 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc5 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc6 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc7 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc8 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc9 = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 ..", " .. hitloc6 ..", " .. hitloc7 ..", " .. hitloc8 .." and " .. hitloc9 .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 ..", " .. hitloc6 ..", " .. hitloc7 ..", " .. hitloc8 .." and " .. hitloc9 .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end

elseif shotnum == 10 then

for i = 1, 1 do

	local hitloc = ( GetWeightedRandomKey( bodypart ) )
	local hitloc2 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc3 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc4 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc5 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc6 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc7 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc8 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc9 = ( GetWeightedRandomKey( bodypart ) )
	local hitloc10 = ( GetWeightedRandomKey( bodypart ) )
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 ..", " .. hitloc6 ..", " .. hitloc7 ..", " .. hitloc8 ..", " .. hitloc9 .." and " .. hitloc10 .. "!")
	Clockwork.chatBox:AddInRadius(player, "roll", "has rolled for their shot(s) hit location, they got " .. hitloc .. ", " .. hitloc2 ..", " .. hitloc3 ..", " .. hitloc4 ..", " .. hitloc5 ..", " .. hitloc6 ..", " .. hitloc7 ..", " .. hitloc8 ..", " .. hitloc9 .." and " .. hitloc10 .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

end


else
player:Notify("Please enter a number between 1 and 10.")
end;

else

end

end



COMMAND:Register()