
Clockwork.datastream:Hook("DynamicAdverts", function(data)
	for k, v in pairs(data) do
		cwDynamicAdverts:CreateHTMLPanel(v)
	end

	cwDynamicAdverts.storedList = data
end)

Clockwork.datastream:Hook("DynamicAdvertAdd", function(data)
	cwDynamicAdverts.storedList[#cwDynamicAdverts.storedList + 1] = data
	cwDynamicAdverts:CreateHTMLPanel(data)
end)

Clockwork.datastream:Hook("DynamicAdvertRemove", function(data)
	for k, v in pairs(cwDynamicAdverts.storedList) do
		if v.position == data then
			cwDynamicAdverts.storedList[k] = nil

			if IsValid(v.panel) then
				v.panel:Remove()
			end
		end
	end
end)

Clockwork.datastream:Hook("AdvertRemoveSelection", function(nearbyAdverts)
	cwDynamicAdverts:ShowAdvertSelection(nearbyAdverts)
end)

-- A function to show the advert selection panel.
function cwDynamicAdverts:ShowAdvertSelection(nearbyAdverts)
	local frame = vgui.Create("DFrame")
	frame:SetTitle("Select Adverts to Remove")
	frame:SetSize(400, 300)
	frame:Center()
	frame:MakePopup()

	local scrollPanel = vgui.Create("DScrollPanel", frame)
	scrollPanel:Dock(FILL)

	local list = vgui.Create("DListLayout", scrollPanel)
	list:Dock(FILL)

	local checkBoxes = {}

	for k, advert in pairs(nearbyAdverts) do
		local panel = vgui.Create("DPanel", list)
		panel:Dock(TOP)
		panel:DockMargin(5, 5, 5, 0)
		panel:DockPadding(10, 10, 10, 10)
		panel:SetTall(80)

		local checkBox = vgui.Create("DCheckBox", panel)
		checkBox:Dock(LEFT)
		checkBox:DockMargin(0, 25, 10, 0)
		checkBoxes[k] = checkBox

		local imagePanel = vgui.Create("DPanel", panel)
		imagePanel:Dock(LEFT)
		imagePanel:DockMargin(0, 5, 10, 5)
		imagePanel:SetWide(60)
		imagePanel:SetTall(60)

		local html = vgui.Create("HTML", imagePanel)
		html:Dock(FILL)
		html:SetHTML([[
			<head>
				<style type="text/css">
					body, html {
						margin: 0;
						padding: 0;
						width: 100%;
						height: 100%;
						overflow: hidden;
					}
					img {
						width: 100%;
						height: 100%;
						object-fit: contain;
					}
				</style>
			</head>
			<body>
				<img src="]] .. advert.url .. [["/>
			</body>
		]])

		local infoPanel = vgui.Create("DPanel", panel)
		infoPanel:Dock(FILL)

		local urlLabel = vgui.Create("DLabel", infoPanel)
		urlLabel:Dock(TOP)
		urlLabel:DockMargin(0, 5, 0, 5)
		urlLabel:SetText("URL: " .. string.Left(advert.url, 30) .. (string.len(advert.url) > 30 and "..." or ""))
		urlLabel:SetAutoStretchVertical(false)

		local sizeLabel = vgui.Create("DLabel", infoPanel)
		sizeLabel:Dock(TOP)
		sizeLabel:DockMargin(0, 0, 0, 5)
		sizeLabel:SetText("Size: " .. advert.width .. "x" .. advert.height .. " (Scale: " .. string.format("%.2f", advert.scale) .. ")")
		sizeLabel:SetAutoStretchVertical(false)

		local posLabel = vgui.Create("DLabel", infoPanel)
		posLabel:Dock(TOP)
		posLabel:DockMargin(0, 0, 0, 5)
		posLabel:SetText("Position: " .. string.format("X:%.1f Y:%.1f Z:%.1f", advert.position.x, advert.position.y, advert.position.z))
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
	removeButton:SetWide(80)
	removeButton:SetText("Remove Selected")
	removeButton:SetEnabled(false) -- Initially disabled

	local cancelButton = vgui.Create("DButton", buttonPanel)
	cancelButton:Dock(RIGHT)
	cancelButton:DockMargin(5, 0, 0, 0)
	cancelButton:SetWide(80)
	cancelButton:SetText("Cancel")

	-- Function to update button state based on checkbox selection
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
		local selectedAdverts = {}

		for k, checkBox in pairs(checkBoxes) do
			if checkBox:GetChecked() then
				table.insert(selectedAdverts, nearbyAdverts[k].index)
			end
		end

		if #selectedAdverts > 0 then
			Clockwork.datastream:Start("AdvertRemoveSelected", selectedAdverts)
			frame:Close()
		end
	end

	-- Update button state when checkboxes are clicked
	for k, checkBox in pairs(checkBoxes) do
		checkBox.OnChange = function()
			UpdateButtonState()
		end
	end
end

-- A function to create a HTML panel.
function cwDynamicAdverts:CreateHTMLPanel(dynamicAdvert)
	dynamicAdvert.panel = vgui.Create("HTML")
	dynamicAdvert.panel:SetPaintedManually(true)
	dynamicAdvert.panel:SetSize(dynamicAdvert.width, dynamicAdvert.height)
	dynamicAdvert.panel:SetPos(0, 0)
	dynamicAdvert.panel:SetHTML([[
		<head>
			<style type="text/css">
				body, html {
					vertical-align: 50%;
					overflow: hidden;
					text-align: center;
					padding: 0;
					margin: 0;
					height: 100%;
				}
				img {
					position: relative;
					margin-top: -]] .. dynamicAdvert.height / 2 .. [[px;
					heigth: ]] .. dynamicAdvert.height .. [[;
					width: ]] .. dynamicAdvert.width .. [[;
					top: 50%;
				}
			</style>
		</head>
		<body scroll="no" scrolling="no">
			<img src="]] .. dynamicAdvert.url .. [["/>
		</body>
	]])
end
