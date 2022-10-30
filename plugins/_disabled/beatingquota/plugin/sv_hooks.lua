local PLUGIN = PLUGIN

function PLUGIN:PlayerCharacterLoaded(player)
	if player:GetFaction() == FACTION_MPF then
		if player:GetCharacterData("quota") == nil then
			player:SetCharacterData("quota", 99)
			print(player:Name() .. " has no quota data, setting quota data for them.")
		end

		if player:GetCharacterData("quotamax") == nil then
			player:SetCharacterData("quotamax", 99)
			print(player:Name() .. " has no (MAX) quota data, setting (MAX) quota data for them.")
		end
	end
end

function PLUGIN:PlayerTakeDamage(player, inflictor, attacker, hitGroup, damageInfo)
	if not attacker:IsPlayer() then return end
	local quotaamount = attacker:GetCharacterData("quota")
	local quotamax = attacker:GetCharacterData("quotamax")

	if attacker:GetFaction() == FACTION_MPF then
		if quotaamount == nil then return end
		if quotamax == nil then return end
		if quotaamount == 99 then return end
		if quotamax == 99 then return end

		--we use 99 as a copout, because we use the nil check for easy mode fixes.
		--i'm also just a bad coder
		if not Schema:IsCombineFaction(player:GetFaction()) then
			if quotaamount < quotamax then
				if attacker:GetActiveWeapon():GetClass() == "cw_hands" or attacker:GetActiveWeapon():GetClass() == "cw_stunstick" then
					attacker:SetCharacterData("quota", quotaamount + 1)
					attacker:Notify("You have gained a point on your Beating Quota, you are now at (" .. attacker:GetCharacterData("quota") .. "/" .. quotamax .. ")")
					--We query Quota Data again, as opposed to using "quotaamount" because the tick does not update fast enough for the print, resulting in the first hit showing at 0/3
				end
			end
		end
	end
end

function PLUGIN:Tick()
	--[[set quota data for all players, not to clutter your sql but to make sure everything is a ok in the future.]]
	for k, v in pairs(player.GetAll()) do
		local quotaamount = v:GetCharacterData("quota")
		local quotamax = v:GetCharacterData("quotamax")

		if quotaamount ~= nil and quotamax ~= nil and quotaamount >= quotamax and quotamax ~= 99 and quotaamount ~= 99 then
			v:Notify("Nice! You have met your beating quota. You will be assigned a new one in 20 minutes.")
			Clockwork.player:GiveCash(v, v:GetCharacterData("quotamax") * 3, "Successfully met Beating Quota.")
			v:SetCharacterData("quota", 99)
			v:SetCharacterData("quotamax", 99)
		--	surface.PlaySound("npc/overwatch/radiovoice/rewardnotice.wav")
		end
	end

	if not timer.Exists("ResetTimer") then
		timer.Create("ResetTimer", 600, 0, ResetQuotas)
	end
end

function ResetQuotas()
	local mpfguys = Clockwork.faction:GetPlayers(FACTION_MPF)
	local randomguy = table.Random(mpfguys)
	if #mpfguys < 3 then return end

	if randomguy:IsValid() then
	--	print(randomguy .. " selected.")

		if randomguy:GetCharacterData("quota") == 99 then
			randomguy:SetCharacterData("quotamax", math.random(1, 9))
			randomguy:SetCharacterData("quota", 0)
			randomguy:Notify("You've received a new beating quota, your new quota is (" .. randomguy:GetCharacterData("quota") .. "/" .. randomguy:GetCharacterData("quotamax") .. ").")
		--	surface.PlaySound("npc/overwatch/radiovoice/preparetoreceiveverdict.wav")
		elseif randomguy:GetCharacterData("quota") ~= 99 then
			randomguy:Notify("You've failed to fulfill your quota, as a result lost currency, and your quota has been suspended and given to someone else.")
			randomguy:SetCharacterData("quota", 99)
			Clockwork.player:GiveCash(randomguy, -randomguy:GetCharacterData("quotamax") * 3 / 2, "Failure to meet Beating Quota.")
			randomguy:SetCharacterData("quotamax", 99)
			--surface.PlaySound("npc/overwatch/radiovoice/violationofcivictrust.wav")
		end
	end
end