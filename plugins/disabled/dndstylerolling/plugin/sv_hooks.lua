function PLUGIN:ClockworkInitialized()
	local COMMAND = Clockwork.command:FindByID("Roll")
	COMMAND.tip = "Testing command."
	COMMAND.text = "<none>"

	-- Called when the command has been run.
	function COMMAND:OnRun(player, arguments)
		local number = math.Clamp(math.floor(tonumber(20)), 1, 20)
		local roll = math.random(1, number)
		local atbs = math.floor(Clockwork.attributes:Fraction(player, ATB_STRENGTH, 100, 0)) / 10
		local atba = math.floor(Clockwork.attributes:Fraction(player, ATB_ACROBATICS, 100, 0)) / 10
		local atbm = math.floor(Clockwork.attributes:Fraction(player, ATB_MEDICAL, 100, 0)) / 10
		local atbg = math.floor(Clockwork.attributes:Fraction(player, ATB_AGILITY, 100, 0)) / 10
		local atbe = math.floor(Clockwork.attributes:Fraction(player, ATB_ENDURANCE, 100, 0)) / 10
		local atbd = math.floor(Clockwork.attributes:Fraction(player, ATB_DEXTERITY, 100, 0)) / 10
		local pistolclose = math.Clamp(math.floor(tonumber(2)), 2, 2)
		local pistolfar = math.Clamp(math.floor(tonumber(1)), 1, 1)
		local smgclose = math.Clamp(math.floor(tonumber(3)), 3, 3)
		local smgfar = math.Clamp(math.floor(tonumber(1)), 1, 1)
		local shotgunclose = math.Clamp(math.floor(tonumber(5)), 5, 5)
		local shotgunfar = math.Clamp(math.floor(tonumber(2)), 2, 2)
		local ar2close = math.Clamp(math.floor(tonumber(4)), 4, 4)
		local ar2far = math.Clamp(math.floor(tonumber(2)), 2, 2)
		local magnumclose = math.Clamp(math.floor(tonumber(5)), 5, 5)
		local magnumfar = math.Clamp(math.floor(tonumber(0)), 0, 0)
		local stunstick = math.Clamp(math.floor(tonumber(2)), 2, 2)
		local crowbar = math.Clamp(math.floor(tonumber(2)), 2, 2)
		local grenade = math.Clamp(math.floor(tonumber(5)), 5, 5)
		local rpg = math.Clamp(math.floor(tonumber(8)), 8, 8)
		

		if (arguments[1]) then
			if string.lower(arguments[1]) == "acro" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled an Acrobatics d20, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atba) .. " from their attribute roll, the total is " .. roll + math.Round(atba))
				Clockwork.chatBox:AddInRadius(player, "roll", " has rolled an Acrobatics d20, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atba) .. " from their attribute roll, the total is " .. roll + math.Round(atba) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "med" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled a Medical d20, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbm) .. " from their attribute roll, the total is " .. roll + math.Round(atbm))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a Medical d20, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbm) .. " from their attribute roll, the total is " .. roll + math.Round(atbm) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "end" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled an Endurance d20, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbe) .. " from their attribute roll, the total is " .. roll + math.Round(atbe))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled an Endurance d20, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbe) .. " from their attribute roll, the total is " .. roll + math.Round(atbe) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "str" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled an Strength d20, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .. " from their attribute roll, the total is " .. roll + math.Round(atbs))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled an Strength d20, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbs) .. " from their attribute roll, the total is " .. roll + math.Round(atbs) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "dex" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled a Dexterity d20, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .. " from their attribute roll, the total is " .. roll + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a Dexterity d20, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbd) .. " from their attribute roll, the total is " .. roll + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "agi" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. "has rolled an Agility d20, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbg) .. " from their attribute roll, the total is " .. roll + math.Round(atbg))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled an Agility d20, they rolled " .. roll .. " out of " .. number .. " Adding " .. math.Round(atbg) .. " from their attribute roll, the total is " .. roll + math.Round(atbg) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "pistolclose" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a close ranged 9mm d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. pistolclose .. " from their attribute roll and their weapon bonus, the total is " .. roll + pistolclose + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a close ranged 9mm d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. pistolclose .. " from their attribute roll and their weapon bonus, the total is " .. roll + pistolclose + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "pistolfar" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a far ranged 9mm d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. pistolfar .. " from their attribute roll and their weapon bonus, the total is " .. roll + pistolfar + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a far ranged 9mm d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. pistolfar .. " from their attribute roll and their weapon bonus, the total is " .. roll + pistolfar + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

				return
			end
			
			if string.lower(arguments[1]) == "smgclose" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a close ranged SMG d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. smgclose .. " from their attribute roll and their weapon bonus, the total is " .. roll + smgclose + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a close ranged SMG d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. smgclose .. " from their attribute roll and their weapon bonus, the total is " .. roll + smgclose + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end
			
			if string.lower(arguments[1]) == "smgfar" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a far ranged SMG d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. smgfar .. " from their attribute roll and their weapon bonus, the total is " .. roll + smgfar + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a far ranged SMG d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. smgfar .. " from their attribute roll and their weapon bonus, the total is " .. roll + smgfar + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

				return
			end
			
			if string.lower(arguments[1]) == "shotgunfar" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a far ranged SPAS-12 d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. shotgunfar .. " from their attribute roll and their weapon bonus, the total is " .. roll - shotgunfar + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a far ranged SPAS-12 d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. shotgunfar .. " from their attribute roll and their weapon bonus, the total is " .. roll - shotgunfar + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

				return
			end
			
			if string.lower(arguments[1]) == "shotgunclose" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a close ranged SPAS-12 d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. shotgunclose .. " from their attribute roll and their weapon bonus, the total is " .. roll + shotgunclose + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a close ranged SPAS-12 d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. shotgunclose .. " from their attribute roll and their weapon bonus, the total is " .. roll + shotgunclose + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end
			
			if string.lower(arguments[1]) == "ar2far" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a far ranged AR2 d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. ar2far .. " from their attribute roll and their weapon bonus, the total is " .. roll + ar2far + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a far ranged AR2 d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. ar2far .. " from their attribute roll and their weapon bonus, the total is " .. roll + ar2far + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

				return
			end
			
			if string.lower(arguments[1]) == "ar2close" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a close AR2 d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. ar2close .. " from their attribute roll and their weapon bonus, the total is " .. roll + ar2close + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a close ranged AR2 d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. ar2close .. " from their attribute roll and their weapon bonus, the total is " .. roll + ar2close + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end			

			if string.lower(arguments[1]) == "magnumfar" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a far ranged .357 Magnum d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. magnumfar .. " from their attribute roll and their weapon bonus, the total is " .. roll + magnumfar + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a far ranged .357 Magnum d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. magnumfar .. " from their attribute roll and their weapon bonus, the total is " .. roll + magnumfar + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

				return
			end

			if string.lower(arguments[1]) == "magnumclose" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a close ranged .357 Magnum d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. magnumclose .. " from their attribute roll and their weapon bonus, the total is " .. roll + magnumclose + math.Round(atbd))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a close ranged .357 Magnum d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbd) .." and " .. magnumclose .. " from their attribute roll and their weapon bonus, the total is " .. roll + magnumclose + math.Round(atbd) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "stunstick" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a stunstick d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .." and " .. stunstick .. " from their attribute roll and their weapon bonus, the total is " .. roll + stunstick + math.Round(atbs))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a stunstick d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .." and " .. stunstick .. " from their attribute roll and their weapon bonus, the total is " .. roll + stunstick + math.Round(atbs) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end
			
			if string.lower(arguments[1]) == "crowbar" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a crowbar d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .." and " .. crowbar .. " from their attribute roll and their weapon bonus, the total is " .. roll + crowbar + math.Round(atbs))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a crowbar d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .." and " .. crowbar .. " from their attribute roll and their weapon bonus, the total is " .. roll + crowbar + math.Round(atbs) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

				return
			end

			if string.lower(arguments[1]) == "grenade" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a grenade d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .." and " .. grenade .. " from their attribute roll and their weapon bonus, the total is " .. roll + grenade + math.Round(atbs))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a grenade d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .." and " .. grenade .. " from their attribute roll and their weapon bonus, the total is " .. roll + grenade + math.Round(atbs) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

				return
			end

			if string.lower(arguments[1]) == "rpg" then
				Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a RPG d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .." and " .. rpg .. " from their attribute roll and their weapon bonus, the total is " .. roll + rpg + math.Round(atbs))
				Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a RPG d20 attack roll, they rolled " .. roll .. " out of " .. number .. "! Adding " .. math.Round(atbs) .." and " .. rpg .. " from their attribute roll and their weapon bonus, the total is " .. roll + rpg + math.Round(atbs) .. "!", player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4)

				return
			end			
			
			if arguments[1] ~= "acro" or arguments[1] ~= "med" or arguments[1] ~= "end" or arguments[1] ~= "str" or arguments[1] ~= "dex" or arguments[1] ~= "pistol 1" or arguments[1] ~= "agi" or arguments[1] ~= "rpg" or arguments[1] ~= "grenade" or arguments[1] ~= "crowbar" or arguments[1] ~= "stunstick" or arguments[1] ~= "magnumfar" or arguments[1] ~= "magnumclose" or arguments[1] ~= "smgclose" or arguments[1] ~= "smgfar" or arguments[1] ~= "pistolclose" or arguments[1] ~= "pistolfar" or arguments[1] ~= "ar2close" or arguments[1] ~= "ar2far" or arguments[1] ~= "shotgunclose" or arguments[1] ~= "shotgunfar" then
				player:Notify(arguments[1] .. " is not a valid attribute or a weapon roll!")
				player:Notify("The following attributes are valid: Acrobatics, Medical, Endurance, Strength, Dexterity, Agility.")

				return
			end
			

		end

		if not arguments[1] then
			Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " has rolled a generic d20, they rolled " .. roll .. " out of " .. number .. "!")
			Clockwork.chatBox:AddInRadius(player, "roll", "has rolled a generic d20, they rolled " .. roll .. " out of " .. number .. ".", player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
		end
	end

	COMMAND:Register()
end