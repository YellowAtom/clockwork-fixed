
local cwDisplayTyping = cwDisplayTyping
local playerGetAll = _player.GetAll
local cwConfig = Clockwork.config
local cwOption = Clockwork.option
local cwKernel = Clockwork.kernel
local cwPlugin = Clockwork.plugin
local string = string
local pairs = pairs
local typingDots = ""

function cwDisplayTyping:Think()
	local curTime = CurTime()

	if not self.nextTypingDot or self.nextTypingDot <= curTime then
		self.nextTypingDot = curTime + 0.75

		if typingDots ~= "..." then
			typingDots = typingDots .. "."
		else
			typingDots = ""
		end
	end
end

-- Called to draw the text over each player's head if needed.
function cwDisplayTyping:PostDrawTranslucentRenderables()
	local client = LocalPlayer()

	for k, player in pairs(playerGetAll()) do
		if player:HasInitialized() and !(player == client and !client:GetThirdPerson()) then
			local large3D2DFont = cwOption:GetFont("large_3d_2d")
			local colorWhite = cwOption:GetColor("white")
			local eyeAngles = Clockwork.Client:EyeAngles()
			local typing = player:GetSharedVar("Typing")
			local plyPos = player:GetPos()
			local clientPos = Clockwork.Client:GetPos()

			if (isvector(plyPos) and isvector(clientPos)) then
				if typing ~= 0 and player:GetMoveType() ~= MOVETYPE_NOCLIP and player:Alive() then
					local fadeDistance

					-- Seems like sometimes cwConfig:Get("talk_radius"):Get() is being returned as nil?

					if typing == TYPING_YELL or typing == TYPING_PERFORM then
						fadeDistance = cwConfig:Get("talk_radius"):Get()

						if (fadeDistance) then
							fadeDistance = fadeDistance * 2
						else
							fadeDistance = 192 * 2
						end
					elseif typing == TYPING_WHISPER then
						fadeDistance = cwConfig:Get("talk_radius"):Get()

						if (fadeDistance) then
							fadeDistance = fadeDistance / 3

							if fadeDistance > 80 then
								fadeDistance = 80
							end
						else
							fadeDistance = 80
						end
					else
						fadeDistance = cwConfig:Get("talk_radius"):Get() or 192
					end

					if fadeDistance and plyPos:Distance(clientPos) <= fadeDistance then
--						local color, curTime = player:GetColor(), UnPredictedCurTime()

						if player:GetMaterial() ~= "sprites/heatwave" and (a ~= 0 or player:IsRagdolled()) then
							local alpha = cwKernel:CalculateAlphaFromDistance(fadeDistance, Clockwork.Client, player)
							local position = cwPlugin:Call("GetPlayerTypingDisplayPosition", player)
							local headBone = "ValveBiped.Bip01_Head1"

							if string.find(player:GetModel(), "vortigaunt") then
								headBone = "ValveBiped.Head"
							end

							if not position then
								local bonePosition = nil
								local offset = Vector(0, 0, 80)

								if player:IsRagdolled() then
									local entity = player:GetRagdollEntity()

									if IsValid(entity) then
										local physBone = entity:LookupBone(headBone)

										if physBone then
											bonePosition = entity:GetBonePosition(physBone)
										end
									end
								else
									local physBone = player:LookupBone(headBone)

									if physBone then
										bonePosition = player:GetBonePosition(physBone)
									end
								end

								if player:InVehicle() then
									offset = Vector(0, 0, 132)
								elseif player:IsRagdolled() then
									offset = Vector(0, 0, 20)
								elseif player:Crouching() then
									offset = Vector(0, 0, 68)
								end

								if bonePosition then
									position = bonePosition + Vector(0, 0, 20)
								else
									position = player:GetPos() + offset
								end
							end

							if position then
								local drawText = ""
								position = position + eyeAngles:Up()
								eyeAngles:RotateAroundAxis(eyeAngles:Forward(), 90)
								eyeAngles:RotateAroundAxis(eyeAngles:Right(), 90)

								if typing == TYPING_TRANSMIT then
									drawText = "Transmitting"
								elseif typing == TYPING_WHISPER then
									drawText = "Whispering"
								elseif typing == TYPING_PERFORM then
									drawText = "Performing"
								elseif typing == TYPING_NORMAL then
									drawText = "Talking"
								elseif typing == TYPING_RADIO then
									drawText = "Radioing"
								elseif typing == TYPING_YELL then
									drawText = "Yelling"
								elseif typing == TYPING_OOC then
									drawText = "Typing"
								end

								if drawText ~= "" then
									local textWidth, textHeight = cwKernel:GetCachedTextSize(cwOption:GetFont("main_text"), drawText)
									local x = cwKernel:GetCachedTextSize(large3D2DFont, drawText)

									if textWidth and textHeight then
										cam.Start3D2D(position, Angle(0, eyeAngles.y, 90), 0.04)
										cwKernel:OverrideMainFont(large3D2DFont)
										cwKernel:DrawInfo(drawText .. typingDots, -x / 2, 0, colorWhite, alpha, true, nil, 4)
										cwKernel:OverrideMainFont(false)
										cam.End3D2D()
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

