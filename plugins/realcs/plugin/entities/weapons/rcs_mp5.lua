--REAL CS BASE
--sorry for no comments to show what everything does im too lazy to do it LOL!
if SERVER then
	SWEP.Weight = 5
end

if CLIENT then
	SWEP.PrintName = "MP5"
	SWEP.Author = "cheesylard"
	SWEP.SlotPos = 1
	SWEP.IconLetter = "x"
	SWEP.NameOfSWEP = "rcs_mp5" --always make this the name of the folder the SWEP is in.
	killicon.AddFont(SWEP.NameOfSWEP, "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255))
end

SWEP.Category = "HL2RP - CS"
SWEP.Base = "rcs_base"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.HoldType = "ar2"
SWEP.ViewModel = "models/weapons/v_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"
SWEP.Penetrating = true
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Primary.Sound = Sound("Weapon_MP5Navy.Single")
SWEP.Primary.Recoil = 0.25
SWEP.Primary.Damage = 16
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.0001 --starting cone, it WILL increase to something higher, so keep it low
SWEP.Primary.ClipSize = 30
SWEP.Primary.Delay = 0.075
SWEP.Primary.DefaultClip = 0
SWEP.Primary.MaxReserve = 90
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.MaxSpread = 0.15 --the maximum amount the spread can go by, best left at 0.20 or lower
SWEP.Primary.Handle = 0.5 --how many seconds you have to wait between each shot before the spread is at its best
SWEP.Primary.SpreadIncrease = 0.21 / 15 --how much you add to the cone after each shot
SWEP.MoveSpread = 4 --multiplier for spread when you are moving
SWEP.JumpSpread = 7 --multiplier for spread when you are jumping
SWEP.CrouchSpread = 0.7 --multiplier for spread when you are crouching
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.IronSightsPos = Vector(4.8463, -3.3867, 1.8121)
SWEP.IronSightsAng = Vector(1.7595, 0.2319, 0.642)