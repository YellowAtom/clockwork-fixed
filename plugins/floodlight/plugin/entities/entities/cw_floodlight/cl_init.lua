include("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
end;

-- Called when the entity should draw.
function ENT:Draw()
	self:DrawModel();
end;

-- Called when the entity should think.
function ENT:Think()
	if (self:GetDTInt(0) == 1) then
		local dlight = DynamicLight(self:EntIndex())

		if (dlight) then
			dlight.Pos = self:GetPos() + Vector(19, 0, 70);
			dlight.r = 255;
			dlight.g = 255;
			dlight.b = 150;
			dlight.Brightness = 0.4;
			dlight.Size = 2800;
			dlight.Decay = 1;
			dlight.DieTime = CurTime() + 0.1;
		end;
	end;
end;