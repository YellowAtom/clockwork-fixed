
Clockwork.datastream:Hook("SurfaceTexts", function(data)
	cwSurfaceTexts.storedList = data
end)

Clockwork.datastream:Hook("SurfaceTextAdd", function(data)
	cwSurfaceTexts.storedList[#cwSurfaceTexts.storedList + 1] = data
end)

Clockwork.datastream:Hook("SurfaceTextRemove", function(data)
	for k, v in pairs(cwSurfaceTexts.storedList) do
		if v.position == data then
			cwSurfaceTexts.storedList[k] = nil
		end
	end
end)

Clockwork.datastream:Hook("TextRemoveSelection", function(nearbyTexts)
	cwSurfaceTexts:ShowTextSelection(nearbyTexts)
end)

-- A function to show the text selection panel.
function cwSurfaceTexts:ShowTextSelection(nearbyTexts)
	local frame = vgui.Create("DFrame")
	frame:SetTitle("Select Texts to Remove")
	frame:SetSize(400, 300)
	frame:Center()
	frame:MakePopup()

	local scrollPanel = vgui.Create("DScrollPanel", frame)
	scrollPanel:Dock(FILL)

	local list = vgui.Create("DListLayout", scrollPanel)
	list:Dock(FILL)

	local checkBoxes = {}

	for k, text in pairs(nearbyTexts) do
		local panel = vgui.Create("DPanel", list)
		panel:Dock(TOP)
		panel:DockMargin(5, 5, 5, 0)
		panel:DockPadding(10, 10, 10, 10)
		panel:SetTall(80)

		local checkBox = vgui.Create("DCheckBox", panel)
		checkBox:SetSize(16, 16)
		checkBox:SetPos(10, 32)
		checkBoxes[k] = checkBox

		local infoPanel = vgui.Create("DPanel", panel)
		infoPanel:Dock(FILL)
		infoPanel:DockMargin(30, 0, 0, 0)

		local textLabel = vgui.Create("DLabel", infoPanel)
		textLabel:Dock(TOP)
		textLabel:DockMargin(0, 5, 0, 5)
		textLabel:SetText("Text: " .. string.Left(text.text, 40) .. (string.len(text.text) > 40 and "..." or ""))
		textLabel:SetAutoStretchVertical(false)

		local scaleLabel = vgui.Create("DLabel", infoPanel)
		scaleLabel:Dock(TOP)
		scaleLabel:DockMargin(0, 0, 0, 5)
		scaleLabel:SetText("Scale: " .. string.format("%.2f", text.scale))
		scaleLabel:SetAutoStretchVertical(false)

		local posLabel = vgui.Create("DLabel", infoPanel)
		posLabel:Dock(TOP)
		posLabel:DockMargin(0, 0, 0, 5)
		posLabel:SetText("Position: " .. string.format("X:%.1f Y:%.1f Z:%.1f", text.position.x, text.position.y, text.position.z))
		posLabel:SetAutoStretchVertical(false)
	end

	local buttonPanel = vgui.Create("DPanel", frame)
	buttonPanel:Dock(BOTTOM)
	buttonPanel:DockMargin(5, 5, 5, 5)
	buttonPanel:DockPadding(5, 5, 5, 5)
	buttonPanel:SetTall(35)

	local removeButton = vgui.Create("DButton", buttonPanel)
	removeButton:Dock(RIGHT)
	removeButton:DockMargin(5, 0, 0, 0)
	removeButton:SetWide(130)
	removeButton:SetText("Remove Selected")
	removeButton:SetEnabled(false)

	local cancelButton = vgui.Create("DButton", buttonPanel)
	cancelButton:Dock(RIGHT)
	cancelButton:DockMargin(5, 0, 0, 0)
	cancelButton:SetWide(80)
	cancelButton:SetText("Cancel")

	local function UpdateButtonState()
		local hasSelection = false
		for k, checkBox in pairs(checkBoxes) do
			if checkBox:GetChecked() then
				hasSelection = true
				break
			end
		end
		removeButton:SetEnabled(hasSelection)
	end

	cancelButton.DoClick = function()
		frame:Close()
	end

	removeButton.DoClick = function()
		local selectedTexts = {}

		for k, checkBox in pairs(checkBoxes) do
			if checkBox:GetChecked() then
				table.insert(selectedTexts, nearbyTexts[k].index)
			end
		end

		if #selectedTexts > 0 then
			Clockwork.datastream:Start("TextRemoveSelected", selectedTexts)
			frame:Close()
		end
	end

	for k, checkBox in pairs(checkBoxes) do
		checkBox.OnChange = function()
			UpdateButtonState()
		end
	end
end
