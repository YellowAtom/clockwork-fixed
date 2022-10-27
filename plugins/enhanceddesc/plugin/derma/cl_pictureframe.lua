local PLUGIN = PLUGIN;

local PANEL = {};

-- Called when the panel is initialized.
function PANEL:Init()	
	self:SetTitle("Character Picture")
	self:SetDraggable( true )
	self:SetSize(1000, 800);
	-- Called when the button is clicked.
	function self.btnClose.DoClick(button)
		self:Close(); self:Remove();
	end;	
	
	self.panelList = vgui.Create("DPanelList", self);
 	self.panelList:SetPadding(2);
 	self.panelList:SetSpacing(3);
 	self.panelList:SizeToContents();
	self.panelList:EnableVerticalScrollbar();
end;

-- A function to populate the panel.
function PANEL:Populate(link)
	self.panelList:Clear();

	self.htmlPanel = vgui.Create("HTML");
	self.htmlPanel:SetHTML([[
		<img src = "]]..tostring(link)..[[" alt = "[Character Picture]."/>
	]]);
	self.htmlPanel:SetSize(1000, 725)
	self.htmlPanel:SetWrap(true);
	
	self.button = vgui.Create("DButton");
	self.button:SetText("Open the picture in the Steam Overlay browser.");
	
	-- Called when the button is clicked.
	function self.button.DoClick()
		gui.OpenURL(tostring(link))
	end;
	
	
	self.panelList:AddItem(self.htmlPanel);
	self.panelList:AddItem(self.button);
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout()
	self.panelList:StretchToParent(4, 28, 4, 4);
	DFrame.PerformLayout(self);
end;

vgui.Register("cwPictureDesc", PANEL, "DFrame");