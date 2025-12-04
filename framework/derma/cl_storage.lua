local Clockwork = Clockwork

local CloseDermaMenus = CloseDermaMenus
local IsValid = IsValid
local pairs = pairs
local ScrH = ScrH
local ScrW = ScrW
local table = table
local vgui = vgui
local math = math
local gui = gui

local PANEL = {}

-- Called when the panel is initialized.
function PANEL:Init()
	self:SetTitle(Clockwork.storage:GetName())
	self:SetDeleteOnClose(false)

	-- Called when the button is clicked.
	function self.btnClose.DoClick(button)
		CloseDermaMenus()
		self:Close()
		self:Remove()
		gui.EnableScreenClicker(false)
		Clockwork.kernel:RunCommand("StorageClose")
	end

	self.containerPanel = vgui.Create("cwPanelList", self)
	self.containerPanel:SetPadding(2)
	self.containerPanel:SetSpacing(3)
	self.containerPanel:SizeToContents()
	self.containerPanel:EnableVerticalScrollbar()

	if not Clockwork.storage:GetIsOneSided() then
		self.inventoryPanel = vgui.Create("cwPanelList", self)
		self.inventoryPanel:SetPadding(2)
		self.inventoryPanel:SetSpacing(3)
		self.inventoryPanel:SizeToContents()
		self.inventoryPanel:EnableVerticalScrollbar()
	end

	Clockwork.kernel:SetNoticePanel(self)
end

