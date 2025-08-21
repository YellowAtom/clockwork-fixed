local Clockwork = Clockwork
local IsValid = IsValid
local pairs = pairs

Clockwork.storage = Clockwork.kernel:NewLibrary("Storage")

util.AddNetworkString("cwStorageStart")
util.AddNetworkString("cwStorageClose")
util.AddNetworkString("cwStorageCash")
util.AddNetworkString("cwStorageWeight")
util.AddNetworkString("cwStorageSpace")
util.AddNetworkString("cwStorageGive")
util.AddNetworkString("cwStorageTake")


-- small helpers --------------------------------------------------------------

-- Send a net message to all players who are currently viewing the same
-- storage inventory table as `inventory`.
local function SendToInventoryViewers(inventory, sendFunc)
	for _, ply in pairs(cwPlayer.GetAll()) do
		if ply:HasInitialized() and ply:GetStorageTable() then
			if Clockwork.storage:Query(ply, "inventory") == inventory then
				sendFunc(ply)
			end
		end
	end
end

-- Chunked iteration helper (synchronous across several ticks).
-- Calls `work(itemKey)` for up to `chunkSize` keys per tick.
local function StreamKeysOverTicks(timerName, owner, keys, chunkSize, work)
	chunkSize = chunkSize or 200
	local i = 1
	local reps = math.ceil(#keys / chunkSize)

	timer.Create(timerName, 0, reps, function()
		if owner ~= nil and not IsValid(owner) then return end
		for _ = 1, chunkSize do
			local k = keys[i]
			if not k then return end
			work(k)
			i = i + 1
		end
	end)
end

-- net write for a single item definition entry (ID + data table).
local function NetWriteItemEntry(entry)
	-- entry = { id = <uint>, data = <table> }
	net.WriteUInt(entry.id or 0, 32)
	-- Keep this as a table because item custom data schema is mod-dependent.
	-- It's far smaller than writing whole inventories, and we also chunk.
	net.WriteTable(entry.data or {})
end

-------------------------------------------------------------------------------
--[[
	@codebase Server
	@details A function to get a player's storage entity.
	@param {Player} player
	@returns {Entity|nil}
--]]
function Clockwork.storage:GetEntity(player)
	if player:GetStorageTable() then
		local entity = self:Query(player, "entity")
		if entity and IsValid(entity) then return entity end
	end
end

--[[
	@codebase Server
	@details A function to get a player's storage table.
	@param {Player} player
	@returns {table|nil}
--]]
function Clockwork.storage:GetTable(player)
	return player.cwStorageTab
end

--[[
	@codebase Server
	@details A function to get whether a player's storage has an item.
	@param {Player} player
	@param {Item} itemTable
	@returns {boolean}
--]]
function Clockwork.storage:HasItem(player, itemTable)
	local inventory = self:Query(player, "inventory")
	if inventory then return Clockwork.inventory:HasItemInstance(inventory, itemTable) end
	return false
end

--[[
	@codebase Server
	@details A function to query a player's storage.
	@param {Player} player
	@param {string} key
	@param {any} default
	@returns {any}
--]]
function Clockwork.storage:Query(player, key, default)
	local storageTable = player:GetStorageTable()
	if storageTable then
		return storageTable[key] or default
	else
		return default
	end
end

--[[
	@codebase Server
	@details A function to close storage for a player.
	@param {Player} player
	@param {boolean} bServer If true, don't notify the client (server-side close).
	@returns {void}
--]]
function Clockwork.storage:Close(player, bServer)
	local storageTable = player:GetStorageTable()
	local OnClose = self:Query(player, "OnClose")
	local entity = self:Query(player, "entity")

	if storageTable and OnClose then
		OnClose(player, storageTable, entity)
	end

	if not bServer then
		net.Start("cwStorageClose")
			net.WriteBool(true)
		net.Send(player)
	end

	player.cwStorageTab = nil
end

--[[
	@codebase Server
	@details A function to get the weight of a player's storage.
	@param {Player} player
	@returns {number}
--]]
function Clockwork.storage:GetWeight(player)
	if player:GetStorageTable() then
		local cash = self:Query(player, "cash")
		local weight = cash * Clockwork.config:Get("cash_weight"):Get()
		local inventory = self:Query(player, "inventory")

		if self:Query(player, "noCashWeight") then
			weight = 0
		end

		for _, v in pairs(Clockwork.inventory:GetAsItemsList(inventory)) do
			weight = weight + math.max(v("storageWeight") or v("weight"), 0)
		end

		return weight
	else
		return 0
	end
end

--[[
	@codebase Server
	@details A function to get the space of a player's storage.
	@param {Player} player
	@returns {number}
--]]
function Clockwork.storage:GetSpace(player)
	if player:GetStorageTable() then
		local cash = self:Query(player, "cash")
		local space = cash * Clockwork.config:Get("cash_space"):Get()
		local inventory = self:Query(player, "inventory")

		if self:Query(player, "noCashSpace") then
			space = 0
		end

		for _, v in pairs(Clockwork.inventory:GetAsItemsList(inventory)) do
			space = space + math.max(v("storageSpace") or v("space"), 0)
		end

		return space
	else
		return 0
	end
end

--[[
	@codebase Server
	@details A function to open storage for a player.
	@param {Player} player
	@param {table} data
	@returns {void}
--]]
function Clockwork.storage:Open(player, data)
	local storageTable = player:GetStorageTable()
	local OnClose = self:Query(player, "OnClose")

	if storageTable and OnClose then
		OnClose(player, storageTable, storageTable.entity)
	end

	if not Clockwork.config:Get("cash_enabled"):Get() then
		data.cash = nil
	end

	if data.noCashWeight == nil then data.noCashWeight = false end
	if data.noCashSpace == nil then data.noCashSpace = false end
	if data.isOneSided == nil then data.isOneSided = false end

	data.inventory = data.inventory or {}
	data.entity    = data.entity == nil and player or data.entity
	data.weight    = data.weight or Clockwork.config:Get("default_inv_weight"):Get()
	data.space     = data.space or Clockwork.config:Get("default_inv_space"):Get()
	data.cash      = data.cash or 0
	data.name      = data.name or "Storage"
	player.cwStorageTab = data

	-- lightweight start payload
	net.Start("cwStorageStart")
		net.WriteBool(data.noCashWeight)
		net.WriteBool(data.noCashSpace)
		net.WriteBool(data.isOneSided)
		net.WriteEntity(data.entity)
		net.WriteString(data.name or "")
	net.Send(player)

	self:UpdateCash(player, data.cash)
	self:UpdateWeight(player, data.weight)
	self:UpdateSpace(player, data.space)

	-- Stream inventory entries in batches to prevent net overflow.
	local keys = table.GetKeys(data.inventory)
	StreamKeysOverTicks("cwInvStream_" .. player:EntIndex(), player, keys, 200, function(k)
		self:UpdateByID(player, k)
	end)
end

--[[
	@codebase Server
	@details A function to update a player's storage cash.
	@param {Player} player
	@param {number} cash
	@returns {void}
--]]
function Clockwork.storage:UpdateCash(player, cash)
	if not Clockwork.config:Get("cash_enabled"):Get() then return end
	local storageTable = player:GetStorageTable()
	if not storageTable then return end

	local inventory = self:Query(player, "inventory")
	SendToInventoryViewers(inventory, function(viewer)
		viewer.cwStorageTab.cash = cash
		net.Start("cwStorageCash")
			net.WriteInt(cash or 0, 32)
		net.Send(viewer)
	end)
end

--[[
	@codebase Server
	@details A function to update a player's storage weight.
	@param {Player} player
	@param {number} weight
	@returns {void}
--]]
function Clockwork.storage:UpdateWeight(player, weight)
	if not player:GetStorageTable() then return end
	local inventory = self:Query(player, "inventory")
	SendToInventoryViewers(inventory, function(viewer)
		viewer.cwStorageTab.weight = weight
		net.Start("cwStorageWeight")
			net.WriteInt(weight or 0, 32)
		net.Send(viewer)
	end)
end

--[[
	@codebase Server
	@details A function to update a player's storage space.
	@param {Player} player
	@param {number} space
	@returns {void}
--]]
function Clockwork.storage:UpdateSpace(player, space)
	if not player:GetStorageTable() then return end
	local inventory = self:Query(player, "inventory")
	SendToInventoryViewers(inventory, function(viewer)
		viewer.cwStorageTab.space = space
		net.Start("cwStorageSpace")
			net.WriteInt(space or 0, 32)
			net.Send(viewer)
	end)
end

--[[
	@codebase Server
	@details A function to get whether a player can give to storage.
	@param {Player} player
	@param {Item} itemTable
	@returns {boolean}
--]]
function Clockwork.storage:CanGiveTo(player, itemTable)
	local entity = self:Query(player, "entity")
	local isPlayer = entity and entity:IsPlayer()

	if itemTable then
		local allowPlayerStorage = (not isPlayer) or itemTable("allowPlayerStorage") ~= false
		local allowEntityStorage = isPlayer or itemTable("allowEntityStorage") ~= false
		local allowPlayerGive    = (not isPlayer) or itemTable("allowPlayerGive") ~= false
		local allowEntityGive    = isPlayer or itemTable("allowEntityGive") ~= false
		local allowStorage       = itemTable("allowStorage") ~= false
		local isShipment         = entity and entity:GetClass() == "cw_shipment"
		local allowGive          = itemTable("allowGive") ~= false
		if isShipment or (allowPlayerStorage and allowPlayerGive and allowEntityStorage and allowStorage and allowGive and allowEntityGive) then
			return true
		end
	end
end

--[[
	@codebase Server
	@details A function to get whether a player can take from storage.
	@param {Player} player
	@param {Item} itemTable
	@returns {boolean}
--]]
function Clockwork.storage:CanTakeFrom(player, itemTable)
	local entity = self:Query(player, "entity")
	local isPlayer = entity and entity:IsPlayer()

	if itemTable then
		local allowPlayerStorage = (not isPlayer) or itemTable("allowPlayerStorage") ~= false
		local allowEntityStorage = isPlayer or itemTable("allowEntityStorage") ~= false
		local allowPlayerTake    = (not isPlayer) or itemTable("allowPlayerTake") ~= false
		local allowEntityTake    = isPlayer or itemTable("allowEntityTake") ~= false
		local allowStorage       = itemTable("allowStorage") ~= false
		local isShipment         = entity and entity:GetClass() == "cw_shipment"
		local allowTake          = itemTable("allowTake") ~= false
		if isShipment or (allowPlayerStorage and allowPlayerTake and allowEntityStorage and allowStorage and allowTake and allowEntityTake) then
			return true
		end
	end
end

--[[
	@codebase Server
	@details A function to sync a player's cash with viewers of their inventory.
	@param {Player} player
	@returns {void}
--]]
function Clockwork.storage:SyncCash(player)
	local recipients = {}
	local inventory  = player:GetInventory()
	local cash       = player:GetCash()

	if Clockwork.config:Get("cash_enabled"):Get() then
		for _, v in pairs(cwPlayer.GetAll()) do
			if v:HasInitialized() and self:Query(v, "inventory") == inventory then
				recipients[#recipients + 1] = v
				local storageTable = v:GetStorageTable()
				storageTable.cash = cash
			end
		end
	end

	if #recipients > 0 then
		for _, r in pairs(recipients) do
			net.Start("cwStorageCash")
				net.WriteInt(cash or 0, 32)
			net.Send(r)
		end
	end
end

--[[
	@codebase Server
	@details A function to sync a player's item (give or take) with viewers.
	@param {Player} player
	@param {Item} itemTable
	@returns {void}
--]]
function Clockwork.storage:SyncItem(player, itemTable)
	local inventory = player:GetInventory()
	if not itemTable then return end

	local definition = Clockwork.item:GetDefinition(itemTable, true)
	definition.index = nil
	local viewers = {}

	for _, v in pairs(cwPlayer.GetAll()) do
		if v:HasInitialized() and self:Query(v, "inventory") == inventory then
			viewers[#viewers + 1] = v
		end
	end

	if #viewers == 0 then return end

	if player:HasItemInstance(itemTable) then
		-- Gave into storage (storage gained item)
		for _, r in pairs(viewers) do
			net.Start("cwStorageGive")
				-- one item entry
				net.WriteUInt(itemTable("index"), 16) -- base item index
				net.WriteUInt(1, 12) -- count
				NetWriteItemEntry({ id = definition.itemID, data = definition.data })
			net.Send(r)
		end
	else
		-- Took from storage (storage lost item)
		local sig = Clockwork.item:GetSignature(itemTable)
		for _, r in pairs(viewers) do
			net.Start("cwStorageTake")
				-- signature is typically a table (unique identifiers); keep as table
				net.WriteTable(sig)
			net.Send(r)
		end
	end
end

--[[
	@codebase Server
	@details A function to give an item to a player's storage.
	@param {Player} player
	@param {Item} itemTable
	@returns {boolean}
--]]
function Clockwork.storage:GiveTo(player, itemTable)
	local storageTable = player:GetStorageTable()
	if not storageTable then return false end
	local inventory = self:Query(player, "inventory")
	if not self:CanGiveTo(player, itemTable) then return false end
	if not player:HasItemInstance(itemTable) or not Clockwork.plugin:Call("PlayerCanGiveToStorage", player, storageTable, itemTable) then return false end

	if (not storageTable.entity) or (not storageTable.entity:IsPlayer()) then
		local weight = itemTable("storageWeight", itemTable("weight"))
		local space  = itemTable("storageSpace",  itemTable("space"))
		if self:GetWeight(player) + math.max(weight, 0) > storageTable.weight
			or (Clockwork.inventory:UseSpaceSystem() and self:GetSpace(player) + math.max(space, 0) > storageTable.space) then
			return false
		end
	end

	local bCanGiveStorage = (not itemTable.CanGiveStorage) or itemTable:CanGiveStorage(player, storageTable)
	if bCanGiveStorage == false then return false end
	bCanGiveStorage = (not storageTable.CanGiveItem) or storageTable.CanGiveItem(player, storageTable, itemTable)
	if bCanGiveStorage == false then return false end
	if storageTable.entity and storageTable.entity:IsPlayer() and (not storageTable.entity:GiveItem(itemTable)) then return false end

	Clockwork.plugin:Call("PlayerGiveToStorage", player, storageTable, itemTable)
	Clockwork.inventory:AddInstance(inventory, itemTable)

	local definition = Clockwork.item:GetDefinition(itemTable, true)
	definition.index = nil

	-- notify viewers
	SendToInventoryViewers(inventory, function(r)
		net.Start("cwStorageGive")
			net.WriteUInt(itemTable("index"), 16)
			net.WriteUInt(1, 12)
			NetWriteItemEntry({ id = definition.itemID, data = definition.data })
		net.Send(r)
	end)

	player:TakeItem(itemTable)

	if storageTable.OnGiveItem and storageTable.OnGiveItem(player, storageTable, itemTable) then
		self:Close(player)
	end

	if itemTable.OnStorageGive and itemTable:OnStorageGive(player, storageTable) then
		self:Close(player)
	end

	if storageTable.entity and storageTable.entity:IsPlayer() then
		self:UpdateWeight(player, storageTable.entity:GetMaxWeight())
		self:UpdateSpace(player, storageTable.entity:GetMaxSpace())
	end

	return true
end

--[[
	@codebase Server
	@details A function to take an item from a player's storage.
	@param {Player} player
	@param {Item} itemTable
	@returns {boolean}
--]]
function Clockwork.storage:TakeFrom(player, itemTable)
	local storageTable = player:GetStorageTable()
	if not storageTable then return false end
	local inventory = self:Query(player, "inventory")
	local viewers = {}
	if not self:CanTakeFrom(player, itemTable) or not Clockwork.plugin:Call("PlayerCanTakeFromStorage", player, storageTable, itemTable) then return false end
	if not Clockwork.inventory:HasItemInstance(inventory, itemTable) then return false end
	local canTakeStorage = (not itemTable.CanTakeStorage) or itemTable:CanTakeStorage(player, storageTable)
	if canTakeStorage == false then return false end
	canTakeStorage = (not storageTable.CanTakeItem) or storageTable.CanTakeItem(player, storageTable, itemTable)
	if canTakeStorage == false then return false end
	local wasSuccess, fault = player:GiveItem(itemTable)

	if wasSuccess then
		Clockwork.plugin:Call("PlayerTakeFromStorage", player, storageTable, itemTable)

		if (not storageTable.entity) or (not storageTable.entity:IsPlayer()) then
			Clockwork.inventory:RemoveInstance(inventory, itemTable)
		else
			storageTable.entity:TakeItem(itemTable)
		end

		for _, v in pairs(cwPlayer.GetAll()) do
			if v:HasInitialized() and self:Query(v, "inventory") == inventory then
				viewers[#viewers + 1] = v
			end
		end

		local sig = Clockwork.item:GetSignature(itemTable)
		for _, r in pairs(viewers) do
			net.Start("cwStorageTake")
				net.WriteTable(sig)
			net.Send(r)
		end

		if storageTable.OnTakeItem and storageTable.OnTakeItem(player, storageTable, itemTable) then
			self:Close(player)
		end

		if itemTable.OnStorageTake and itemTable:OnStorageTake(player, itemTable) then
			self:Close(player)
		end

		if storageTable.entity and storageTable.entity:IsPlayer() then
			self:UpdateWeight(player, storageTable.entity:GetMaxWeight())
			self:UpdateSpace(player, storageTable.entity:GetMaxSpace())
		end

		return true
	else
		Clockwork.player:Notify(player, fault)
	end
end

--[[
	@codebase Server
	@details A function to update storage for a player by unique item ID (type).
	@param {Player} player
	@param {string} uniqueID Base item unique ID
	@returns {void}
--]]
function Clockwork.storage:UpdateByID(player, uniqueID)
	if not player:GetStorageTable() then return end
	local inventory = self:Query(player, "inventory")
	local itemTable = Clockwork.item:FindByID(uniqueID)
	if not (itemTable and inventory[uniqueID]) then return end

	-- Gather item instance definitions for this uniqueID
	local itemList = {}
	for _, v in pairs(inventory[uniqueID]) do
		local definition = Clockwork.item:GetDefinition(v, true)
		itemList[#itemList + 1] = { id = definition.itemID, data = definition.data }
	end

	-- Send in chunks
	local chunkSize = 100
	for i = 1, #itemList, chunkSize do
		local count = math.min(chunkSize, #itemList - i + 1)
		net.Start("cwStorageGive")
			net.WriteUInt(itemTable("index"), 16)
			net.WriteUInt(count, 12)
			for j = i, i + count - 1 do
				NetWriteItemEntry(itemList[j])
			end
		net.Send(player)
	end
end
