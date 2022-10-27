	
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
	
	include("shared.lua")
	
	function ENT:Initialize()
		self:SetModel("models/devcon/mrp/props/casette.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:PhysWake()
	end