-- Called when the chat box is closed.
function cwDisplayTyping:ChatBoxClosed(textTyped)
	if textTyped then
		RunConsoleCommand("cwTypingFinish", "1")
	else
		RunConsoleCommand("cwTypingFinish")
	end
end

-- Called when the chat box text has changed.
function cwDisplayTyping:ChatBoxTextChanged(previousText, newText)
	local prefix = cwConfig:Get("command_prefix"):Get()

	if string.utf8sub(newText, 1, string.utf8len(prefix) + 1) == prefix .. "r" then
		if string.utf8sub(previousText, 1, string.utf8len(prefix) + 1) ~= prefix .. "r" then
			RunConsoleCommand("cwTypingStart", "r")
		end
	elseif string.utf8sub(newText, 1, string.utf8len(prefix) + 2) == prefix .. "me" then
		if string.utf8sub(previousText, 1, string.utf8len(prefix) + 2) ~= prefix .. "me" then
			RunConsoleCommand("cwTypingStart", "p")
		end
	elseif string.utf8sub(newText, 1, string.utf8len(prefix) + 5) == prefix .. "trans" then
		if string.utf8sub(previousText, 1, string.utf8len(prefix) + 5) ~= prefix .. "trans" then
			RunConsoleCommand("cwTypingStart", "t")
		end
	elseif string.utf8sub(newText, 1, string.utf8len(prefix) + 2) == prefix .. "pm" then
		if string.utf8sub(previousText, 1, string.utf8len(prefix) + 2) ~= prefix .. "pm" then
			RunConsoleCommand("cwTypingStart", "o")
		end
	elseif string.utf8sub(newText, 1, string.utf8len(prefix) + 1) == prefix .. "w" then
		if string.utf8sub(previousText, 1, string.utf8len(prefix) + 1) ~= prefix .. "w" then
			RunConsoleCommand("cwTypingStart", "w")
		end
	elseif string.utf8sub(newText, 1, string.utf8len(prefix) + 1) == prefix .. "y" then
		if string.utf8sub(previousText, 1, string.utf8len(prefix) + 1) ~= prefix .. "y" then
			RunConsoleCommand("cwTypingStart", "y")
		end
	elseif string.utf8sub(newText, 1, 2) == "//" then
		if string.utf8sub(previousText, 1, 2) ~= prefix .. "//" then
			RunConsoleCommand("cwTypingStart", "o")
		end
	elseif string.utf8sub(newText, 1, 3) == ".//" or string.utf8sub(newText, 1, 2) == "[[" then
		if string.utf8sub(previousText, 1, 3) ~= prefix .. ".//" or string.utf8sub(previousText, 1, 2) ~= prefix .. "[[" then
			RunConsoleCommand("cwTypingStart", "o")
		end
	elseif newText ~= "" and string.utf8len(newText) >= 4 and previousText ~= "" and string.utf8len(previousText) < 4 then
		RunConsoleCommand("cwTypingStart", "n")
	end
end