-- A function to rebuild a panel.
function PANEL:RebuildPanel(storagePanel, storageType, usedWeight, weight, usedSpace, space, cash, inventory)
	storagePanel:Clear(true)
	storagePanel.cash        = cash
	storagePanel.weight      = weight
	storagePanel.usedWeight  = usedWeight
	storagePanel.space       = space
	storagePanel.usedSpace   = usedSpace
	storagePanel.inventory   = inventory
	storagePanel.storageType = storageType

	Clockwork.plugin:Call("PlayerPreRebuildStorage", storagePanel)

	-- Setup model preview
	local modelIcon = vgui.Create("DModelPanel", storagePanel)
	modelIcon:SetSize(100, 250)

	local modelSource = (storageType == "Container" and Clockwork.storage:GetEntity()) or Clockwork.Client
	if IsValid(modelSource) then
		modelIcon:SetModel(modelSource:GetModel())
		
		local modelEntity = modelIcon:GetEntity()
		if IsValid(modelEntity) then
			modelEntity:SetSequence(modelSource:GetSequence())
			
			-- Copy skin from source
			modelEntity:SetSkin(modelSource:GetSkin())
			
			-- Copy all bodygroups from source
			for i = 0, modelSource:GetNumBodyGroups() - 1 do
				modelEntity:SetBodygroup(i, modelSource:GetBodygroup(i))
			end
		end
	end

	-- Look at head position (fallback vector if bone missing)
	local bone     = modelIcon:GetEntity():LookupBone("ValveBiped.Bip01_Head1")
	local position = bone and select(1, modelIcon:GetEntity():GetBonePosition(bone)) or Vector(0, 0, 10)
	modelIcon:SetLookAt(position - Vector(0, 0, 15))

	function modelIcon:LayoutEntity(entity)
		self:RunAnimation()
	end

	storagePanel:AddItem(modelIcon)

	-- Cash weight/space contribution
	local cWeight = Clockwork.config:Get("cash_weight"):Get()
	local cSpace  = Clockwork.config:Get("cash_space"):Get()

	if not Clockwork.storage:GetNoCashWeight() then
		usedWeight = (usedWeight or 0) + cash * cWeight
	end
	if not Clockwork.storage:GetNoCashSpace() then
		usedSpace = (usedSpace or 0) + cash * cSpace
	end

	-- Collect items into categories
	local categories = {}
	for _, categoryItems in pairs(inventory) do
		for _, item in pairs(categoryItems) do
			local allowed = (storageType == "Container" and Clockwork.storage:CanTakeFrom(item))
				or (storageType == "Inventory" and Clockwork.storage:CanGiveTo(item))
			if allowed then
				local cat = item("category")
				if cat then
					categories[cat] = categories[cat] or {category = cat, itemsList = {}}
					table.insert(categories[cat].itemsList, item)

					usedWeight = usedWeight + math.max(item("storageWeight", item("weight")), 0)
					usedSpace  = usedSpace  + math.max(item("storageSpace", item("space")), 0)
				end
			end
		end
	end

	-- Sort categories alphabetically
	local categoryList = {}
	for _, v in pairs(categories) do
		table.insert(categoryList, v)
	end
	table.sort(categoryList, function(a, b) return a.category < b.category end)

	storagePanel.usedWeight = storagePanel.usedWeight or usedWeight
	storagePanel.usedSpace  = storagePanel.usedSpace  or usedSpace

	Clockwork.plugin:Call("PlayerStorageRebuilt", storagePanel, categoryList)

	-- Cash transfer UI
	if Clockwork.config:Get("cash_enabled"):Get() and storagePanel.cash > 0 then
		local numberWang = vgui.Create("DNumberWang", storagePanel)
		numberWang:SetDecimals(0)
		numberWang:SetMinMax(0, storagePanel.cash)
		numberWang:SetValue(storagePanel.cash)
		numberWang.Stretch = true
		numberWang:SizeToContents()

		local button = vgui.Create("DButton", storagePanel)
		button:SetText(L("StorageTransfer"))
		button.Stretch = true
		button.DoClick = function()
			local cmd = (storageType == "Inventory") and "StorageGiveCash" or "StorageTakeCash"
			Clockwork.kernel:RunCommand(cmd, numberWang:GetValue())
		end

		local cashForm = vgui.Create("DForm", storagePanel)
		cashForm:SetPadding(5)
		cashForm:SetName(L("Cash"))
		cashForm:AddItem(numberWang)
		cashForm:AddItem(button)
		storagePanel:AddItem(cashForm)
	end

	-- Weight info
	local infoWeight = vgui.Create("DForm", storagePanel)
	infoWeight:SetPadding(5)
	infoWeight:SetName(L("Weight"))

	local storageWeight = vgui.Create("cwStorageWeight", storagePanel)
	storageWeight:SetWeight(weight)
	storageWeight:SetUsedWeight(usedWeight)
	infoWeight:AddItem(storageWeight)
	storagePanel:AddItem(infoWeight)

	-- Space info (only if used)
	if Clockwork.inventory:UseSpaceSystem() and storagePanel.usedSpace > 0 then
		local infoSpace = vgui.Create("DForm", storagePanel)
		infoSpace:SetPadding(5)
		infoSpace:SetName(L("Space"))

		local storageSpace = vgui.Create("cwStorageSpace", storagePanel)
		storageSpace:SetSpace(space)
		storageSpace:SetUsedSpace(usedSpace)
		infoSpace:AddItem(storageSpace)
		storagePanel:AddItem(infoSpace)
	end

	-- Category panels
	for _, cat in ipairs(categoryList) do
		local collapsible = Clockwork.kernel:CreateCustomCategoryPanel(cat.category, storagePanel)
		collapsible:SetCookieName(storageType .. cat.category)
		storagePanel:AddItem(collapsible)

		local list = vgui.Create("DPanelList", collapsible)
		list:EnableHorizontal(true)
		list:SetAutoSize(true)
		list:SetPadding(4)
		list:SetSpacing(4)
		collapsible:SetContents(list)

		table.sort(cat.itemsList, function(a, b) return a("itemID") < b("itemID") end)

		for _, item in ipairs(cat.itemsList) do
			CURRENT_ITEM_DATA = {itemTable = item, storageType = storageType}
			list:AddItem(vgui.Create("cwStorageItem", list))
		end
	end
end

