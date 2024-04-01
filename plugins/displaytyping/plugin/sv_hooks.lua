
-- Called when a player's typing display has started.
function cwDisplayTyping:PlayerStartTypingDisplay(player, code)
	if not player:IsNoClipping() then
		if code == "n" or code == "y" or code == "w" or code == "r" or code == "t" then
			if not player.typingBeep or player.typingCode ~= code then
				local rank = player:GetFactionRank()
				local faction = Clockwork.faction:FindByID(player:GetFaction())
				local startChatNoise

				if (code == "r") then
					if (rank and rank.radioStartChatNoise and player:HasItemByID("handheld_radio")) then
						startChatNoise = rank.radioStartChatNoise;
					elseif (faction and faction.radioStartChatNoise and player:HasItemByID("handheld_radio")) then
						startChatNoise = faction.radioStartChatNoise;
					end;
				elseif (code == "t") then
					if (rank and rank.radioStartChatNoise and player:HasItemByID("walkie_talkie")) then
						startChatNoise = rank.radioStartChatNoise;
					elseif (faction and faction.radioStartChatNoise and player:HasItemByID("walkie_talkie")) then
						startChatNoise = faction.radioStartChatNoise;
					end;
					else
					if rank and rank.startChatNoise then
						startChatNoise = rank.startChatNoise
					elseif faction and faction.startChatNoise then
						startChatNoise = faction.startChatNoise
					elseif faction and faction.startUniformNoise and player:IsWearingClothes() then
						startChatNoise = faction.startUniformNoise
					end
				end

				player.typingCode = code
				player.typingBeep = true

				if startChatNoise then
					player:EmitSound(startChatNoise)
				end
			end
		end
	end
end

-- Called when a player's typing display has finished.
function cwDisplayTyping:PlayerFinishTypingDisplay(player, textTyped)
	if textTyped then
		if player.typingBeep then
			local _, rank = player:GetFactionRank()
			local faction = Clockwork.faction:FindByID(player:GetFaction())

			if rank and rank.endChatNoise then
				player:EmitSound(rank.endChatNoise)
			elseif faction and faction.endChatNoise then
				player:EmitSound(faction.endChatNoise)
			elseif faction and faction.endUniformNoise and player:IsWearingClothes() then
				player:EmitSound(faction.endUniformNoise)
			end
		end
	end

	player.typingCode = nil
	player.typingBeep = nil
end
