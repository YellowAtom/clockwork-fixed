
if SERVER then
	AddCSLuaFile()
--	resource.AddFile("models/weapons/w_fists_t.mdl")

	SWEP.ActivityTranslate = {
		[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST,
		[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_FIST,
		[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_FIST,
		[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH_FIST,
		[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK1,
		[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_FIST,
		[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_FIST,
		[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_FIST,
		[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_FIST
	}
end

if CLIENT then
	SWEP.PrintName = "Hands"
	SWEP.Author = "CloudSixteen"
	SWEP.Instructions = "Primary Fire: Hit.\nSecondary Fire: Knock on a door."
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
	SWEP.DrawSecondaryAmmo = false
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false
end

SWEP.Category = "Clockwork"
SWEP.HoldType = "fist"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.WorldModel = ""
SWEP.UseHands = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.Damage = 6
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.DrawAmmo = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Damage = 100
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""
SWEP.WallSound = Sound("Flesh.ImpactHard")
SWEP.SwingSound = Sound("npc/vort/claw_swing2.wav")
SWEP.HitDistance = 38
SWEP.LoweredAngles = Angle(0.000, 0.000, -90.000)

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_draw"))
	self:SetNextPrimaryFire(CurTime() + 1)

	return true
end

function SWEP:PrimaryAttack()
	local owner = self:GetOwner()

	if Clockwork.plugin:Call("PlayerCanThrowPunch", owner) then
		self:PlayPunchAnimation()
		owner:SetAnimation(PLAYER_ATTACK1)
		self:SetNextPrimaryFire(CurTime() + 0.5)
		self:SetNextSecondaryFire(CurTime() + 0.7)

		timer.Simple(0, function()
			self:EmitSound(self.SwingSound)
		end)

		local trace = owner:GetEyeTraceNoCursor()

		if owner:GetShootPos():Distance(trace.HitPos) <= 64 then
			if IsValid(trace.Entity) then
				if trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:GetClass() == "prop_ragdoll" then
					if trace.Entity:IsPlayer() and trace.Entity:Health() - self.Primary.Damage <= 10 and Clockwork.plugin:Call("PlayerCanPunchKnockout", owner, trace.Entity) then
						Clockwork.player:SetRagdollState(trace.Entity, RAGDOLL_KNOCKEDOUT, 15)
						Clockwork.plugin:Call("PlayerPunchKnockout", owner, trace.Entity)
					elseif Clockwork.plugin:Call("PlayerCanPunchEntity", owner, trace.Entity) then
						self:PunchEntity()
						Clockwork.plugin:Call("PlayerPunchEntity", owner, trace.Entity)
					end

					if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
						local normal = trace.Entity:GetPos() - owner:GetPos()
						normal:Normalize()
						local push = 128 * normal
						trace.Entity:SetVelocity(push)
					end
				elseif IsValid(trace.Entity:GetPhysicsObject()) then
					if Clockwork.plugin:Call("PlayerCanPunchEntity", owner, trace.Entity) then
						self:PunchEntity()
						Clockwork.plugin:Call("PlayerPunchEntity", owner, trace.Entity)
					end
				elseif trace.Hit then
					self:PunchEntity()
				end
			elseif trace.Hit then
				self:PunchEntity()
			end
		end

		Clockwork.plugin:Call("PlayerPunchThrown", owner)

		local info = {
			primaryFire = 0.5,
			secondaryFire = 0.5
		}

		Clockwork.plugin:Call("PlayerAdjustNextPunchInfo", owner, info)
		self:SetNextPrimaryFire(CurTime() + info.primaryFire)
		self:SetNextSecondaryFire(CurTime() + info.secondaryFire)
		owner:ViewPunch(Angle(math.Rand(-16, 16), math.Rand(-8, 8), 0))
	end
end

function SWEP:SecondaryAttack()
	if SERVER then
		local trace = self:GetOwner():GetEyeTraceNoCursor()

		if IsValid(trace.Entity) and Clockwork.entity:IsDoor(trace.Entity) then
			if self:GetOwner():GetShootPos():Distance(trace.HitPos) <= 64 then
				if Clockwork.plugin:Call("PlayerCanKnockOnDoor", self:GetOwner(), trace.Entity) then
					self:PlayKnockSound()
					self:SetNextPrimaryFire(CurTime() + 0.25)
					self:SetNextSecondaryFire(CurTime() + 0.25)
					Clockwork.plugin:Call("PlayerKnockOnDoor", self:GetOwner(), trace.Entity)
				end
			end
		end
	end
end

function SWEP:PlayKnockSound()
	if SERVER then
		self:CallOnClient("PlayKnockSound", "")
	end

	self:EmitSound("physics/wood/wood_crate_impact_hard2.wav")
end

function SWEP:Reload()
	return false
end

function SWEP:OnRemove()
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:ShootEffects()
end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextMeleeAttack")
	self:NetworkVar("Float", 1, "NextIdle")
end

function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle(CurTime() + vm:SequenceDuration())
end

function SWEP:PunchEntity()
	local startPosition = self:GetOwner():GetShootPos()
	local finishPosition = startPosition + self:GetOwner():GetAimVector() * 64

	local traceLineAttack = util.TraceLine({
		start = startPosition,
		endpos = finishPosition,
		filter = self:GetOwner()
	})

	timer.Simple(0.32, function()
		self:EmitSound(self.WallSound)
	end)

	if SERVER then
		self:CallOnClient("PunchEntity", "")

		if IsValid(traceLineAttack.Entity) then
			traceLineAttack.Entity:TakeDamageInfo(Clockwork.kernel:FakeDamageInfo(self.Primary.Damage, self, self:GetOwner(), traceLineAttack.HitPos, DMG_SLASH, 1))
		end
	end
end

function SWEP:PlayPunchAnimation()
	if SERVER then
		self:CallOnClient("PlayPunchAnimation", "")
	end

	if self.left == nil then
		self.left = true
	else
		self.left = not self.left
	end

	local anim = "fists_right"
	local ownerAnim = PLAYER_ATTACK1

	if self.left then
		anim = "fists_left"
	end

	local vm = self:GetOwner():GetViewModel()
	self:GetOwner():SetAnimation(ownerAnim)
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
end
