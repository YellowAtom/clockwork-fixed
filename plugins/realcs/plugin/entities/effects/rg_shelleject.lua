--this was made by TetaBonita, not me...

function EFFECT:Init(data)
	selfEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	if not (selfEnt:IsValid() and selfEnt:IsWeapon()) then return end
	self.Normal = data:GetNormal()

	if selfEnt:IsCarriedByLocalPlayer() and GetViewEntity() == LocalPlayer() then
		local ViewModel = LocalPlayer():GetViewModel()
		if not ViewModel:IsValid() then return end
		self.EjectionPort = ViewModel:GetAttachment(self.Attachment)
		if not self.EjectionPort then return end
		self.Angle = self.EjectionPort.Ang
		self.Forward = self.Angle:Forward()
		self.Position = self.EjectionPort.Pos
	else
		self.EjectionPort = selfEnt:GetAttachment(self.Attachment)
		if not self.EjectionPort then return end
		self.Forward = self.Normal:Angle():Right()
		self.Angle = self.Forward:Angle()
		self.Position = self.EjectionPort.Pos - (0.5 * selfEnt:BoundingRadius()) * self.EjectionPort.Ang:Forward()
	end

	local AddVel = selfEnt:GetOwner():GetVelocity()
	local effectdata = EffectData()
	effectdata:SetOrigin(self.Position)
	effectdata:SetAngles(self.Angle)
	effectdata:SetEntity(selfEnt)
	util.Effect("ShellEject", effectdata)
	local emitter = ParticleEmitter(self.Position)

	for i = 1, 2 do
		local particle = emitter:Add("particle/particle_smokegrenade", self.Position)
		particle:SetVelocity(6 * i * self.Forward + 1.02 * AddVel)
		particle:SetDieTime(math.Rand(0.33, 0.35))
		particle:SetStartAlpha(math.Rand(50, 60))
		particle:SetStartSize(1)
		particle:SetEndSize(math.Rand(2, 3) * i)
		particle:SetRoll(math.Rand(180, 480))
		particle:SetRollDelta(math.Rand(-1, 1))
		particle:SetColor(245, 245, 245)
		particle:SetLighting(true)
		particle:SetAirResistance(40)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
