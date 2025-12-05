
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
		physicsObject:SetDamping(0.1, 2)
		physicsObject:SetMass(5)
		physicsObject:Wake()
		physicsObject:EnableMotion(true)
	end
	
	-- Track last collision time to prevent sound spam
	self.LastCollisionSound = 0
end

-- Called when the entity collides with something
-- Note: SENTs don't play native physics sounds (GMod bug), so we handle it manually
function ENT:PhysicsCollide(data, phys)
	local curTime = CurTime()
	
	-- Prevent sound spam (100ms cooldown)
	if curTime - self.LastCollisionSound < 0.1 then return end
	
	local speed = data.Speed
	if speed < 20 then return end
	
	self.LastCollisionSound = curTime
	
	-- Get surface property from the model's physics object
	local surfaceProp = phys:GetMaterial()
	local surfaceData = util.GetSurfaceData(util.GetSurfaceIndex(surfaceProp))
	
	if surfaceData then
		-- Use the model's native impact sound
		local volume = math.Clamp(speed / 300, 0.1, 1.0)
		local soundName = speed > 100 and surfaceData.impactHardSound or surfaceData.impactSoftSound
		
		if soundName and soundName ~= "" then
			sound.Play(soundName, data.HitPos, 75, math.random(95, 105), volume)
		end
	end
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
