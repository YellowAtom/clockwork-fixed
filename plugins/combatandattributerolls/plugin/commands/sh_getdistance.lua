--[[
� 2015 CloudSixteen.com do not share, re-distribute or modify
without permission of its author (kurozael@gmail.com).


Clockwork was created by Conna Wiles (also known as kurozael.)
http://cloudsixteen.com/license/clockwork.html
--]]


local Clockwork = Clockwork;


local COMMAND = Clockwork.command:New("getdistance");
COMMAND.tip = "Check how far away you are from what you are looking at";
COMMAND.text = "<none>";


-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)

local trace = player:GetEyeTraceNoCursor()
local range = player:GetShootPos():Distance(trace.HitPos)
local rangemod = math.Round(range / 28, 1 )



			Clockwork.player:Notify(player, "You are ".. math.Round(rangemod) .." meters from that position.");

end;

COMMAND:Register()