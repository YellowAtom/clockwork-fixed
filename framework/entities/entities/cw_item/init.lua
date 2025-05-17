
include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetHealth(25)
	self:SetSolid(SOLID_VPHYSICS)
	
	-- Set up physics properties
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetCustomCollisionCheck(true)

	local physicsObject = self:GetPhysicsObject()

	if IsValid(physicsObject) then
		-- Enable drag to make physics more realistic
		physicsObject:SetDamping(0.1, 2)
		physicsObject:SetMass(5) -- Default mass, can be overridden by item table
		physicsObject:SetMaterial("default_silent") -- We'll handle sounds manually
		physicsObject:Wake()
		physicsObject:EnableMotion(true)
	end
	
	-- Store last collision time to prevent sound spam
	self.LastCollideTime = 0
	
	-- Store the material type for sound purposes
	self.MaterialType = self:GetMaterialType() or "cardboard"
end

-- Helper function to get material type from model or material
function ENT:GetMaterialType()
	-- First check if the item table specifies a material type
	local itemTable = self:GetItemTable()
	if itemTable and itemTable.soundType then
		return itemTable.soundType
	end
	
	-- Check model name for material hints
	local model = string.lower(self:GetModel() or "")
	if string.find(model, "metal", 1, true) then
		if string.find(model, "can", 1, true) or string.find(model, "bottle", 1, true) then
			return "metal_can"
		end
		return "metal"
	elseif string.find(model, "glass", 1, true) or string.find(model, "bottle", 1, true) then
		return "glass"
	elseif string.find(model, "wood", 1, true) then
		return "wood"
	elseif string.find(model, "plastic", 1, true) then
		return "plastic"
	elseif string.find(model, "paint", 1, true) or string.find(model, "spray", 1, true) then
		return "paintcan"
	elseif string.find(model, "can", 1, true) then
		return "metal_can"
	end
	
	-- Default to cardboard if no material type is detected
	return "cardboard"
end

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

-- A function to get the entity's item table.
function ENT:GetItemTable()
	return self.cwItemTable
end

-- A function to set the item of the entity.
function ENT:SetItemTable(itemTable)
	if itemTable then
		self:SetSkin(itemTable("skin", 1))
		self:SetModel(itemTable("model"))
		self:SetDTInt(0, itemTable("index"))

		if itemTable.OnCreated then
			itemTable:OnCreated(self)
		end

		self.cwItemTable = itemTable
		Clockwork.item:RemoveItemEntity(self)
		Clockwork.item:AddItemEntity(self, itemTable)
	end
end

-- Called when the entity is removed.
function ENT:OnRemove()
	local itemTable = self.cwItemTable

	if itemTable and itemTable.OnEntityRemoved then
		itemTable:OnEntityRemoved(self)
	end
end

-- A function to explode the entity.
function ENT:Explode()
	local effectData = EffectData()
	effectData:SetStart(self:GetPos())
	effectData:SetOrigin(self:GetPos())
	effectData:SetScale(8)
	util.Effect("GlassImpact", effectData, true, true)
	self:EmitSound("physics/body/body_medium_impact_soft" .. math.random(1, 7) .. ".wav")
end

-- Called when the entity takes damage.
function ENT:OnTakeDamage(damageInfo)
	local itemTable = self.cwItemTable
	if itemTable.OnEntityTakeDamage and itemTable:OnEntityTakeDamage(self, damageInfo) == false then return end
	Clockwork.plugin:Call("ItemEntityTakeDamage", self, itemTable, damageInfo)

	if damageInfo:GetDamage() > 0 then
		self:SetHealth(math.max(self:Health() - damageInfo:GetDamage(), 0))

		if self:Health() <= 0 then
			if itemTable.OnEntityDestroyed then
				itemTable:OnEntityDestroyed(self)
			end

			Clockwork.plugin:Call("ItemEntityDestroyed", self, itemTable)
			self:Explode()
			self:Remove()
		end
	end
end

