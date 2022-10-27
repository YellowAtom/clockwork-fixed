local Clockwork = Clockwork;
local pairs = pairs;
local ScrH = ScrH;
local ScrW = ScrW;
local table = table;
local vgui = vgui;

local PANEL = {};

-- Called when the panel is initialized.
function PANEL:Init()
	self:SetSize(Clockwork.menu:GetWidth(), Clockwork.menu:GetHeight());
	self.customizationOptions = {};

	self.characterModel = vgui.Create("cwCharacterModel", self);
	self.characterModel:SetPos(0, 0);
	self.characterModel:SetModel(Clockwork.Client:GetModel());

	self.characterModel.DoClick = function()
		local bodygroups = self.characterModel.Entity:GetBodyGroups();
		local bodygroupCount = table.Count(bodygroups) - 1;
		local skinCount = self.characterModel.Entity:SkinCount() - 1;
		local options = {["Customize"] = {}};

		options["Apply"] = function()
			Clockwork.Client.customizationOptions = self.customizationOptions;
			Clockwork.datastream:Start("CustomizationOptions", self.customizationOptions);
		end;

		options["Reset"] = function()
			self:ResetModel();
		end;

		if (skinCount > 0) then
			options["Customize"]["Skin"] = {};

			for i = 0, skinCount do
				options["Customize"]["Skin"]["Skin "..tostring(i)] = function()
					self.characterModel.Entity:SetSkin(i);
					self.customizationOptions["Skin"] = i;
				end;
			end;
		end;

		for k, v in pairs(bodygroups) do
			local name, num = v.name or "Unknown", v.num - 1; --[[ Is this even possible? Whatever. ]]--

			options["Customize"][name] = {};

			for i = 0, num do
				if (num > 0) then
					options["Customize"][name][name.." "..tostring(i)] = function()
						self.characterModel.Entity:SetBodygroup(v.id, i);
						self.customizationOptions[v.id] = i;
					end;
				end;
			end;
		end;

		local menuPanel = Clockwork.kernel:AddMenuFromData(nil, options, function(menuPanel, option, arguments) end);
	end;

	for k, v in pairs(Clockwork.Client.customizationOptions) do
		if (k == "Skin") then
			self.characterModel.Entity:SetSkin(v);
		else
			self.characterModel.Entity:SetBodygroup(k, v);
		end;
	end;

	self:Rebuild();
end;

-- A function to rebuild the panel.
function PANEL:Rebuild() end;

-- Called to by the menu to get the width of the panel.
function PANEL:GetMenuWidth()
	return ScrW() * 0.5;
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout(w, h)
	self:SetSize(w, ScrH() * 0.75);
	self.characterModel:SetSize(w, ScrH() - 60);
	self:SetAlpha(0);
end;

-- Called when the panel is painted.
function PANEL:Paint(w, h)
	derma.SkinHook("Paint", "Frame", self, w, h);
	
	return true;
end;

-- Called each frame.
function PANEL:Think()
	self:InvalidateLayout(true);
end;

-- A function to reset the panel.
function PANEL:ResetModel()
	self.characterModel:SetModel(Clockwork.Client:GetModel());
	self.customizationOptions = {};

	for k, v in pairs(Clockwork.Client.customizationOptions) do
		if (k == "Skin") then
			self.characterModel.Entity:SetSkin(v);
		else
			self.characterModel.Entity:SetBodygroup(k, v);
		end;
	end;
end;

vgui.Register("cwCharacterCustomizer", PANEL, "EditablePanel");