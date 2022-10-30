
local PLUGIN = PLUGIN

-- Called when a player's character data should be restored.
function PLUGIN:PlayerRestoreCharacterData(player, data)
	if not data["hunger"] then
		data["hunger"] = 0
	end

	if not data["thirst"] then
		data["thirst"] = 0
	end

	if not data["sleep"] then
		data["sleep"] = 0
	end
end

-- Called when a player's shared variables should be set.
function PLUGIN:PlayerSetSharedVars(player, curTime)
	player:SetSharedVar("hunger", math.Round(player:GetCharacterData("hunger")))
	player:SetSharedVar("thirst", math.Round(player:GetCharacterData("thirst")))
	player:SetSharedVar("sleep", math.Round(player:GetCharacterData("sleep")))

	if player:Alive() and not player:IsRagdolled() and player:GetVelocity():Length() > 0 then
		if player:GetCharacterData("thirst") == 100 then
			player:BoostAttribute("Thirst", ATB_ACROBATICS, -50)
			player:BoostAttribute("Thirst", ATB_ENDURANCE, -50)
			player:BoostAttribute("Thirst", ATB_STRENGTH, -50)
			player:BoostAttribute("Thirst", ATB_AGILITY, -50)
			player:BoostAttribute("Thirst", ATB_DEXTERITY, -50)
			player:BoostAttribute("Thirst", ATB_MEDICAL, -50)
		else
			player:BoostAttribute("Thirst", ATB_ACROBATICS, false)
			player:BoostAttribute("Thirst", ATB_ENDURANCE, false)
			player:BoostAttribute("Thirst", ATB_STRENGTH, false)
			player:BoostAttribute("Thirst", ATB_AGILITY, false)
			player:BoostAttribute("Thirst", ATB_DEXTERITY, false)
			player:BoostAttribute("Thirst", ATB_MEDICAL, false)
		end
	end

	if player:Alive() and not player:IsRagdolled() and player:GetVelocity():Length() > 0 then
		if tonumber(player:GetCharacterData("hunger")) >= 70 then
			player:BoostAttribute("Hunger", ATB_ACROBATICS, -10)
			player:BoostAttribute("Hunger", ATB_ENDURANCE, -10)
			player:BoostAttribute("Hunger", ATB_STRENGTH, -10)
			player:BoostAttribute("Hunger", ATB_AGILITY, -10)
			player:BoostAttribute("Hunger", ATB_DEXTERITY, -10)
			player:BoostAttribute("Hunger", ATB_MEDICAL, -10)
		elseif tonumber(player:GetCharacterData("hunger")) >= 80 then
			player:BoostAttribute("Hunger", ATB_ACROBATICS, -25)
			player:BoostAttribute("Hunger", ATB_ENDURANCE, -25)
			player:BoostAttribute("Hunger", ATB_STRENGTH, -25)
			player:BoostAttribute("Hunger", ATB_AGILITY, -25)
			player:BoostAttribute("Hunger", ATB_DEXTERITY, -25)
			player:BoostAttribute("Hunger", ATB_MEDICAL, -25)
		elseif tonumber(player:GetCharacterData("hunger")) >= 90 then
			player:BoostAttribute("Hunger", ATB_ACROBATICS, -30)
			player:BoostAttribute("Hunger", ATB_ENDURANCE, -30)
			player:BoostAttribute("Hunger", ATB_STRENGTH, -30)
			player:BoostAttribute("Hunger", ATB_AGILITY, -30)
			player:BoostAttribute("Hunger", ATB_DEXTERITY, -30)
			player:BoostAttribute("Hunger", ATB_MEDICAL, -30)
		else
			player:BoostAttribute("Hunger", ATB_ACROBATICS, false)
			player:BoostAttribute("Hunger", ATB_ENDURANCE, false)
			player:BoostAttribute("Hunger", ATB_STRENGTH, false)
			player:BoostAttribute("Hunger", ATB_AGILITY, false)
			player:BoostAttribute("Hunger", ATB_DEXTERITY, false)
			player:BoostAttribute("Hunger", ATB_MEDICAL, false)
		end
	end
end

