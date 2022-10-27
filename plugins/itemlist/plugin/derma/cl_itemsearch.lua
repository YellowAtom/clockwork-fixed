local PLUGIN = PLUGIN;
local PANEL = {};
PANEL.Base = "Panel";

-- Ripped from GMod github
local ContentPanel = nil;

function PANEL:Init()

	self:Dock(TOP);
	self:SetHeight(20);
	self:DockMargin(0, 0, 0, 3);

	self.Search = self:Add("DTextEntry");
	self.Search:Dock(FILL);

	self.Search.OnEnter = function() self:RefreshResults(); end;
	self.Search.OnFocusChanged = function(_, b) if (b) then self:RefreshResults(); end; end;
	self.Search:SetTooltip("Press enter to search");

	local btn = self.Search:Add("DImageButton");

	btn:SetImage("icon16/magnifier.png");
	btn:SetText("");
	btn:Dock(RIGHT);
	btn:DockMargin(4, 2, 4, 2);
	btn:SetSize(16, 16);
	btn:SetTooltip("Press to search");
	btn.DoClick = function()
		self:RefreshResults();
	end;

	self.Search.OnKeyCode = function(p, code)

		if (code == KEY_F1) then hook.Run("OnSpawnMenuClose"); end;
		if (code == KEY_ESCAPE) then hook.Run("OnSpawnMenuClose"); end;

	end;

	function PLUGIN:StartSearch()

		if (g_SpawnMenu:IsVisible()) then return hook.Run("OnSpawnMenuClose"); end;

		hook.Run("OnSpawnMenuOpen");
		hook.Run("OnTextEntryGetFocus", self.Search);

		self.Search:RequestFocus();
		self.Search:SetText("");

		timer.Simple(0.1, function() g_SpawnMenu:HangOpen(false); end);

		ContentPanel:SwitchPanel(self.SearchItemPanel);

	end;

	--function PLUGIN:SearchUpdate()

	--	if (!g_SpawnMenu:IsVisible()) then return end
	--	self:RefreshResults();

--	end;

	self.SearchItemPanel = vgui.Create("ContentContainer", self);
	self.SearchItemPanel:SetVisible(false);
	self.SearchItemPanel:SetTriggerSpawnlistChange(false);

	g_SpawnMenu.SearchItemPanel = self.SearchItemPanel;

end;

function PANEL:RefreshResults()

	if (self.Search:GetText() == "") then return; end;

	self.SearchItemPanel:Clear();

	local text = self.Search:GetText():lower();
	text = text:PatternSafe();

	local results = {};

	for k, v in pairs(Clockwork.item.stored) do
		if (v.name:lower():find(text)) then
			results[k] = v;
		end;
	end;

	local header = self:Add("ContentHeader");

	header:SetText(table.Count(results) .. " Results for \"" .. self.Search:GetText() .. "\"");
	self.SearchItemPanel:Add(header);

	if (table.Count(results) > 0) then
		for uniqueID, itemTable in pairs(results) do
			spawnmenu.CreateContentIcon("cwItem", self.SearchItemPanel, itemTable);
		end;
	end;

	self.SearchItemPanel:SetParent(ContentPanel);
	ContentPanel:SwitchPanel(self.SearchItemPanel);

end;


function PLUGIN:PopulateContent(pnlContent, tree, node)
	ContentPanel = pnlContent;
end;

vgui.Register("ItemSearch", PANEL);