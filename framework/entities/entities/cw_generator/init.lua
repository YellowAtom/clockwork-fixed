
include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetSolid(SOLID_VPHYSICS)
	local physicsObject = self:GetPhysicsObject()

	if IsValid(physicsObject) then
		physicsObject:Wake()
		physicsObject:EnableMotion(true)
	end
	
	-- Track last collision time to prevent sound spam
	self.LastCollisionSound = 0

	local generator = Clockwork.generator:FindByID(self:GetClass())

	if generator then
		self:SetHealth(generator.health)
		self:SetDTInt(0, generator.power)

		timer.Simple(1, function()
			if IsValid(self) and self.OnCreated then
				self:OnCreated()
			end
		end)
	else
		timer.Simple(1, function()
			if IsValid(self) then
				self:Remove()
			end
		end)
	end
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

-- Called when the entity takes damage.
function ENT:OnTakeDamage(damageInfo)
	local generator = Clockwork.generator:FindByID(self:GetClass())
	local attacker = damageInfo:GetAttacker()

	if generator and IsValid(attacker) and attacker:IsPlayer() then
		if self.AdjustDamage then
			self:AdjustDamage(damageInfo)
		end

		if Clockwork.plugin:Call("PlayerCanDestroyGenerator", attacker, self, generator) and damageInfo:GetDamage() > 0 then
			self:SetHealth(math.max(self:Health() - damageInfo:GetDamage(), 0))

			if self:Health() <= 0 then
				if IsValid(attacker) and attacker:IsPlayer() then
					Clockwork.plugin:Call("PlayerDestroyGenerator", attacker, self, generator)
				end

				if self.OnDestroy then
					self:OnDestroy(attacker, damageInfo)
				end

				self:Explode()
				self:Remove()
			end
		end
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
