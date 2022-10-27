--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]
--Also Credits to Tyler.exe for helping me understanding, writing codes in weard orders that I need to order (so I learn) and the description. :)

local Clockwork = Clockwork;
 
local COMMAND = Clockwork.command:New("CharSetSkin");
-- Command description.
COMMAND.tip = "Set a character's skin permanently.";
-- This is just for players to know what to type:
COMMAND.text = "<string Target> <number Skin>";
-- We want operators+ to be able to use this command.
COMMAND.access = "o";
-- 2 arguments, first is the target and second is the actual skin.
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
    -- Get the player as an entity. Since arguments is a table, you can get each part of a table by using tablename[value].
    -- In lua, it starts from 1 and so on, but in other languages it actually starts from 0.
    local target = Clockwork.player:FindByID(arguments[1]);
	
	-- Check if the player is actually valid. This is also the same as if (target == true) then ...
	if (target) then
		-- local skin = table.concat(arguments, " ", 2);
		    -- Don't worry about table.concat since the skin would only be a single value that won't have spaces.
		local targetSkins = target:GetCharacterData("Skins") or {};
		local skinvalue = tonumber(arguments[2]) or 0;
		local model = target:GetModel();
		
		
		if (skinvalue <= target:SkinCount()) then
		
			if( skinvalue == 0 )then
				targetSkins[model] = nil;
			else
				targetSkins[model] = skinvalue;
			end;
			
        -- Even if skin isn't already a character data, I'm pretty sure it will create one. *Not known...*
		target:SetSkin(skinvalue);
        target:SetCharacterData("Skins", targetSkins);
		
			-- Notify the target and the player that the skin was changed.
			--Clockwork.player:Notify(player, target:Name().."'s skin was set to "..skinvalue..".");
			if (target != player) then
				Clockwork.player:Notify(player, "Successfully changed " .. target:Name() .. "'s 'skin to ".. skinvalue .."'.");
				--Clockwork.player:Notify(target, player:Name().." set your skin to "..skinvalue..".");
			else
				Clockwork.player:Notify(player, "You have set your skin to '"..skinvalue.."'.");
			end;
        else
            -- Notify the player that the SKIN was not valid.
            Clockwork.player:Notify(player, skinvalue.." is not a valid skin!");
        end;
    else
        -- Notify the player that the TARGET was not valid, instead of target, we use arguments[1] since
        -- if the target is not valid and we attempt to call it as an entity (player:FindByID), a nil value is returned.
        -- thus, it will just show exactly what the player typed
        Clockwork.player:Notify(player, arguments[1].." is not a valid target!");
    end;
end;

COMMAND:Register();