
Clockwork.kernel:IncludePrefixed("shared.lua")

-- Called when the target ID HUD should be painted.
function ENT:HUDPaintTargetID(x, y, alpha)
	if Clockwork.plugin:Call("SalesmanTargetID", self, x, y, alpha) then
		local colorTargetID = Clockwork.option:GetColor("target_id")
		local colorWhite = Clockwork.option:GetColor("white")

		local physDesc = self:GetNWString("PhysDesc")
		local name = self:GetNWString("Name")

		y = Clockwork.kernel:DrawInfo(name, x, y, colorTargetID, alpha)

		if physDesc ~= "" then
			y = Clockwork.kernel:DrawInfo(physDesc, x, y, colorWhite, alpha)
		end
	end
end

-- Called when the entity initializes.
function ENT:Initialize()
	self.AutomaticFrameAdvance = true
end

-- Called every frame.
function ENT:Think()
	self:FrameAdvance(FrameTime())
	self:NextThink(CurTime())
end
