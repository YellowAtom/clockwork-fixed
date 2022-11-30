local Clockwork = Clockwork
local CurTime = CurTime
local surface = surface
local vgui = vgui
local math = math

local PANEL = {}

-- Called when the panel is initialized.
function PANEL:Init()
	self.HoverColor = Clockwork.option:GetColor("information")
	self:SetTooltip(false)
end

-- Called when the panel is painted.
function PANEL:Paint()
	self.OverlayFade = math.Clamp((self.OverlayFade or 0) - RealFrameTime() * 640 * 2, 0, 255)

	if not dragndrop.IsDragging() and self:IsHovered() then
		self.OverlayFade = math.Clamp(self.OverlayFade + RealFrameTime() * 640 * 8, 0, 255)
	end
end

-- Called when the panel should be painted over.
function PANEL:PaintOver(w, h)
	local curTime = CurTime()

	if self.Cooldown and self.Cooldown.expireTime > curTime then
		local progress = 100 - (100 / self.Cooldown.duration) * self.Cooldown.expireTime - curTime

		Clockwork.cooldown:DrawBox(0, 0, w, h, progress, Color(255, 255, 255, 255 - (255 / 100) * progress), self.Cooldown.textureID)
	end

	if self.BorderColor then
		surface.SetDrawColor(self.BorderColor.r, self.BorderColor.g, self.BorderColor.b, math.min(self.BorderColor.a, self:GetAlpha()))
		surface.DrawOutlinedRect(0, 0, w, h, 2.5)
	end

	if self.HoverColor and self.OverlayFade > 0 then
		surface.SetDrawColor(self.HoverColor.r, self.HoverColor.g, self.HoverColor.b, math.min(self.OverlayFade, self:GetAlpha()))
		surface.DrawOutlinedRect(0, 0, w, h, 2.5)
	end
end

function PANEL:OnMousePressed(key)
	if self.DoClick and key == MOUSE_LEFT then
		self:DoClick()
	elseif self.DoRightClick and key == MOUSE_RIGHT then
		self:DoRightClick()
	end
end

-- A function to set the hover color.
function PANEL:SetHoverColor(color)
	self.HoverColor = color
end

-- A function to set the border color.
function PANEL:SetColor(color)
	self.BorderColor = color
end

-- A function to set the cooldown.
function PANEL:SetCooldown(expireTime, textureID)
	self.Cooldown = {
		expireTime = expireTime,
		textureID = textureID or surface.GetTextureID("vgui/white"),
		duration = expireTime - CurTime()
	}
end

vgui.Register("cwSpawnIcon", PANEL, "SpawnIcon")