-- Called at an interval while a player is connected.
function PLUGIN:PlayerThink(player, curTime, infoTable)
	local curTime = CurTime()

	if player:Alive() then
		if tonumber(player:GetCharacterData("sleep")) >= 99 then
			if not player:IsRagdolled() and not player:IsNoClipping() then
				if not player.nextSleepKO or curTime >= player.nextSleepKO then
					Clockwork.player:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, math.random(5, 10))
					Clockwork.chatBox:Add(player, nil, "sleep", "*** Your lack of sleep catches up to you, and you can no longer keep your eyes open.")
					player.nextSleepKO = curTime + 30
				end
			end
		end

		if not player.nextHunger or curTime >= player.nextHunger then
			if tonumber(player:GetCharacterData("hunger")) ~= -1 then
				player:SetCharacterData("hunger", math.Clamp(player:GetCharacterData("hunger") + 1, 0, 100))
				player.nextHunger = curTime + 250

				if player:GetCharacterData("hunger") == 30 then
					Clockwork.chatBox:Add(player, nil, "hunger", "*** " .. player:Name() .. " thinks: \"I may go for something to eat...\"")
				elseif player:GetCharacterData("hunger") == 50 then
					Clockwork.chatBox:Add(player, nil, "hunger", "*** " .. player:Name() .. " thinks: \"I'm hungry...\"")
				elseif player:GetCharacterData("hunger") == 70 then
					Clockwork.chatBox:Add(player, nil, "hunger", "*** " .. player:Name() .. " thinks: \"I need to eat something, right now...\"")
				elseif player:GetCharacterData("hunger") == 90 then
					Clockwork.chatBox:Add(player, nil, "hunger", "*** " .. player:Name() .. " thinks: \"God, I'm starving...\"")
				end
			end
		end

		if not player.nextThirst or curTime >= player.nextThirst then
			if tonumber(player:GetCharacterData("thirst")) ~= -1 then
				player:SetCharacterData("thirst", math.Clamp(player:GetCharacterData("thirst") + 1, 0, 100))
				player.nextThirst = curTime + 220

				if player:GetCharacterData("thirst") == 30 then
					Clockwork.chatBox:Add(player, nil, "thirst", "*** " .. player:Name() .. " thinks: \"I may go for something to drink...\"")
				elseif player:GetCharacterData("thirst") == 50 then
					Clockwork.chatBox:Add(player, nil, "thirst", "*** " .. player:Name() .. " thinks: \"My mouth's a little dry, I should drink something.\"")
				elseif player:GetCharacterData("thirst") == 70 then
					Clockwork.chatBox:Add(player, nil, "thirst", "*** " .. player:Name() .. " thinks: \"I need to drink something, right now...\"")
				elseif player:GetCharacterData("thirst") == 90 then
					Clockwork.chatBox:Add(player, nil, "thirst", "*** " .. player:Name() .. " thinks: \"I'm feeling dizzy, I need to drink.\"")
				end
			end
		end

		if not player.nextSleep or curTime >= player.nextSleep then
			if tonumber(player:GetCharacterData("sleep")) ~= -1 then
				player:SetCharacterData("sleep", math.Clamp(player:GetCharacterData("sleep") + 1, 0, 100))
				player.nextSleep = curTime + 411

				if player:GetCharacterData("sleep") == 70 then
					Clockwork.chatBox:Add(player, nil, "sleep", "*** " .. player:Name() .. " thinks: \"I'm exhausted... I need to sleep...\"")
				end
			end
		end
	end
end

function PLUGIN:PlayerShouldStaminaRegenerate(player)
	if tonumber(player:GetCharacterData("hunger")) >= 70 then return false end
end

-- Called when a player uses an item.
function PLUGIN:PlayerUseItem(player, itemTable, itemEntity)
	if itemTable.hunger then
		player:SetCharacterData("hunger", math.Clamp(player:GetCharacterData("hunger") - itemTable.hunger, 0, 100))
	end

	if itemTable.thirst then
		player:SetCharacterData("thirst", math.Clamp(player:GetCharacterData("thirst") - itemTable.thirst, 0, 100))
	end

	if itemTable.sleep then
		player:SetCharacterData("sleep", math.Clamp(player:GetCharacterData("sleep") - itemTable.sleep, 0, 100))
	end
end
