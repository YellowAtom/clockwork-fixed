
local PANEL = {};

-- Called when the panel is initialized.
function PANEL:Init()
	self:SetBackgroundBlur(true);
	self:SetDeleteOnClose(false);
	
	-- Called when the button is clicked.
	function self.btnClose.DoClick(button)
		self:Close(); self:Remove();
		
		gui.EnableScreenClicker(false);
	end;
	
	self.panelList = vgui.Create("DPanelList", self);
 	self.panelList:SetPadding(2);
 	self.panelList:SetSpacing(3);
 	self.panelList:SizeToContents();
	self.panelList:EnableVerticalScrollbar();
end;

-- Called each frame.
function PANEL:Think()
	local scrW = ScrW();
	local scrH = ScrH();
	
	self:SetSize(400, 400);
	self:SetPos( (scrW / 2) - (self:GetWide() / 2), (scrH / 2) - (self:GetTall() / 2) );
end;

-- A function to populate the panel.
function PANEL:Populate(player, data, link)
	self:SetTitle( player:GetName().."'s Detailed Description"  );
	
	self.panelList:Clear();
	
	local textEntry = vgui.Create("DTextEntry");
	local imageEntry = vgui.Create("DTextEntry");
	local button = vgui.Create("DButton");
	local label = vgui.Create("DLabel");
	local texty = data
	
	label:SetAutoStretchVertical(true);
	label:SetDark(true);
	label:SetWrap(true);
	label:SetText("Enter a link for a reference picture:");
	
	textEntry:SetMultiline(true);
	textEntry:SetHeight(256);
	textEntry:SetText(texty);
	
	imageEntry:SetMultiline(true);
	imageEntry:SetHeight(50);
	imageEntry:SetText(link);

	button:SetText("Set Description");
	
	-- A function to set the text entry's real value.
	function textEntry:SetRealValue(texty)
		self:SetValue(texty);
		self:SetCaretPos(string.len(texty));
	end;
	
	-- Called each frame.
	function textEntry:Think()
		local text = self:GetValue();
		
		if (string.len(text) > 5000) then
			self:SetRealValue( string.sub(text, 0, 5000) );
			
			surface.PlaySound("common/talk.wav");
		end;
	end;
	
	-- Called when the button is clicked.
	function button.DoClick(button)
		self:Close(); self:Remove();
		
		if (IsValid(player)) then			
			local strings = {desc = textEntry:GetValue(), sendlink = imageEntry:GetValue()}
			Clockwork.datastream:Start("descSend", strings);
		end;
		
		gui.EnableScreenClicker(false);
	end;

	self.panelList:AddItem(textEntry);
	self.panelList:AddItem(label);
	self.panelList:AddItem(imageEntry);
	self.panelList:AddItem(button);
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout()
	self.panelList:StretchToParent(4, 28, 4, 4);
	
	DFrame.PerformLayout(self);
end;

vgui.Register("cwDetDesc", PANEL, "DFrame");