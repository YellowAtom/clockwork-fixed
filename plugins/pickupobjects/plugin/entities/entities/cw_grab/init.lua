
Clockwork.kernel:IncludePrefixed("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/weapons/w_bugbait.mdl")
	self:SetSolid(SOLID_NONE)
	self:PhysicsInit(SOLID_BBOX)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self.cwComputePos = Vector(0, 0, 0)
	self.cwTargetAngle = Angle(0, 0, 0)
	self.cwPlayer = NULL
	local physicsObject = self:GetPhysicsObject()

	if IsValid(physicsObject) then
		physicsObject:SetMass(2048)
		physicsObject:Wake()
	end
end

-- Called when the entity is used.
function ENT:Use(activator, caller)
end

-- Called each frame.
function ENT:Think()
	if IsValid(self.cwPlayer) and IsValid(self.cwTargetEnt) and cwPickupObjects then
		if not cwPickupObjects:CalculatePosition(self.cwPlayer) then
			cwPickupObjects:ForceDropEntity(self.cwPlayer)
		end
	else
		self:Remove()
	end
end

-- A function to set the entity's compute position.
function ENT:SetComputePosition(position)
	self.cwComputePos = position
end

-- A function to set the entity's player.
function ENT:SetPlayer(player)
	self.cwPlayer = player
end

-- A function to set the entity's target.
function ENT:SetTarget(target)
	self.cwTargetEnt = target

	if IsValid(target) then
		self.cwTargetAngle = target:GetAngles()
	end
end

-- A function to apply a rotation delta to the target angle.
function ENT:ApplyRotation(pitch, yaw)
	if not self.cwIsRotating then
		self.cwTargetAngle = self:GetAngles()
	end

	self.cwIsRotating = true
	self.cwLastRotateTime = CurTime()

	-- Rotate around stable, view-relative world axes instead of the object's own
	-- (already-tumbled) axes, so the motion always matches the player's mouse:
	--   yaw  -> world up (turntable spin)
	--   pitch-> the player's horizontal right axis (tilt toward/away)
	-- Using fixed axes also avoids the unwanted roll that local-axis rotation
	-- accumulates when the mouse moves in a circle.
	local yawAxis = vector_up
	local rightAxis = Vector(0, -1, 0)

	if IsValid(self.cwPlayer) then
		rightAxis = Angle(0, self.cwPlayer:EyeAngles().yaw, 0):Right()
	end

	self.cwTargetAngle:RotateAroundAxis(yawAxis, yaw)
	self.cwTargetAngle:RotateAroundAxis(rightAxis, pitch)
end

-- Called when the physics should be simulated.
function ENT:PhysicsSimulate(physicsObject, deltaTime)
	if IsValid(self.cwTargetEnt) then
		local targetPhysicsObject = self.cwTargetEnt:GetPhysicsObject()

		if IsValid(targetPhysicsObject) then
			targetPhysicsObject:Wake()
		end
	end

	physicsObject:Wake()

	-- Only override angle when actively rotating, otherwise let physics be natural.
	local angle = self:GetAngles()

	if self.cwIsRotating then
		if self.cwLastRotateTime and CurTime() - self.cwLastRotateTime > 0.1 then
			self.cwIsRotating = false
		else
			angle = self.cwTargetAngle
		end
	end

	physicsObject:ComputeShadowControl({
		secondstoarrive = 0.01,
		teleportdistance = 128,
		maxangulardamp = 10000,
		maxspeeddamp = 10000,
		dampfactor = 0.8,
		deltatime = deltaTime,
		maxangular = 512,
		maxspeed = 256,
		angle = angle,
		pos = self.cwComputePos
	})
end