-- A function to rebuild the panel.
function PANEL:Rebuild()
	self:RebuildPanel(self.containerPanel, "Container", nil, Clockwork.storage:GetWeight(), nil, Clockwork.storage:GetSpace(), Clockwork.storage:GetCash(), Clockwork.storage:GetInventory())

	if not Clockwork.storage:GetIsOneSided() then
		local inventory = Clockwork.inventory:GetClient()
		local maxWeight = Clockwork.player:GetMaxWeight()
		local weight = Clockwork.inventory:CalculateWeight(inventory)
		local maxSpace = Clockwork.player:GetMaxSpace()
		local space = Clockwork.inventory:CalculateSpace(inventory)
		local cash = Clockwork.player:GetCash()
		self:RebuildPanel(self.inventoryPanel, "Inventory", weight, maxWeight, space, maxSpace, cash, inventory)
	end
end

-- Called each frame.
function PANEL:Think()
	self:SetSize(ScrW() * 0.5, ScrH() * 0.75)
	self:SetPos(ScrW() / 2 - self:GetWide() / 2, ScrH() / 2 - self:GetTall() / 2)

	if IsValid(self.inventoryPanel) and Clockwork.player:GetCash() ~= self.inventoryPanel.cash then
		self:Rebuild()
	end
end

-- Called when the layout should be performed.
function PANEL:PerformLayout(w, h)
	DFrame.PerformLayout(self)

	if not Clockwork.storage:GetIsOneSided() then
		self.inventoryPanel:StretchToParent(nil, 28, nil, 4)
		self.inventoryPanel:AlignRight(0)
		self.inventoryPanel:SetWide(self:GetWide() / 2)
	end

	self.containerPanel:SetWide(self:GetWide() / 2)
	self.containerPanel:StretchToParent(nil, 28, nil, 4)
	self.containerPanel:AlignLeft(0)
end

vgui.Register("cwStorage", PANEL, "DFrame")
local PANEL = {}

-- Called when the panel is initialized.
function PANEL:Init()
	local itemData = self:GetParent().itemData or CURRENT_ITEM_DATA
	self:SetSize(56, 56)
	self.itemTable = itemData.itemTable
	self.storageType = itemData.storageType
	self.spawnIcon = Clockwork.kernel:CreateMarkupToolTip(vgui.Create("cwSpawnIcon", self))

	-- Called when the spawn icon is clicked.
	function self.spawnIcon.DoClick(spawnIcon)
		if not self.nextCanClick or CurTime() >= self.nextCanClick then
			if self.storageType == "Inventory" then
				Clockwork.kernel:RunCommand("StorageGiveItem", self.itemTable("uniqueID"), self.itemTable("itemID"))
			else
				Clockwork.kernel:RunCommand("StorageTakeItem", self.itemTable("uniqueID"), self.itemTable("itemID"))
			end

			self.nextCanClick = CurTime() + 1
		end
	end

	local model, skin = Clockwork.item:GetIconInfo(self.itemTable)
	self.spawnIcon:SetModel(model, skin)
	self.spawnIcon:SetTooltip(false)
	self.spawnIcon:SetSize(52, 52)

	self.cachedInfo = {
		model = model,
		skin = skin
	}
end

-- Called each frame.
function PANEL:Think()
	self.spawnIcon:SetMarkupToolTip(Clockwork.item:GetMarkupToolTip(self.itemTable))
	self.spawnIcon:SetColor(self.itemTable("color"))
	--[[ Check if the model or skin has changed and update the spawn icon. --]]
	local model, skin = Clockwork.item:GetIconInfo(self.itemTable)

	if model ~= self.cachedInfo.model or skin ~= self.cachedInfo.skin then
		self.spawnIcon:SetModel(model, skin)
		self.cachedInfo.model = model
		self.cachedInfo.skin = skin
	end
end

vgui.Register("cwStorageItem", PANEL, "DPanel")
local PANEL = {}

function PANEL:SetWeight(weight)
	self.weight = weight
end

function PANEL:GetWeight()
	return self.weight or 0
end

function PANEL:SetUsedWeight(usedWeight)
	self.usedWeight = usedWeight
end

function PANEL:GetUsedWeight()
	return self.usedWeight or 0
