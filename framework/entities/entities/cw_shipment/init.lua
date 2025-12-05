
include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetHealth(50)
	self:SetSolid(SOLID_VPHYSICS)
	local physicsObject = self:GetPhysicsObject()

	if IsValid(physicsObject) then
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

-- Called each frame.
function ENT:Think()
	self:NextThink(CurTime() + 1)

	if not self:IsInWorld() then
		self:Remove()
	end
end

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

-- A function to set the item of the entity.
function ENT:SetItemTable(uniqueID, batch)
	local itemTable = Clockwork.item:FindByID(uniqueID)

	if itemTable then
		self.cwWeight = itemTable("weight") * batch
		self.cwSpace = itemTable("space") * batch
		self.cwItemTable = itemTable
		self.cwInventory = {}

		for i = 1, batch do
			Clockwork.inventory:AddInstance(self.cwInventory, Clockwork.item:CreateInstance(uniqueID))
		end

		self:SetModel(itemTable("shipmentModel", Clockwork.option:GetKey("model_shipment")))
		self:SetDTInt(0, itemTable("index"))
	end
end

-- A function to explode the entity.
function ENT:Explode(scale)
	local effectData = EffectData()
	effectData:SetStart(self:GetPos())
	effectData:SetOrigin(self:GetPos())
	effectData:SetScale(8)
	util.Effect("GlassImpact", effectData, true, true)
	self:EmitSound("physics/body/body_medium_impact_soft" .. math.random(1, 7) .. ".wav")
end

-- Called when the entity takes damage.
function ENT:OnTakeDamage(damageInfo)
	self:SetHealth(math.max(self:Health() - damageInfo:GetDamage(), 0))

	if self:Health() <= 0 then
		self:Explode()
		self:Remove()
	end
end

-- Called when the entity is removed.
function ENT:OnRemove()
	if not Clockwork.kernel:IsShuttingDown() and self.cwInventory then
		Clockwork.entity:DropItemsAndCash(self.cwInventory, nil, self:GetPos(), self)
		self.cwInventory = nil
	end
end
