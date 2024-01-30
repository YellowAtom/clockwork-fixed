
if CLIENT then
	SWEP.PrintName = "Benelli M3 Super 90"
	SWEP.Author = "cheesylard"
	SWEP.SlotPos = 2
	SWEP.IconLetter = "k"
	SWEP.NameOfSWEP = "rcs_m3" --always make this the name of the folder the SWEP is in.
	killicon.AddFont(SWEP.NameOfSWEP, "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255))
end

SWEP.Category = "HL2RP - CS"
SWEP.Base = "rcs_base"
SWEP.HoldType = "crossbow"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.IsShotgun = true
SWEP.ViewModel = "models/weapons/v_shot_m3super92.mdl"
SWEP.WorldModel = "models/weapons/w_shot_m3super90.mdl"
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Primary.Sound = Sound("Weapon_M3.Single")
SWEP.ReloadSnd = Sound("Weapon_Shotgun.Reload")
SWEP.Primary.Recoil = 5
SWEP.Primary.Damage = 20
SWEP.Primary.NumShots = 8
SWEP.Primary.Cone = 0.05
SWEP.Primary.ClipSize = 8
SWEP.Primary.Delay = 0.95
SWEP.Primary.DefaultClip = 16
SWEP.Primary.Automatic = true
SWEP.IncreasesSpread = false --does not do the spread thing, it's a shotgun
SWEP.Primary.Ammo = "buckshot"
SWEP.EjectDelay = 0.53
SWEP.Primary.MaxSpread = 0.15 --the maximum amount the spread can go by, best left at 0.20 or lower
SWEP.Primary.Handle = 0.5 --how many seconds you have to wait between each shot before the spread is at its best
SWEP.Primary.SpreadIncrease = 0.21 / 15 --how much you add to the cone after each shot
SWEP.MoveSpread = 1 --multiplier for spread when you are moving
SWEP.JumpSpread = 3 --multiplier for spread when you are jumping
SWEP.CrouchSpread = 1 --multiplier for spread when you are crouching
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.IronSightsPos = Vector(5.7779, 0, 3.3952)
SWEP.IronSightsAng = Vector(0, 0, 0)

--[[
function SWEP:CanPrimaryAttack()

	if (self:Clip1() <= 0) then
	
		if (self:GetNetworkedBool("reloading", false)) then return end
	
		-- Start reloading if we can
		if (self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
			self.Reloading = "yes"
			self:SetNetworkedBool("reloading", true)
			self:SetVar("reloadtimer", CurTime() + 0.5)
			self:SetNextPrimaryFire(CurTime() + 0.49)
			self:SendWeaponAnim(ACT_VM_RELOAD)
			self:SetIronsights(false)
		end
	
	return false
	end

return true
end
]]
function SWEP:RCSAttack1()
	self:SetNWBool("reloading", false)
	self.Reloading = "no"
end

--[[function SWEP:RCSReload()
	if (self:GetNetworkedBool("reloading", false)) then return end
	
	--// Start reloading if we can
	if (self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		
		self:SetNetworkedBool("reloading", true)
		self:SetVar("reloadtimer", CurTime() + 0.5)
		self.Reloading = "yes"
		
		self:SetNextPrimaryFire(CurTime() + 0.49)
		self:SendWeaponAnim(ACT_VM_RELOAD)
		self:SetIronsights(false)
		
	end

end]]
function SWEP:RCSHolster()
	self:RCSAttack1()
end

function SWEP:RCSThink()
	local owner = self:GetOwner()

	if self:Clip1() > self.Primary.ClipSize then
		self:SetClip1(self.Primary.ClipSize)
	end

	--timer.Simple(0.5, function() self:TReloadShotty() end)
	if self:GetNWBool("reloading") == true then
		if self:GetNWInt("reloadtimer") < CurTime() then
			if self.unavailable then return end

			--r/e/a//l/cs w/a/s m/ad/e b/y/ c h/ee/syl a/r/ /d
			--// Finish filling, final pump
			if (self:Clip1() >= self.Primary.ClipSize or owner:GetAmmoCount(self.Primary.Ammo) <= 0) and self:GetNWInt("reloadtimer") < CurTime() then
				--//if (self.Reloading == "yes") then
				local o = CurTime() + .5
				self:SetNextPrimaryFire(o)
				self:SetNextPrimaryFire(o)
				self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
				self:SetNWBool("reloading", false)

				if self.PlayReloadSounds then
					if not self.nextReloadSound or CurTime() >= self.nextReloadSound then
						self.nextReloadSound = CurTime() + 1
						owner:EmitSound("weapons/shotgun/shotgun_cock.wav")
					end
				end
				--//self.Reloading = "no"
				--//end
			else
				if self.PlayReloadSounds then
					owner:EmitSound(self.ReloadSnd, math.random(50, 80))
				end

				--// Next cycle
				self:SetNWInt("reloadtimer", CurTime() + .5)
				self:SendWeaponAnim(ACT_VM_RELOAD)
				owner:RemoveAmmo(1, self.Primary.Ammo, false)
				self:SetClip1(self:Clip1() + 1)

				if self:Clip1() >= self.Primary.ClipSize or owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
					self:SetNextPrimaryFire(CurTime() + 1.5)
					self:SetNextSecondaryFire(CurTime() + 1.5)
				else
					self:SetNextPrimaryFire(CurTime() + .49)
					self:SetNextSecondaryFire(CurTime() + .5)
				end
			end
		end
	end
end