end

-- Called when the panel is initialized.
function PANEL:Init()
	local colorWhite = Clockwork.option:GetColor("white")
	self.spaceUsed = vgui.Create("DPanel", self)
	self.spaceUsed:SetPos(1, 1)
	self.panel = self:GetParent()
	self.weightLabel = vgui.Create("DLabel", self)
	self.weightLabel:SetText("N/A")
	self.weightLabel:SetTextColor(colorWhite)
	self.weightLabel:SizeToContents()
	self.weightLabel:SetExpensiveShadow(1, Color(0, 0, 0, 150))

	-- Called when the panel should be painted.
	function self.spaceUsed.Paint(spaceUsed)
		local maximumWeight = math.floor(self:GetWeight())
		local usedWeight = math.floor(self:GetUsedWeight())
		local color = Color(100, 100, 100, 255)
		local width = math.Clamp((spaceUsed:GetWide() / maximumWeight) * usedWeight, 0, spaceUsed:GetWide())
--		local red = math.Clamp((255 / maximumWeight) * usedWeight, 0, 255)

		if color then
			color.r = math.min(color.r - 25, 255)
			color.g = math.min(color.g - 25, 255)
			color.b = math.min(color.b - 25, 255)
		end

		Clockwork.kernel:DrawSimpleGradientBox(0, 0, 0, spaceUsed:GetWide(), spaceUsed:GetTall(), color)
		Clockwork.kernel:DrawSimpleGradientBox(0, 0, 0, width, spaceUsed:GetTall(), Color(139, 215, 113, 255))
	end
end

-- Called each frame.
function PANEL:Think()
	self.spaceUsed:SetSize(self:GetWide() - 2, self:GetTall() - 2)
	self.weightLabel:SetText(math.floor(self:GetUsedWeight()) .. "/" .. math.floor(self:GetWeight()) .. "kg")
	self.weightLabel:SetPos(self:GetWide() / 2 - self.weightLabel:GetWide() / 2, self:GetTall() / 2 - self.weightLabel:GetTall() / 2)
	self.weightLabel:SizeToContents()
end

vgui.Register("cwStorageWeight", PANEL, "DPanel")
local PANEL = {}

function PANEL:SetSpace(space)
	self.maxSpace = space
end

function PANEL:GetSpace()
	return self.maxSpace or 0
end

function PANEL:SetUsedSpace(usedSpace)
	self.usedSpace = usedSpace
end

function PANEL:GetUsedSpace()
	return self.usedSpace or 0
end

-- Called when the panel is initialized.
function PANEL:Init()
	local colorWhite = Clockwork.option:GetColor("white")
	self.spaceUsed = vgui.Create("DPanel", self)
	self.spaceUsed:SetPos(1, 1)
	self.panel = self:GetParent()
	self.space = vgui.Create("DLabel", self)
	self.space:SetText("N/A")
	self.space:SetTextColor(colorWhite)
	self.space:SizeToContents()
	self.space:SetExpensiveShadow(1, Color(0, 0, 0, 150))

	-- Called when the panel should be painted.
	function self.spaceUsed.Paint(spaceUsed)
		local maximumSpace = math.floor(self:GetSpace())
		local usedSpace = math.floor(self:GetUsedSpace())
		local color = Color(100, 100, 100, 255)
		local width = math.Clamp((spaceUsed:GetWide() / maximumSpace) * usedSpace, 0, spaceUsed:GetWide())
--		local red = math.Clamp((255 / maximumSpace) * usedSpace, 0, 255)

		if color then
			color.r = math.min(color.r - 25, 255)
			color.g = math.min(color.g - 25, 255)
			color.b = math.min(color.b - 25, 255)
		end

		Clockwork.kernel:DrawSimpleGradientBox(0, 0, 0, spaceUsed:GetWide(), spaceUsed:GetTall(), color)
		Clockwork.kernel:DrawSimpleGradientBox(0, 0, 0, width, spaceUsed:GetTall(), Color(139, 215, 113, 255))
	end
