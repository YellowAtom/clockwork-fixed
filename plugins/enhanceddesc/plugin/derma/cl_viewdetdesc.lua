--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local PLUGIN = PLUGIN;

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
	
	self.textEntry:SetEditable(false);
	self:SetSize(512, 512);
	self:SetPos((scrW / 2) - (self:GetWide() / 2), (scrH / 2) - (self:GetTall() / 2));
	
	if (!IsValid(self.target) or self.target:GetPos():DistToSqr(Clockwork.Client:GetPos()) > 160000) then
		if (IsValid(PLUGIN.PicturePanel)) then
			PLUGIN.PicturePanel:Close(); PLUGIN.PicturePanel:Remove();
		end;

		self:Close(); self:Remove();
		
		gui.EnableScreenClicker(false);
	end;
end;

-- A function to populate the panel.
function PANEL:Populate(target, data, link)
	local colorWhite = Clockwork.option:GetColor("white");
	local name = target:GetName();
	self.target = target;
	if (!Clockwork.player:DoesRecognise(target, RECOGNISE_TOTAL)) then
		name = "Someone";
	end;
	self:SetTitle(name.."'s Detailed Description");
	
	self.panelList:Clear();
	
	self.button = vgui.Create("DButton");	
	if (!link or link == "") then
		self.button:SetText(name.." does not have a reference picture.")
		self.button:SetDisabled();
	else
		self.button:SetText("View "..name.."'s reference picture.");

		-- Called when the button is clicked.
		function self.button.DoClick()
			if (IsValid(PLUGIN.PicturePanel)) then
				PLUGIN.PicturePanel:Close();
				PLUGIN.PicturePanel:Remove();
			end;

			PLUGIN.PicturePanel = vgui.Create("cwPictureDesc");
			PLUGIN.PicturePanel:Populate(tostring(link));
			PLUGIN.PicturePanel:MakePopup();
		end;
	end;
	
	self.textEntry = vgui.Create("DTextEntry");

	self.textEntry:SetText(data or "");

	self.textEntry:SetTall(512 - (39 + self.button:GetTall()));
	
	self.textEntry:SizeToContents();
	self.textEntry:SetEditable(false);
	self.textEntry:SetMultiline(true);
	
	self.panelList:AddItem(self.textEntry);
	self.panelList:AddItem(self.button);
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout()
	self.panelList:StretchToParent(4, 28, 4, 4);
	DFrame.PerformLayout(self);
end;

vgui.Register("cwViewDetDesc", PANEL, "DFrame");