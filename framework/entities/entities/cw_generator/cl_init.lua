
include("shared.lua")

-- Called when the entity should draw.
function ENT:Draw()
	if Clockwork.plugin:Call("GeneratorEntityDraw", self) ~= false then
		self:DrawModel()
	end
end