end

-- Called each frame.
function PANEL:Think()
	self.spaceUsed:SetSize(self:GetWide() - 2, self:GetTall() - 2)
	self.space:SetText(math.floor(self:GetUsedSpace()) .. "/" .. math.floor(self:GetSpace()) .. "l")
	self.space:SetPos(self:GetWide() / 2 - self.space:GetWide() / 2, self:GetTall() / 2 - self.space:GetTall() / 2)
	self.space:SizeToContents()
end

vgui.Register("cwStorageSpace", PANEL, "DPanel")

/* -------------------------------------------------------------------------- */
/*                            NETWORKING FUNCTIONS                            */
/* -------------------------------------------------------------------------- */

net.Receive(
    "cwStorageStart",
    function()
        gui.EnableScreenClicker(true)
        Clockwork.storage.noCashWeight = net.ReadBool()
        Clockwork.storage.noCashSpace = net.ReadBool()
        Clockwork.storage.isOneSided = net.ReadBool()
        Clockwork.storage.entity = net.ReadEntity()
        Clockwork.storage.name = net.ReadString()
        Clockwork.storage.inventory = {}
        Clockwork.storage.weight = Clockwork.config:Get("default_inv_weight"):Get()
        Clockwork.storage.space = Clockwork.config:Get("default_inv_space"):Get()
        Clockwork.storage.cash = 0

        Clockwork.storage.panel = vgui.Create("cwStorage")
        Clockwork.storage.panel:Rebuild()
        Clockwork.storage.panel:MakePopup()
        Clockwork.kernel:RegisterBackgroundBlur(Clockwork.storage:GetPanel(), SysTime())
    end
)

net.Receive(
    "cwStorageCash",
    function()
        if Clockwork.storage:IsStorageOpen() then
            Clockwork.storage.cash = net.ReadInt(32)
            Clockwork.storage:GetPanel():Rebuild()
        end
    end
)

net.Receive(
    "cwStorageWeight",
    function()
        if Clockwork.storage:IsStorageOpen() then
            Clockwork.storage.weight = net.ReadInt(32)
            Clockwork.storage:GetPanel():Rebuild()
        end
    end
)

net.Receive(
    "cwStorageSpace",
    function()
        if Clockwork.storage:IsStorageOpen() then
            Clockwork.storage.space = net.ReadInt(32)
            Clockwork.storage:GetPanel():Rebuild()
        end
    end
)

net.Receive(
    "cwStorageClose",
    function()
        if Clockwork.storage:IsStorageOpen() then
            Clockwork.kernel:RemoveBackgroundBlur(Clockwork.storage:GetPanel())
            CloseDermaMenus()
            Clockwork.storage:GetPanel():Close()
            Clockwork.storage:GetPanel():Remove()
            gui.EnableScreenClicker(false)
            Clockwork.storage.inventory = nil
            Clockwork.storage.weight = nil
            Clockwork.storage.space = nil
            Clockwork.storage.entity = nil
            Clockwork.storage.name = nil
        end
    end
)

net.Receive(
    "cwStorageTake",
    function()
        if Clockwork.storage:IsStorageOpen() then
            local sig = net.ReadTable()
            Clockwork.inventory:RemoveUniqueID(Clockwork.storage.inventory, sig.uniqueID, sig.itemID)
            Clockwork.storage:GetPanel():Rebuild()
        end
    end
)

net.Receive(
    "cwStorageGive",
    function()
        if Clockwork.storage:IsStorageOpen() then
            local index = net.ReadUInt(16)
            local count = net.ReadUInt(12)
            local itemTable = Clockwork.item:FindByID(index)

            if itemTable then
                for i = 1, count do
                    local id = net.ReadUInt(32)
                    local data = net.ReadTable()
                    Clockwork.inventory:AddInstance(
                        Clockwork.storage.inventory,
                        Clockwork.item:CreateInstance(index, id, data)
                    )
                end
                Clockwork.storage:GetPanel():Rebuild()
            end
        end
    end
)
