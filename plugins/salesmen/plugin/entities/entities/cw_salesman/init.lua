
Clockwork.kernel:IncludePrefixed("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

-- Called when the entity initializes.
function ENT:Initialize()
	self:DrawShadow(true)
	self:SetSolid(SOLID_BBOX)
	self:PhysicsInit(SOLID_BBOX)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetUseType(SIMPLE_USE)
end

-- A function to setup the salesman.
function ENT:SetupSalesman(name, physDesc, animation, bShowChatBubble)
	self:SetNWString("Name", name)
	self:SetNWString("PhysDesc", physDesc)
	self:SetupAnimation(animation)

	if bShowChatBubble then
		self:MakeChatBubble()
	end
end

-- A function to talk to a player.
function ENT:TalkToPlayer(player, text, default)
	-- Handle both single string and array of dialogue options
	local dialogueText
	local dialogueSound = ""
	local hideName = false

	-- Check if text is an array of dialogue options
	if istable(text) and #text > 0 then
		-- Multiple dialogue options available - pick one randomly only if more than one option
		local selectedDialogue
		if #text == 1 then
			-- Only one option - use it deterministically
			selectedDialogue = text[1]
		else
			-- Multiple options - pick one randomly
			local randomIndex = math.random(1, #text)
			selectedDialogue = text[randomIndex]
		end

		-- Handle backward compatibility: if it's still a single object, use it
		if selectedDialogue.text then
			dialogueText = selectedDialogue.text
			dialogueSound = selectedDialogue.sound or ""
			hideName = selectedDialogue.bHideName or false
		else
			-- Legacy format: just a string
			dialogueText = selectedDialogue
		end
	else
		-- Handle empty table, single dialogue object, or string
		if istable(text) then
			if #text == 0 then
				-- Empty table - use default (but apply name replacement to default too)
				dialogueText = default or "Hello there!"
			elseif text.text then
				-- Single dialogue object
				dialogueText = text.text
				dialogueSound = text.sound or ""
				hideName = text.bHideName or false
			else
				-- Fallback for unexpected table format
				dialogueText = default or "Hello there!"
			end
		else
			-- String or nil - use as-is or default
			dialogueText = text or default or "Hello there!"
		end
	end

	local sayString = dialogueText

	-- Replace name placeholders with actual player names
	if string.find(dialogueText, "%%firstname%%") or string.find(dialogueText, "%%lastname%%") then
		local firstName = ""
		local lastName = ""

		-- Try to get character name data - debug what fields are available
		if player.GetCharacterData then
			local characterData = player:GetCharacterData()
			if characterData then
				-- Try common Clockwork name field variations
				firstName = characterData("firstname") or characterData("forename") or ""
				lastName = characterData("surname") or characterData("lastname") or characterData("name") or ""

				-- Debug output to see what we get
				print("Character data - FirstName:", firstName, "LastName:", lastName)
			end
		end

		-- If we didn't get proper names from character data, parse player name
		if firstName == "" then
			local fullName = player:Name()
			if fullName and fullName ~= "" then
				local nameParts = string.Explode(" ", fullName)
				firstName = nameParts[1] or fullName

				-- Only set lastName if we have multiple parts AND it's not a single word name
				if #nameParts > 1 then
					-- Check if this looks like a Combine/Citizen ID format
					local secondPart = nameParts[2]
					if secondPart and (string.len(secondPart) <= 3 or string.match(secondPart, "^%d+$")) then
						-- Likely a Combine/Citizen ID, don't treat as last name
						lastName = ""
					else
						-- Multiple word name, treat as first + last
						lastName = table.concat(nameParts, " ", 2) or ""
					end
				else
					lastName = ""
				end
			end
		end

		-- Fallback if we still don't have a first name
		if firstName == "" then
			firstName = "Player"
		end

		-- Debug output
		print("Final names - FirstName:", firstName, "LastName:", lastName)

		-- Replace placeholders
		dialogueText = string.gsub(dialogueText, "%%firstname%%", firstName)

		-- For lastname, only replace if we actually have a last name
		if lastName ~= "" then
			dialogueText = string.gsub(dialogueText, "%%lastname%%", lastName)
		else
			-- Remove lastname placeholder if no last name available
			dialogueText = string.gsub(dialogueText, "%%lastname%%", "")
		end
	end

	if not hideName then
		-- Ensure dialogueText is a string before concatenation
		local textToDisplay = dialogueText
		if type(textToDisplay) ~= "string" then
			textToDisplay = tostring(textToDisplay) or "Hello there!"
		end
		sayString = self:GetNWString("Name") .. " says \"" .. textToDisplay .. "\""
	else
		-- For dialogues that hide the name, just use the text directly
		local textToDisplay = dialogueText
		if type(textToDisplay) ~= "string" then
			textToDisplay = tostring(textToDisplay) or "Hello there!"
		end
		sayString = textToDisplay
	end

	Clockwork.player:Notify(player, sayString)

	if dialogueSound and dialogueSound ~= "" then
		Clockwork.datastream:Start(player, "SalesmanPlaySound", {dialogueSound, self})
	end
end

-- Called to setup the animation.
function ENT:SetupAnimation(animation)
	if animation and animation ~= -1 then
		self:ResetSequence(animation)
	else
		self:ResetSequence(4)
	end
end

-- Called to make the chat bubble.
function ENT:MakeChatBubble()
	self.cwChatBubble = ents.Create("cw_chatbubble")
	self.cwChatBubble:SetParent(self)
	self.cwChatBubble:SetPos(self:GetPos() + Vector(0, 0, 90))
	self.cwChatBubble:SetNWEntity("salesman", self)
	self.cwChatBubble:Spawn()
end

-- A function to get the chat bubble.
function ENT:GetChatBubble()
	return self.cwChatBubble
end

-- Called when the entity is used.
function ENT:Use(activator, caller)
	if IsValid(activator) and activator:IsPlayer() then
		if activator:GetEyeTraceNoCursor().HitPos:Distance(self:GetPos()) < 196 then
			if Clockwork.plugin:Call("PlayerCanUseSalesman", activator, self) ~= false then
				Clockwork.plugin:Call("PlayerUseSalesman", activator, self)
			end
		end
	end
end
