--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]
--Also Credits to Tyler.exe for helping me understanding, writing codes in weard orders that I need to order (so I learn) and the description. :)

local Clockwork = Clockwork;
 
local COMMAND = Clockwork.command:New("CharSetBodygroup");
COMMAND.tip = "Set a characters bodygroup permanently.";
COMMAND.text = "<string Target> <number Bodygroup> <number State>";
COMMAND.access = "a";
-- 2 arguments, first is the target and second is the actual bodygroup.
COMMAND.arguments = 3;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
    local target = Clockwork.player:FindByID(arguments[1]);
	
	-- Check if the player is actually valid. This is also the same as if (target == true) then ...
	if (target) then
		local targetBodyGroups = target:GetCharacterData("BodyGroups") or {};
		local bodygroupstatevalue = tonumber(arguments[3]) or 0;
		local bodygroupvalue = tonumber(arguments[2]) or 0;
		local model = target:GetModel();
		
		
		if (bodygroupvalue <= target:GetNumBodyGroups()) then
			targetBodyGroups[model] = targetBodyGroups[model] or {};
			
			if( bodyGroupState == 0 )then
				targetBodyGroups[model][tostring(bodygroupvalue)] = nil;
			else
				targetBodyGroups[model][tostring(bodygroupvalue)] = bodygroupstatevalue;
			end;
		
		target:SetCharacterData("BodyGroups", targetBodyGroups);
		target:SetBodygroup(bodygroupvalue, bodygroupstatevalue);
		
			-- Notify the target and the player that the bodygroup was changed.	
			if (target != player) then
				Clockwork.player:Notify(player, "Successfully changed " .. target:Name() .. "'s '".. target:GetBodygroupName(bodygroupvalue) .."' (".. bodygroupvalue ..") bodygroup to '".. bodygroupstatevalue .."'.");
				Clockwork.player:Notify(target, player:Name().." set your " .. target:GetBodygroupName(bodygroupvalue) .."' (".. bodygroupvalue ..") bodygroup to '".. bodygroupstatevalue .."'.");
			else
				Clockwork.player:Notify(player, "You have set your '"..target:GetBodygroupName(bodygroupvalue).."' ("..bodygroupvalue..") bodygroup to "..bodygroupstatevalue..".");
			end;
        else
            -- Notify the player that the BODYGROUP was not valid.
            Clockwork.player:Notify(player, bodygroupvalue.." is not a valid bodygroup!");
        end;
    else
        -- Notify the player that the TARGET was not valid, instead of target, we use arguments[1] since
        -- if the target is not valid and we attempt to call it as an entity (player:FindByID), a nil value is returned.
        -- thus, it will just show exactly what the player typed
        Clockwork.player:Notify(player, arguments[1].." is not a valid target!");
    end;
end;

COMMAND:Register();