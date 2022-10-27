--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("RollAttribute");
COMMAND.tip = "Roll for a stat.";
COMMAND.text = "[one of the following; acro, agi, med, end, str, dex]";

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

		if (arguments[1]) then
			if string.lower(arguments[1]) == "acro" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled an Acrobatics check they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atba) .. " from their attribute, the total is " .. roll + math.Round(atba))
				Clockwork.chatBox:AddInRadius(player, "roll", " has rolled an Acrobatics check, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atba) .. " from their attribute, the total is " .. roll + math.Round(atba) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "med" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled a Medical check, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbm) .. " from their attribute, the total is " .. roll + math.Round(atbm))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a Medical check, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbm) .. " from their attribute, the total is " .. roll + math.Round(atbm) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "end" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled an Endurance check, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbe) .. " from their attribute, the total is " .. roll + math.Round(atbe))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled an Endurance check, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbe) .. " from their attribute, the total is " .. roll + math.Round(atbe) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "str" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled an Strength check, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .. " from their attribute, the total is " .. roll + math.Round(atbs))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled an Strength check, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbs) .. " from their attribute, the total is " .. roll + math.Round(atbs) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "dex" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled a Dexterity check, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .. " from their attribute, the total is " .. roll + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a Dexterity check, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbd) .. " from their attribute, the total is " .. roll + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "agi" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled an Agility check, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbg) .. " from their attribute, the total is " .. roll + math.Round(atbg))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled an Agility check, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbg) .. " from their attribute, the total is " .. roll + math.Round(atbg) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			
			if arguments[1] ~= "acro" or arguments[1] ~= "med" or arguments[1] ~= "end" or arguments[1] ~= "str" or arguments[1] ~= "dex" or arguments[1] ~= "agi" then
				player:Notify(arguments[1] .. " is not a valid attribute or a weapon roll!")
				player:Notify("The following arguments are valid: acro, med, end, dex, str, agi")

				return
			end
			

		end

		if not arguments[1] then
			Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a generic roll, they rolled " .. roll .. " out of " .. number .. "!")
			Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a generic roll, they rolled " .. roll .. " out of " .. number .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
		end
	end

	COMMAND:Register()
