
if SERVER then
	AddCSLuaFile()

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
	SWEP.Slot = 5
	SWEP.SlotPos = 2
	SWEP.DrawAmmo = false
	SWEP.PrintName = "Keys"
	SWEP.DrawCrosshair = true
end

SWEP.Instructions = "Primary Fire: Lock.\nSecondary Fire: Unlock."
SWEP.Purpose = "Locking and unlocking entities that you have access to."
SWEP.Author = "CloudSixteen"
SWEP.Category = "Clockwork"
SWEP.WorldModel = ""
SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.HoldType = "fist"
SWEP.AdminSpawnable = false
SWEP.Spawnable = false
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.Damage = 1
SWEP.Primary.Ammo = ""
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Ammo = ""
SWEP.NoIronSightFovChange = true
SWEP.NoIronSightAttack = true
SWEP.IronSightPos = Vector(0, 0, 0)
SWEP.IronSightAng = Vector(0, 0, 0)
SWEP.NeverRaised = true
SWEP.LoweredAngles = Angle(0.000, 0.000, -22.000)

-- Called when the SWEP is deployed.
function SWEP:Deploy()
	local owner = self:GetOwner()

	local vm = owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_draw"))

	return true
end

-- Called when the SWEP is holstered.
function SWEP:Holster(switchingTo)
	self:SendWeaponAnim(ACT_VM_HOLSTER)

	return true
end

-- Called when the player attempts to primary fire.
function SWEP:PrimaryAttack()
	local owner = self:GetOwner()

	self:SetNextPrimaryFire(CurTime() + 1)

	if SERVER then
		local action = Clockwork.player:GetAction(owner)
		local trace = owner:GetEyeTraceNoCursor()
		if owner:GetPos():Distance(trace.HitPos) > 192 or not IsValid(trace.Entity) then return end
		local info = Clockwork.plugin:Call("PlayerGetLockInfo", owner, trace.Entity)

		if info and Clockwork.plugin:Call("PlayerCanLockEntity", owner, trace.Entity) then
			local isNotUnlocking = action ~= "unlock"
			local isNotLocking = action ~= "lock"

			if isNotLocking or isNotUnlocking then
				Clockwork.player:SetAction(owner, "lock", info.duration)

				Clockwork.player:EntityConditionTimer(owner, trace.Entity, nil, info.duration, 192, function() return Clockwork.plugin:Call("PlayerCanLockEntity", owner, trace.Entity) and owner:Alive() and not owner:IsRagdolled() and owner:IsUsingKeys() end, function(success)
					if success then
						info.Callback(owner, trace.Entity)

						if not info.noSound then
							owner:EmitSound("doors/door_latch3.wav")
						end
					else
						Clockwork.player:SetAction(owner, "lock", false)
					end
				end)
			end
		end
	end
end

-- Called when the player attempts to secondary fire.
function SWEP:SecondaryAttack()
	local owner = self:GetOwner()

	self:SetNextSecondaryFire(CurTime() + 1)

	if SERVER then
		local action = Clockwork.player:GetAction(owner)
		local trace = owner:GetEyeTraceNoCursor()
		if owner:GetPos():Distance(trace.HitPos) > 192 or not IsValid(trace.Entity) then return end
		local info = Clockwork.plugin:Call("PlayerGetUnlockInfo", owner, trace.Entity)

		if info and Clockwork.plugin:Call("PlayerCanUnlockEntity", owner, trace.Entity) then
			local isNotUnlocking = action ~= "unlock"
			local isNotLocking = action ~= "lock"

			if isNotLocking or isNotUnlocking then
				Clockwork.player:SetAction(owner, "unlock", info.duration)

				Clockwork.player:EntityConditionTimer(owner, trace.Entity, nil, info.duration, 192, function() return Clockwork.plugin:Call("PlayerCanUnlockEntity", owner, trace.Entity) and owner:Alive() and not owner:IsRagdolled() and owner:IsUsingKeys() end, function(success)
					if success then
						info.Callback(owner, trace.Entity)

						if not info.noSound then
							owner:EmitSound("doors/door_latch3.wav")
						end
					else
						Clockwork.player:SetAction(owner, "unlock", false)
					end
				end)
			end
		end
	end
end