-- Called when the entity collides with something
function ENT:PhysicsCollide(data, phys)
	local curTime = CurTime()
	
	-- Prevent sound spam
	if curTime - self.LastCollideTime < 0.1 then return end
	
	local speed = data.Speed
	local hitPos = data.HitPos
	local hitEntity = data.HitEntity
	
	-- Only play sounds for significant impacts
	if speed > 20 then -- Lowered threshold for all collisions
		self.LastCollideTime = curTime
		
		-- Get the item table for custom sound handling
		local itemTable = self:GetItemTable()
		local soundType = itemTable and itemTable.soundType or self.MaterialType
		
		-- Default to concrete for world, check entity materials otherwise
		local surfaceMaterial = "concrete"
		if IsValid(hitEntity) and not hitEntity:IsWorld() then
			-- For entities, try to get the physics material
			local physObj = hitEntity:GetPhysicsObject()
			if IsValid(physObj) then
				surfaceMaterial = string.lower(physObj:GetMaterial() or "")
			end
		end
		
		-- Map the material to our sound types
		if surfaceMaterial == "default_silent" or surfaceMaterial == "default" or surfaceMaterial == "" then
			surfaceMaterial = "concrete"
		elseif string.find(surfaceMaterial, "metal", 1, true) or string.find(surfaceMaterial, "canister", 1, true) then
			surfaceMaterial = "metal"
		elseif string.find(surfaceMaterial, "glass", 1, true) then
			surfaceMaterial = "glass"
		elseif string.find(surfaceMaterial, "wood", 1, true) then
			surfaceMaterial = "wood"
		elseif string.find(surfaceMaterial, "plastic", 1, true) then
			surfaceMaterial = "plastic"
		elseif string.find(surfaceMaterial, "dirt", 1, true) or 
			   string.find(surfaceMaterial, "grass", 1, true) or 
			   string.find(surfaceMaterial, "sand", 1, true) then
			surfaceMaterial = "dirt"
		elseif string.find(surfaceMaterial, "flesh", 1, true) or 
			   string.find(surfaceMaterial, "body", 1, true) then
			surfaceMaterial = "flesh"
		elseif string.find(surfaceMaterial, "plaster", 1, true) then
			surfaceMaterial = "plaster"
		elseif string.find(surfaceMaterial, "rubber", 1, true) then
			surfaceMaterial = "rubber"
		end
		
		-- Default sound properties
		local volume = math.Clamp(speed / 300, 0.1, 1.0)
		local pitch = math.random(90, 110)
		local soundName
		
		-- Select sound based on material type
		local soundVariation = math.random(1, 3)
		
		if soundType == "metal" then
			soundName = "physics/metal/metal_box_impact_hard" .. soundVariation .. ".wav"
		elseif soundType == "metal_can" then
			soundName = "physics/metal/soda_can_impact_hard" .. soundVariation .. ".wav"
		elseif soundType == "glass" then
			soundName = "physics/glass/glass_bottle_impact_hard" .. soundVariation .. ".wav"
		elseif soundType == "wood" then
			soundName = "physics/wood/wood_box_impact_hard" .. soundVariation .. ".wav"
		elseif soundType == "plastic" then
			soundName = "physics/plastic/plastic_box_impact_hard" .. soundVariation .. ".wav"
		elseif soundType == "paintcan" then
			soundName = "physics/metal/paintcan_impact_hard" .. soundVariation .. ".wav"
		elseif soundType == "flesh" or soundType == "body" then
			soundName = "physics/flesh/flesh_impact_hard" .. math.random(1, 6) .. ".wav"
		elseif soundType == "plaster" then
			soundName = "physics/plaster/drywall_impact_hard" .. math.random(1, 3) .. ".wav"
		elseif soundType == "rubber" then
			soundName = "physics/rubber/rubber_tire_impact_hard" .. math.random(1, 3) .. ".wav"
		else
			soundName = "physics/cardboard/cardboard_box_impact_hard" .. soundVariation .. ".wav"
		end
		
		-- Adjust volume based on surface material
		if surfaceMaterial == "metal" or surfaceMaterial == "canister" then
			volume = volume * 1.2
		elseif surfaceMaterial == "metal_can" then
			volume = volume * 1.1
		elseif surfaceMaterial == "glass" then
			volume = volume * 1.3
		elseif surfaceMaterial == "dirt" or surfaceMaterial == "grass" or surfaceMaterial == "sand" then
			volume = volume * 0.6
		elseif surfaceMaterial == "paintcan" then
			volume = volume * 1.1
		elseif surfaceMaterial == "flesh" or surfaceMaterial == "body" then
			volume = volume * 0.8
		elseif surfaceMaterial == "plaster" then
			volume = volume * 0.7
		elseif surfaceMaterial == "rubber" then
			volume = volume * 0.9
		end
		
		-- Allow item table to override sound behavior
		if itemTable and itemTable.OnEntityCollide then
			local customSound, customVolume, customPitch = itemTable:OnEntityCollide(self, data, soundName, volume, pitch)
			if customSound then soundName = customSound end
			if customVolume then volume = customVolume end
			if customPitch then pitch = customPitch end
		end
		
		-- Play the impact sound at the collision position
		sound.Play(soundName, hitPos, 75, math.Clamp(pitch, 50, 255), math.Clamp(volume, 0, 1))
		

	end
end

-- Called each frame.
function ENT:Think()
	local itemTable = self.cwItemTable;
	
	if (itemTable and itemTable.OnEntityThink) then
		local nextThink = itemTable:OnEntityThink(self);
		
		if (type(nextThink) == "number") then
			self:NextThink(CurTime() + nextThink);
			return true;
		end;
	end;
end;
