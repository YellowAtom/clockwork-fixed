--REAL CS BASE
--sorry for no comments to show what everything does im too lazy to do it LOL!
if SERVER then
	SWEP.Weight = 5
end

if CLIENT then
	SWEP.PrintName = "M249"
	SWEP.Author = "cheesylard"
	SWEP.SlotPos = 1
	SWEP.IconLetter = "z"
	SWEP.ViewModelFlip = false
	SWEP.NameOfSWEP = "rcs_m249" --always make this the name of the folder the SWEP is in
	killicon.AddFont(SWEP.NameOfSWEP, "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255))
end

SWEP.HoldType = "ar2"
SWEP.Category = "HL2RP - CS"
SWEP.Base = "rcs_base"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/v_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"
SWEP.Penetrating = true
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Primary.MaxSpread = 0.15 --the maximum amount the spread can go by, best left at 0.20 or lower
SWEP.Primary.Handle = 0.4 --how many seconds you have to wait between each shot before the spread is at its best
SWEP.Primary.SpreadIncrease = 0.18 / 15 --how much you add to the cone after each shot
SWEP.Primary.Sound = Sound("Weapon_M249.Single")
SWEP.Primary.Recoil = 0.45
SWEP.Primary.Damage = 30
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.001
SWEP.Primary.ClipSize = 100
SWEP.Primary.Delay = 0.1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.MaxReserve = 200
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.MoveSpread = 3 --multiplier for spread when you are moving
SWEP.JumpSpread = 5 --multiplier for spread when you are jumping
SWEP.CrouchSpread = 0.6 --multiplier for spread when you are crouching
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.IronSightsPos = Vector(-4.4153, 0, 2.1305)
SWEP.IronSightsAng = Vector(0, 0, 0)