
local Color = Color
local vgui = vgui

local PANEL = {}

-- Called when the panel is initialized.
function PANEL:Init()
	self.backgroundColor = Color(255, 255, 255, 255)
end

-- A function to set the background color.
function PANEL:SetBackgroundColor(color)
	self.backgroundColor = color
end

function PANEL:HideBackground()
	self.backgroundHidden = true
end

function PANEL:SetSpacing(spacing)
	self.defaultSpacing = spacing
end

function PANEL:EnableVerticalScrollbar()
end

function PANEL:AddItem(item, bottomMargin)
	local padding = self:GetPadding()
	bottomMargin = bottomMargin or self.defaultSpacing or 8

	item:Dock(TOP)
	item:DockMargin(padding, padding, padding, bottomMargin)

	DCategoryList.AddItem(self, item)

	self:InvalidateLayout(true)
end

-- Called when the panel should be painted.
function PANEL:Paint(width, height)
	if not self.backgroundHidden then
		PANEL_LIST_SLICED:Draw(0, 0, width, height, 8, self.backgroundColor)
	end

	return true
end

vgui.Register("cwPanelList", PANEL, "DCategoryList")
