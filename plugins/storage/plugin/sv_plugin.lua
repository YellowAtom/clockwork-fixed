
Clockwork.datastream:Hook("ContainerPassword", function(player, data)
	local password = data[1]
	local entity = data[2]

	if IsValid(entity) and Clockwork.entity:IsPhysicsEntity(entity) then
		local model = string.lower(entity:GetModel())

		if cwStorage.containerList[model] then
			local containerWeight = cwStorage.containerList[model][1]

			if entity.cwPassword == password then
				-- Mark the password as used to prevent automatic removal
				entity.cwPasswordUsed = true
				entity.cwLastPasswordTime = CurTime()
				-- Password used
				
				-- Function to reset password removal timer
				local function resetPasswordTimer()
					-- Cancel existing timer if it exists
					if timer.Exists("StoragePasswordRemoval" .. entity:EntIndex()) then
						timer.Remove("StoragePasswordRemoval" .. entity:EntIndex())
					end
					
					-- Create new timer for 30 days
					timer.Create("StoragePasswordRemoval" .. entity:EntIndex(), 2592000, 1, function()
						if not IsValid(entity) then return end

						-- Remove password if not used for 30 days
						local currentTime = CurTime()
						local lastPasswordTime = entity.cwLastPasswordTime or 0
						local timeSinceLastUse = currentTime - lastPasswordTime

						-- Only remove if no password usage for 30 days
						if timeSinceLastUse > 2592000 and not entity.cwPasswordUsed then
							entity.cwPassword = nil
							if entity.SetPassword then
								entity:SetPassword(nil)
							end
						else
							-- Reset timer if password was used or too recent
							resetPasswordTimer()
						end
					end)
				end
				
				-- Initial timer creation
				resetPasswordTimer()
				
				cwStorage:OpenContainer(player, entity, containerWeight)
			else
				Clockwork.player:Notify(player, "You have entered an incorrect password!")
			end
		end
	end
end)

-- A function to get a random item.
function cwStorage:GetRandomItem(uniqueID)
	if uniqueID then
		uniqueID = string.lower(uniqueID)
	end

	if #self.randomItems <= 0 then return end
	local randomItem = self.randomItems[math.random(1, #self.randomItems)]

	if randomItem then
		local itemTable = Clockwork.item:FindByID(randomItem[1])
		if not uniqueID or string.find(string.lower(itemTable("category")), uniqueID) then return randomItem end
	end

	return self:GetRandomItem(uniqueID, runs)
end

function cwStorage:CategoryExists(uniqueID)
	if uniqueID then
		local uniqueID = string.lower(uniqueID)

		for i = 1, #self.randomItems do
			local item = Clockwork.item:FindByID(self.randomItems[i][1])
			if string.find(string.lower(item("category")), uniqueID) then return true end
		end

		return false
	else
		return false
	end
end

-- A function to save the storage.
function cwStorage:SaveStorage()
	local storage = {}

	for k, v in pairs(self.storage) do
		if IsValid(v) then
			if v.cwInventory and v.cwCash then
				local physicsObject = v:GetPhysicsObject()
				local bMoveable = nil
				local startPos = v:GetStartPosition()
				local model = v:GetModel()
				local skin = v:GetSkin()
				local material = v:GetMaterial()
				local color = v:GetColor()
				local renderMode = v:GetRenderMode()
				local renderFX = v:GetRenderFX()
				local bNoCollision = v:GetCollisionGroup() == COLLISION_GROUP_WORLD

				if IsValid(physicsObject) then
					bMoveable = physicsObject:IsMoveable()
				end

				storage[#storage + 1] = {
					name = v:GetNWString("Name"),
					model = model,
					skin = skin,
					material = material,
					cash = v.cwCash,
					color = color,
					renderMode = renderMode,
					renderFX = renderFX,
					angles = v:GetAngles(),
					position = v:GetPos(),
					message = v.cwMessage,
					password = v.cwPassword,
					startPos = startPos,
					inventory = Clockwork.inventory:ToSaveable(v.cwInventory),
					bNoCollision = bNoCollision,
					isMoveable = bMoveable
				}
			end
		end
	end

	Clockwork.kernel:SaveSchemaData("plugins/storage/" .. game.GetMap(), storage)
end

-- A function to load the storage.
function cwStorage:LoadStorage()
	local storage = Clockwork.kernel:RestoreSchemaData("plugins/storage/" .. game.GetMap())
	self.storage = {}

	for k, v in pairs(storage) do
		local entity = ents.Create("prop_physics")
		entity:SetAngles(v.angles)
		entity:SetModel(v.model)
		entity:SetMaterial(v.material)
		entity:SetSkin(v.skin or 0)
		entity:SetPos(v.position)
		
		if v.bNoCollision == nil or v.bNoCollision then
			entity:SetCollisionGroup(COLLISION_GROUP_WORLD)
		end
		
		if not v.renderMode then
			v.renderMode = 0
			v.renderFX = 0
		end

		if v.color.a < 255 and v.renderMode == 0 then
			v.renderMode = 1
		end
		
		entity:SetColor(v.color)
		entity:SetRenderMode(v.renderMode)
		entity:SetRenderFX(v.renderFX)
		entity:Spawn()

		if IsValid(entity:GetPhysicsObject()) then
			if not v.isMoveable then
				entity:GetPhysicsObject():EnableMotion(false)
			end
		end

		if v.name ~= "" then
			entity:SetNWString("Name", v.name)
		end

		self.storage[entity] = entity
		entity.cwInventory = Clockwork.inventory:ToLoadable(v.inventory)
		entity.cwPassword = v.password
		entity.cwMessage = v.message
		entity.cwCash = v.cash
	end
end

-- A function to open a container for a player.
function cwStorage:OpenContainer(player, entity, weight)
	local inventory
	local cash = 0
	local model = string.lower(entity:GetModel())
	local name = ""

	if not entity.cwInventory then
		self.storage[entity] = entity
		entity.cwInventory = {}
	end

	if not entity.cwCash then
		entity.cwCash = 0
	end

	if self.containerList[model] then
		name = self.containerList[model][2]
	else
		name = "Container"
	end

	inventory = entity.cwInventory
	cash = entity.cwCash

	if not weight then
		weight = 8
	end

	if entity:GetNWString("Name") ~= "" then
		name = entity:GetNWString("Name")
	end

	if entity.cwMessage then
		Clockwork.datastream:Start(player, "StorageMessage", {
			entity = entity,
			message = entity.cwMessage
		})
	end

	Clockwork.storage:Open(player, {
		name = name,
		weight = weight,
		entity = entity,
		distance = 192,
		cash = cash,
		inventory = inventory,
		OnGiveCash = function(player, storageTable, cash)
			storageTable.entity.cwCash = storageTable.cash
		end,
		OnTakeCash = function(player, storageTable, cash)
			storageTable.entity.cwCash = storageTable.cash
		end
	})
end
