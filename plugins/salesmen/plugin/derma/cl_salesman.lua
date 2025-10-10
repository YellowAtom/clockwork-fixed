
local PANEL = {}

-- Called when the panel is initialized.
function PANEL:Init()
	local salesmanName = Clockwork.salesman:GetName()
	self:SetTitle(salesmanName)
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(false)

	-- Called when the button is clicked.
	function self.btnClose.DoClick(button)
		CloseDermaMenus()
		self:Close()
		self:Remove()

		Clockwork.datastream:Start("SalesmanAdd", {
			showChatBubble = Clockwork.salesman.showChatBubble,
			buyInShipments = Clockwork.salesman.buyInShipments,
			priceScale = Clockwork.salesman.priceScale,
			factions = Clockwork.salesman.factions,
			physDesc = Clockwork.salesman.physDesc,
			buyRate = Clockwork.salesman.buyRate,
			classes = Clockwork.salesman.classes,
			stock = Clockwork.salesman.stock,
			model = Clockwork.salesman.model,
			sells = Clockwork.salesman.sells,
			cash = Clockwork.salesman.cash,
			text = Clockwork.salesman.text,
			buys = Clockwork.salesman.buys,
			name = Clockwork.salesman.name
		})

		Clockwork.salesman.priceScale = nil
		Clockwork.salesman.factions = nil
		Clockwork.salesman.classes = nil
		Clockwork.salesman.physDesc = nil
		Clockwork.salesman.buyRate = nil
		Clockwork.salesman.stock = nil
		Clockwork.salesman.model = nil
		Clockwork.salesman.sells = nil
		Clockwork.salesman.buys = nil
		Clockwork.salesman.items = nil
		Clockwork.salesman.text = nil
		Clockwork.salesman.cash = nil
		Clockwork.salesman.name = nil
		gui.EnableScreenClicker(false)
	end

	self.sellsPanel = vgui.Create("cwPanelList")
	self.sellsPanel:SetPadding(2)
	self.sellsPanel:SetSpacing(3)
	self.sellsPanel:SizeToContents()
	self.sellsPanel:EnableVerticalScrollbar()

	self.buysPanel = vgui.Create("cwPanelList")
	self.buysPanel:SetPadding(2)
	self.buysPanel:SetSpacing(3)
	self.buysPanel:SizeToContents()
	self.buysPanel:EnableVerticalScrollbar()

	self.itemsPanel = vgui.Create("cwPanelList")
	self.itemsPanel:SetPadding(2)
	self.itemsPanel:SetSpacing(3)
	self.itemsPanel:SizeToContents()
	self.itemsPanel:EnableVerticalScrollbar()

	self.settingsPanel = vgui.Create("cwPanelList")
	self.settingsPanel:SetPadding(2)
	self.settingsPanel:SetSpacing(3)
	self.settingsPanel:SizeToContents()
	self.settingsPanel:EnableVerticalScrollbar()
	self.settingsForm = vgui.Create("cwForm")
	self.settingsForm:SetPadding(4)
	self.settingsForm:SetName("Settings")
	self.settingsPanel:AddItem(self.settingsForm)

	self.showChatBubble = self.settingsForm:CheckBox("Show chat bubble.")
	self.buyInShipments = self.settingsForm:CheckBox("Buy items in shipments.")
	self.priceScale = self.settingsForm:TextEntry("What amount to scale prices by.")
	self.physDesc = self.settingsForm:TextEntry("The physical description of the salesman.")
	self.buyRate = self.settingsForm:NumSlider("Buy Rate", nil, 1, 100, 0)
	self.stock = self.settingsForm:NumSlider("Default Stock", nil, -1, 100, 0)
	self.model = self.settingsForm:TextEntry("The model of the salesman.")
	self.cash = self.settingsForm:NumSlider("Starting Cash", nil, -1, 1000000, 0)

	self.buyRate:SetTooltip("Percentage of price to keep when selling.")
	self.stock:SetTooltip("The default stock of each item (-1 for infinite stock).")
	self.cash:SetTooltip("Starting cash of the salesman (-1 for infinite cash).")
	self.showChatBubble:SetValue(Clockwork.salesman.showChatBubble == true)
	self.buyInShipments:SetValue(Clockwork.salesman.buyInShipments == true)
	self.priceScale:SetValue(Clockwork.salesman.priceScale)
	self.physDesc:SetValue(Clockwork.salesman.physDesc)
	self.buyRate:SetValue(Clockwork.salesman.buyRate)
	self.stock:SetValue(Clockwork.salesman.stock)
	self.model:SetValue(Clockwork.salesman.model)
	self.cash:SetValue(Clockwork.salesman.cash)
	self.responsesForm = vgui.Create("cwForm")
	self.responsesForm:SetPadding(4)
	self.responsesForm:SetName("Responses")
	self.settingsForm:AddItem(self.responsesForm)

	-- Create dialogue management panels for each response type
	self.dialoguePanels = {}

	-- Helper function to create a dialogue management panel
	local function CreateDialoguePanel(parentForm, label, dialogueType, defaultText)
		local panel = vgui.Create("DPanel", parentForm)
		panel:SetTall(140) -- Increased height to accommodate help text
		panel:Dock(TOP)
		panel:DockMargin(0, 0, 0, 10)

		-- Label
		local labelControl = vgui.Create("DLabel", panel)
		labelControl:SetText(label)
		labelControl:Dock(TOP)
		labelControl:DockMargin(0, 0, 0, 5)

		-- Help text for name placeholders
		local helpLabel = vgui.Create("DLabel", panel)
		helpLabel:SetText("Tip: Use %firstname% in your dialogue to personalize it with the player's name! (%lastname% also works for factions that use last names)")
		helpLabel:Dock(TOP)
		helpLabel:DockMargin(0, 0, 0, 5)
		helpLabel:SetTextColor(Color(100, 100, 255)) -- Light blue color to make it stand out

		-- Dialogue list
		local dialogueList = vgui.Create("DListView", panel)
		dialogueList:Dock(FILL)
		dialogueList:SetMultiSelect(false)
		dialogueList:AddColumn("Text"):SetWidth(220)
		dialogueList:AddColumn("Sound"):SetWidth(140)
		dialogueList:AddColumn("Hide Name"):SetWidth(80)

		-- Controls
		local controlsPanel = vgui.Create("DPanel", panel)
		controlsPanel:Dock(BOTTOM)
		controlsPanel:SetTall(30)

		local addButton = vgui.Create("DButton", controlsPanel)
		addButton:SetText("Add")
		addButton:Dock(LEFT)
		addButton:SetWide(60)

		local removeButton = vgui.Create("DButton", controlsPanel)
		removeButton:SetText("Remove")
		removeButton:Dock(LEFT)
		removeButton:DockMargin(5, 0, 0, 0)
		removeButton:SetWide(60)

		-- Initialize with existing dialogue
		local currentDialogues = Clockwork.salesman.text[dialogueType] or {}

		-- Handle backward compatibility - convert single dialogue to array if needed
		if currentDialogues.text then
			currentDialogues = {currentDialogues}
		end

		if not istable(currentDialogues) then
			currentDialogues = {}
		end

		-- Store reference to the current dialogues array for this panel
		panel.currentDialogues = currentDialogues

		-- Add unique IDs to dialogue entries for better tracking
		for i, dialogue in ipairs(currentDialogues) do
			if not dialogue.uniqueID then
				dialogue.uniqueID = tostring(os.time()) .. "_" .. math.random(1000, 9999) .. "_" .. i
			end
		end

		-- Populate the list with a reasonable limit for performance
		local maxDialogues = 50 -- Limit to prevent performance issues
		local dialoguesToShow = currentDialogues

		if #currentDialogues > maxDialogues then
			dialogueList:AddLine("Warning: Too many dialogues (" .. #currentDialogues .. ")! Showing first " .. maxDialogues .. " only.", "", "")
			dialoguesToShow = {unpack(currentDialogues, 1, maxDialogues)}
		end

		if #dialoguesToShow == 0 then
			-- Show placeholder text when no dialogues are configured
			dialogueList:AddLine(defaultText or "Click 'Add' to create dialogue lines...", "", "")
		else
			for i, dialogue in ipairs(dialoguesToShow) do
				local line = dialogueList:AddLine(
					dialogue.text or dialogue,
					dialogue.sound or "",
					dialogue.bHideName and "Yes" or "No"
				)
				line.uniqueID = dialogue.uniqueID -- Store unique ID on the line for reference
			end
		end

			-- Add button functionality
			addButton.DoClick = function()
				-- Check if we're at the limit
				if #panel.currentDialogues >= 50 then
					Derma_Message("You have reached the maximum limit of 50 dialogues per response type.", "Limit Reached", "OK")
					return
				end

				-- Create a multi-field add dialog
				local addFrame = vgui.Create("DFrame")
				addFrame:SetTitle("Add Dialogue")
				addFrame:SetSize(400, 220)
				addFrame:Center()
				addFrame:MakePopup()

			local textEntry = vgui.Create("DTextEntry", addFrame)
			textEntry:SetPos(80, 40)
			textEntry:SetSize(300, 25)
			textEntry:SetText("")

			local textLabel = vgui.Create("DLabel", addFrame)
			textLabel:SetPos(10, 45)
			textLabel:SetText("Text:")
			textLabel:SizeToContents()

			local soundEntry = vgui.Create("DTextEntry", addFrame)
			soundEntry:SetPos(80, 75)
			soundEntry:SetSize(300, 25)
			soundEntry:SetText("")
			soundEntry:SetPlaceholderText("Optional sound file path...")

			local soundLabel = vgui.Create("DLabel", addFrame)
			soundLabel:SetPos(10, 80)
			soundLabel:SetText("Sound:")
			soundLabel:SizeToContents()

			local hideNameCheck = vgui.Create("DCheckBoxLabel", addFrame)
			hideNameCheck:SetPos(80, 110)
			hideNameCheck:SetText("Hide salesman name")
			hideNameCheck:SetValue(false)
			hideNameCheck:SizeToContents()

			local addButton = vgui.Create("DButton", addFrame)
			addButton:SetPos(100, 160)
			addButton:SetSize(80, 25)
			addButton:SetText("Add")

			local cancelButton = vgui.Create("DButton", addFrame)
			cancelButton:SetPos(200, 160)
			cancelButton:SetSize(80, 25)
			cancelButton:SetText("Cancel")

			-- Add functionality
			addButton.DoClick = function()
				local newText = textEntry:GetValue()
				local newSound = soundEntry:GetValue()
				local hideName = hideNameCheck:GetChecked()

				if newText and newText ~= "" then
					-- If there's a placeholder, remove it safely
					local lines = dialogueList:GetLines()
					if #lines > 0 then
						local firstLine = lines[1]
						local firstLineText = firstLine:GetColumnText(1)
						if firstLineText == (defaultText or "Click 'Add' to create dialogue lines...") then
							dialogueList:RemoveLine(1)
						end
					end

					local newDialogue = {
						text = newText,
						sound = newSound,
						bHideName = hideName,
						uniqueID = tostring(os.time()) .. "_" .. math.random(1000, 9999) .. "_" .. (#panel.currentDialogues + 1)
					}

					-- Add to our data structure
					table.insert(panel.currentDialogues, newDialogue)

					-- Update the list view
					local newLine = dialogueList:AddLine(newText, newSound, hideName and "Yes" or "No")
					newLine.uniqueID = newDialogue.uniqueID -- Store unique ID on the line for reference

					addFrame:Close()
				end
			end

			-- Cancel functionality
			cancelButton.DoClick = function()
				addFrame:Close()
			end
		end

		-- Remove button functionality
		removeButton.DoClick = function()
			local selectedLine = dialogueList:GetSelectedLine()
			if selectedLine then
				local line = dialogueList:GetLine(selectedLine)
				-- Don't allow removing the placeholder
				local lineText = line:GetColumnText(1)
				if lineText == (defaultText or "Click 'Add' to create dialogue lines...") then
					return
				end

				-- Get the unique ID for this line
				local lineUniqueID = line.uniqueID
				if not lineUniqueID then
					-- Fallback to old method if uniqueID is missing
					lineUniqueID = lineText
				end

				-- Find and remove the corresponding dialogue from our data structure
				local dialogueIndex = nil
				for i, dialogue in ipairs(panel.currentDialogues) do
					if (dialogue.uniqueID and dialogue.uniqueID == lineUniqueID) or
					   (not dialogue.uniqueID and (dialogue.text or dialogue) == lineUniqueID) then
						dialogueIndex = i
						break
					end
				end

				-- Remove from UI first
				dialogueList:RemoveLine(selectedLine)

				-- Remove from data structure
				if dialogueIndex then
					table.remove(panel.currentDialogues, dialogueIndex)
				end

				-- If no dialogues left, show placeholder
				if #panel.currentDialogues == 0 then
					dialogueList:Clear()
					dialogueList:AddLine(defaultText or "Click 'Add' to create dialogue lines...", "", "")
				else
					-- Refresh the list if we're still over the limit or need to show the truncated view
					local maxDialogues = 50
					if #panel.currentDialogues > maxDialogues then
						dialogueList:Clear()
						dialogueList:AddLine("Warning: Too many dialogues (" .. #panel.currentDialogues .. ")! Showing first " .. maxDialogues .. " only.", "", "")
						local dialoguesToShow = {unpack(panel.currentDialogues, 1, maxDialogues)}
						for i, dialogue in ipairs(dialoguesToShow) do
							local line = dialogueList:AddLine(
								dialogue.text or dialogue,
								dialogue.sound or "",
								dialogue.bHideName and "Yes" or "No"
							)
							line.uniqueID = dialogue.uniqueID
						end
					end
				end

				-- Clear selection to prevent issues
				dialogueList:ClearSelection()
			end
		end

		-- Edit functionality (double-click to edit)
		dialogueList.DoDoubleClick = function(parent, lineID, line)
			-- Don't allow editing placeholder text
			local lineText = line:GetColumnText(1)
			if lineText == (defaultText or "Click 'Add' to create dialogue lines...") then
				return
			end

			-- Get the unique ID for this line
			local lineUniqueID = line.uniqueID
			if not lineUniqueID then
				-- Fallback to old method if uniqueID is missing
				lineUniqueID = lineText
			end

			-- Find the corresponding dialogue in our data structure using unique ID
			local dialogue = nil
			local dialogueIndex = nil

			for i, dlgData in ipairs(panel.currentDialogues) do
				if (dlgData.uniqueID and dlgData.uniqueID == lineUniqueID) or
				   (not dlgData.uniqueID and (dlgData.text or dlgData) == lineUniqueID) then
					dialogue = dlgData
					dialogueIndex = i
					break
				end
			end

			if dialogue and dialogueIndex then

				-- Create a multi-field edit dialog
				local editFrame = vgui.Create("DFrame")
				editFrame:SetTitle("Edit Dialogue")
				editFrame:SetSize(400, 200)
				editFrame:Center()
				editFrame:MakePopup()

				local textEntry = vgui.Create("DTextEntry", editFrame)
				textEntry:SetPos(80, 40)
				textEntry:SetSize(300, 25)
				textEntry:SetText(dialogue.text or dialogue)

				local textLabel = vgui.Create("DLabel", editFrame)
				textLabel:SetPos(10, 45)
				textLabel:SetText("Text:")
				textLabel:SizeToContents()

				local soundEntry = vgui.Create("DTextEntry", editFrame)
				soundEntry:SetPos(80, 75)
				soundEntry:SetSize(300, 25)
				soundEntry:SetText(dialogue.sound or "")

				local soundLabel = vgui.Create("DLabel", editFrame)
				soundLabel:SetPos(10, 80)
				soundLabel:SetText("Sound:")
				soundLabel:SizeToContents()

				local hideNameCheck = vgui.Create("DCheckBoxLabel", editFrame)
				hideNameCheck:SetPos(80, 110)
				hideNameCheck:SetText("Hide salesman name")
				hideNameCheck:SetValue(dialogue.bHideName or false)
				hideNameCheck:SizeToContents()

				local saveButton = vgui.Create("DButton", editFrame)
				saveButton:SetPos(100, 150)
				saveButton:SetSize(80, 25)
				saveButton:SetText("Save")

				local cancelButton = vgui.Create("DButton", editFrame)
				cancelButton:SetPos(200, 150)
				cancelButton:SetSize(80, 25)
				cancelButton:SetText("Cancel")

				-- Save functionality
				saveButton.DoClick = function()
					local newText = textEntry:GetValue()
					local newSound = soundEntry:GetValue()
					local hideName = hideNameCheck:GetChecked()

					if newText and newText ~= "" then
						-- Update the dialogue in our data structure
						panel.currentDialogues[dialogueIndex] = {
							text = newText,
							sound = newSound,
							bHideName = hideName
						}

						-- Update the list view
						line:SetColumnText(1, newText)
						line:SetColumnText(2, newSound)
						line:SetColumnText(3, hideName and "Yes" or "No")

						editFrame:Close()
					end
				end

				-- Cancel functionality
				cancelButton.DoClick = function()
					editFrame:Close()
				end
			end
		end

		return panel
	end

	-- Create dialogue panels for each response type
	self.startPanel = CreateDialoguePanel(self.responsesForm, "Start Trading Dialogues", "start", "How can I help you today?")
	self.noSalePanel = CreateDialoguePanel(self.responsesForm, "Cannot Trade Dialogues", "noSale", "I cannot trade my inventory with you!")
	self.noStockPanel = CreateDialoguePanel(self.responsesForm, "Out of Stock Dialogues", "noStock", "I do not have that item in stock!")
	self.needMorePanel = CreateDialoguePanel(self.responsesForm, "Cannot Afford Dialogues", "needMore", "You cannot afford to buy that from me!")
	self.cannotAffordPanel = CreateDialoguePanel(self.responsesForm, "Cannot Buy Dialogues", "cannotAfford", "I cannot afford to buy that item from you!")
	self.doneBusinessPanel = CreateDialoguePanel(self.responsesForm, "Business Complete Dialogues", "doneBusiness", "Thanks for doing business, see you soon!")

	self.dialoguePanels = {
		start = self.startPanel,
		noSale = self.noSalePanel,
		noStock = self.noStockPanel,
		needMore = self.needMorePanel,
		cannotAfford = self.cannotAffordPanel,
		doneBusiness = self.doneBusinessPanel
	}

	self.factionsForm = vgui.Create("DForm")
	self.factionsForm:SetPadding(4)
	self.factionsForm:SetName("Factions")
	self.settingsForm:AddItem(self.factionsForm)
	self.factionsForm:Help("Leave these unchecked to allow all factions to buy and sell.")
	self.classesForm = vgui.Create("DForm")
	self.classesForm:SetPadding(4)
	self.classesForm:SetName("Classes")
	self.settingsForm:AddItem(self.classesForm)
	self.classesForm:Help("Leave these unchecked to allow all classes to buy and sell.")
	self.classBoxes = {}
	self.factionBoxes = {}

	for k, v in pairs(Clockwork.faction.stored) do
		self.factionBoxes[k] = self.factionsForm:CheckBox(v.name)

		self.factionBoxes[k].OnChange = function(checkBox)
			if checkBox:GetChecked() then
				Clockwork.salesman.factions[k] = true
			else
				Clockwork.salesman.factions[k] = nil
			end
		end

		if Clockwork.salesman.factions[k] then
			self.factionBoxes[k]:SetValue(true)
		end
	end

	for k, v in pairs(Clockwork.class.stored) do
		self.classBoxes[k] = self.classesForm:CheckBox(v.name)

		self.classBoxes[k].OnChange = function(checkBox)
			if checkBox:GetChecked() then
				Clockwork.salesman.classes[k] = true
			else
				Clockwork.salesman.classes[k] = nil
			end
		end

		if Clockwork.salesman.classes[k] then
			self.classBoxes[k]:SetValue(true)
		end
	end

	self.propertySheet = vgui.Create("DPropertySheet", self)
	self.propertySheet:SetPadding(4)
	self.propertySheet:AddSheet("Sells", self.sellsPanel, "icon16/box.png", nil, nil, "View items that " .. salesmanName .. " sells.")
	self.propertySheet:AddSheet("Buys", self.buysPanel, "icon16/add.png", nil, nil, "View items that " .. salesmanName .. " buys.")
	self.propertySheet:AddSheet("Items", self.itemsPanel, "icon16/application_view_tile.png", nil, nil, "View possible items for trading.")
	self.propertySheet:AddSheet("Settings", self.settingsPanel, "icon16/tick.png", nil, nil, "View possible items for trading.")
	Clockwork.kernel:SetNoticePanel(self)
end

-- A function to rebuild a panel.
function PANEL:RebuildPanel(panelList, typeName, inventory)
	panelList:Clear(true)
	panelList.typeName = typeName
	panelList.inventory = inventory
	local categories = {}
	local items = {}

	for k, v in pairs(panelList.inventory) do
		local itemTable = Clockwork.item:FindByID(k)

		if itemTable then
			local category = itemTable("category")

			if category then
				items[category] = items[category] or {}

				items[category][#items[category] + 1] = {k, v}
			end
		end
	end

	for k, v in pairs(items) do
		categories[#categories + 1] = {
			category = k,
			items = v
		}
	end

	if table.Count(categories) > 0 then
		for k, v in pairs(categories) do
			local collapsibleCategory = Clockwork.kernel:CreateCustomCategoryPanel(v.category, panelList)
			collapsibleCategory:SetCookieName("Salesman" .. typeName .. v.category)
			panelList:AddItem(collapsibleCategory)
			local categoryList = vgui.Create("DPanelList", collapsibleCategory)
			categoryList:EnableHorizontal(true)
			categoryList:SetAutoSize(true)
			categoryList:SetPadding(4)
			categoryList:SetSpacing(4)
			collapsibleCategory:SetContents(categoryList)

			table.sort(v.items, function(a, b)
				local itemTableA = Clockwork.item:FindByID(a[1])
				local itemTableB = Clockwork.item:FindByID(b[1])

				return itemTableA("cost") < itemTableB("cost")
			end)

			for k2, v2 in pairs(v.items) do
				CURRENT_ITEM_DATA = {
					itemTable = Clockwork.item:FindByID(v2[1]),
					typeName = typeName
				}

				categoryList:AddItem(vgui.Create("cwSalesmanItem", categoryList))
			end
		end
	end
end

-- A function to rebuild the panel.
function PANEL:Rebuild()
	self:RebuildPanel(self.sellsPanel, "Sells", Clockwork.salesman:GetSells())
	self:RebuildPanel(self.buysPanel, "Buys", Clockwork.salesman:GetBuys())
	self:RebuildPanel(self.itemsPanel, "Items", Clockwork.salesman:GetItems())
end

-- Called each frame.
function PANEL:Think()
	self:SetSize(ScrW() * 0.5, ScrH() * 0.75)
	self:SetPos(ScrW() / 2 - self:GetWide() / 2, ScrH() / 2 - self:GetTall() / 2)

	-- Update dialogue data structure (no longer need individual text fields)
	-- The dialogue panels handle their own data management

	Clockwork.salesman.showChatBubble = self.showChatBubble:GetChecked() == true
	Clockwork.salesman.buyInShipments = self.buyInShipments:GetChecked() == true
	Clockwork.salesman.physDesc = self.physDesc:GetValue()
	Clockwork.salesman.buyRate = self.buyRate:GetValue()
	Clockwork.salesman.stock = self.stock:GetValue()
	Clockwork.salesman.model = self.model:GetValue()
	Clockwork.salesman.cash = self.cash:GetValue()
	local priceScale = self.priceScale:GetValue()
	Clockwork.salesman.priceScale = tonumber(priceScale) or 1
end

-- Called when the layout should be performed.
function PANEL:PerformLayout(w, h)
	DFrame.PerformLayout(self)

	if self.propertySheet then
		self.propertySheet:StretchToParent(4, 28, 4, 4)
	end
end

vgui.Register("cwSalesman", PANEL, "DFrame")
local PANEL = {}

-- Called when the panel is initialized.
function PANEL:Init()
	local itemData = self:GetParent().itemData or CURRENT_ITEM_DATA
	self:SetSize(40, 40)
	self.itemTable = itemData.itemTable
	self.typeName = itemData.typeName
	self.spawnIcon = Clockwork.kernel:CreateMarkupToolTip(vgui.Create("cwSpawnIcon", self))
	self.spawnIcon:SetColor(self.itemTable("color"))

	-- Called when the spawn icon is clicked.
	function self.spawnIcon.DoClick(spawnIcon)
		if self.typeName == "Items" then
			if self.itemTable("cost") == 0 and Clockwork.config:Get("cash_enabled"):Get() then
				local cashName = Clockwork.option:GetKey("name_cash")

				Clockwork.kernel:AddMenuFromData(nil, {
					["Buys"] = function()
						Derma_StringRequest(cashName, "How much do you want the item to be bought for?", "", function(text)
							Clockwork.salesman.buys[self.itemTable("uniqueID")] = tonumber(text) or true
							Clockwork.salesman:GetPanel():Rebuild()
						end)
					end,
					["Sells"] = function()
						Derma_StringRequest(cashName, "How much do you want the item to sell for?", "", function(text)
							Clockwork.salesman.sells[self.itemTable("uniqueID")] = tonumber(text) or true
							Clockwork.salesman:GetPanel():Rebuild()
						end)
					end,
					["Both"] = function()
						Derma_StringRequest(cashName, "How much do you want the item to sell for?", "", function(sellPrice)
							Derma_StringRequest(cashName, "How much do you want the item to be bought for?", "", function(buyPrice)
								Clockwork.salesman.sells[self.itemTable("uniqueID")] = tonumber(sellPrice) or true
								Clockwork.salesman.buys[self.itemTable("uniqueID")] = tonumber(buyPrice) or true
								Clockwork.salesman:GetPanel():Rebuild()
							end)
						end)
					end
				})
			else
				Clockwork.kernel:AddMenuFromData(nil, {
					["Buys"] = function()
						Clockwork.salesman.buys[self.itemTable("uniqueID")] = true
						Clockwork.salesman:GetPanel():Rebuild()
					end,
					["Sells"] = function()
						Clockwork.salesman.sells[self.itemTable("uniqueID")] = true
						Clockwork.salesman:GetPanel():Rebuild()
					end,
					["Both"] = function()
						Clockwork.salesman.sells[self.itemTable("uniqueID")] = true
						Clockwork.salesman.buys[self.itemTable("uniqueID")] = true
						Clockwork.salesman:GetPanel():Rebuild()
					end
				})
			end
		elseif self.typeName == "Sells" then
			Clockwork.salesman.sells[self.itemTable("uniqueID")] = nil
			Clockwork.salesman:GetPanel():Rebuild()
		elseif self.typeName == "Buys" then
			Clockwork.salesman.buys[self.itemTable("uniqueID")] = nil
			Clockwork.salesman:GetPanel():Rebuild()
		end
	end

	local model, skin = Clockwork.item:GetIconInfo(self.itemTable)
	self.spawnIcon:SetModel(model, skin)
	self.spawnIcon:SetTooltip("")
	self.spawnIcon:SetSize(40, 40)
end

-- Called each frame.
function PANEL:Think()
	local function DisplayCallback(displayInfo)
		local priceScale = 1
		local amount = 0

		if self.typeName == "Sells" then
			if Clockwork.salesman:BuyInShipments() then
				amount = self.itemTable("batch")
			else
				amount = 1
			end

			priceScale = Clockwork.salesman:GetPriceScale()
		elseif self.typeName == "Buys" then
			priceScale = Clockwork.salesman:GetBuyRate() / 100
		end

		if Clockwork.config:Get("cash_enabled"):Get() then
			if self.itemTable("cost") ~= 0 then
				displayInfo.weight = Clockwork.kernel:FormatCash((self.itemTable("cost") * priceScale) * math.max(amount, 1))
			else
				displayInfo.weight = "Free"
			end

			local overrideCash = Clockwork.salesman.sells[self.itemTable("uniqueID")]

			if self.typeName == "Buys" then
				overrideCash = Clockwork.salesman.buys[self.itemTable("uniqueID")]
			end

			if type(overrideCash) == "number" then
				displayInfo.weight = Clockwork.kernel:FormatCash(overrideCash * math.max(amount, 1))
			end
		end

		if self.typeName == "Sells" then
			if amount > 1 then
				displayInfo.name = amount .. " " .. Clockwork.kernel:Pluralize(self.itemTable("name"))
			else
				displayInfo.name = self.itemTable("name")
			end
		end

		if self.typeName == "Sells" and Clockwork.salesman.stock ~= -1 then
			displayInfo.itemTitle = "[" .. Clockwork.salesman.stock .. "] [" .. displayInfo.name .. ", " .. displayInfo.weight .. "]"
		end
	end

	self.spawnIcon:SetMarkupToolTip(Clockwork.item:GetMarkupToolTip(self.itemTable, true, DisplayCallback))
	self.spawnIcon:SetColor(self.itemTable("color"))
end

vgui.Register("cwSalesmanItem", PANEL, "DPanel")
