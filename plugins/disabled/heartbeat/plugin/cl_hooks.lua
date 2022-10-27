local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

-- Called when the HUD should be painted.
function cwHeartBeat:HUDPaint()
	local colorWhite = Clockwork.option:GetColor("white");
	local curTime = CurTime();
	local info = {
		alpha = 255 - Clockwork.kernel:GetBlackFadeAlpha(),
		x = ScrW() - 208,
		y = 8
	};
	
	local inventory = Clockwork.inventory:GetClient();

	if (Clockwork.inventory:HasItemByID(inventory, "heartbeat_scanner") and info.alpha > 0) then
		if (Clockwork.Client:GetSharedVar("implant")) then
			local aimVector = Clockwork.Client:GetAimVector();
			local position = Clockwork.Client:GetPos();
			local curTime = UnPredictedCurTime();

			self.heartbeatOverlay:SetFloat("$alpha", math.min(0.5, (info.alpha / 255) * 0.5));
			
			surface.SetDrawColor(255, 255, 255, math.min(150, info.alpha / 2));
				surface.SetMaterial(self.heartbeatOverlay);
			surface.DrawTexturedRect(info.x, info.y, 200, 200);
			
			surface.SetDrawColor(0, 200, 0, info.alpha);
				surface.SetMaterial(self.heartbeatPoint);
			surface.DrawTexturedRect(info.x + 84, info.y + 84, 32, 32);
			
			if (self.heartbeatScan) then
				local scanAlpha = math.min(255 * math.max(self.heartbeatScan.fadeOutTime - curTime, 0), info.alpha);
				local y = self.heartbeatScan.y + ((184 / 255) * (255 - scanAlpha));
				
				if (scanAlpha > 0) then
					surface.SetDrawColor(100, 0, 0, scanAlpha * 0.5);
						surface.SetMaterial(self.heartbeatGradient);
					surface.DrawTexturedRect(self.heartbeatScan.x, y, self.heartbeatScan.width, self.heartbeatScan.height);
				else
					self.heartbeatScan = nil;
				end;
			end;
			
			if (curTime >= self.nextHeartbeatCheck) then
				self.nextHeartbeatCheck = curTime + 0.1;
				self.oldHeartbeatPoints = self.heartbeatPoints;
				self.heartbeatPoints = {};
				self.heartbeatScan = {
					fadeOutTime = curTime + 0.1,
					height = 16,
					width = 200,
					y = info.y,
					x = info.x
				};
				
				local centerY = info.y + 100;
				local centerX = info.x + 100;
				
				for k, v in ipairs(ents.FindInSphere(position, 768)) do
					if ((v:IsPlayer() and v:Alive() and v:HasInitialized()) or string.find(v:GetClass(), "npc_")) then
						if (Clockwork.Client != v and !Clockwork.player:IsNoClipping(v)) then
							local playerPosition = v:GetPos();
							local difference = playerPosition - position;
							local pointX = (difference.x / 768);
							local pointY = (difference.y / 768);
							local pointZ = math.sqrt(pointX * pointX + pointY * pointY);
							local color = Color(0, 150, 255, 255);
							local phi = math.rad(math.deg(math.atan2(pointX, pointY)) - math.deg(math.atan2(aimVector.x, aimVector.y)) - 90);
							pointX = math.cos(phi) * pointZ;
							pointY = math.sin(phi) * pointZ;
								
							if (v:IsPlayer()) then						
								if (Schema:PlayerIsCombine(v)) then
									color = Color(0, 255, 0, 255);
								end;
							else
								color = Color(255, 0, 0, 255);
							end;
								
									
							self.heartbeatPoints[#self.heartbeatPoints + 1] = {
								fadeInTime = curTime + 0.1,
								height = 32,
								width = 32,
								color = color,
								x = centerX + (pointX * 100) - 16,
								y = centerY + (pointY * 100) - 16
							};
						end;
					end;
				end;
				
				if (self.lastHeartbeatAmount > #self.heartbeatPoints) then
					Clockwork.Client:EmitSound("items/flashlight1.wav", 25);
				end;
				
				for k, v in ipairs(self.oldHeartbeatPoints) do
					v.fadeOutTime = curTime + 0.1;
					v.fadeInTime = nil;
				end;
				
				self.lastHeartbeatAmount = #self.heartbeatPoints;
			end;
			
			for k, v in ipairs(self.oldHeartbeatPoints) do
				local pointAlpha = 255 * math.max(v.fadeOutTime - curTime, 0);
				local pointX = math.Clamp(v.x, info.x, (info.x + 200) - 32);
				local pointY = math.Clamp(v.y, info.y, (info.y + 200) - 32);
				
				surface.SetDrawColor(v.color.r, v.color.g, v.color.b, math.min(pointAlpha, info.alpha));
					surface.SetMaterial(self.heartbeatPoint);
				surface.DrawTexturedRect(pointX, pointY, v.width, v.height);
			end;
			
			for k, v in ipairs(self.heartbeatPoints) do
				local pointAlpha = 255 - (255 * math.max(v.fadeInTime - curTime, 0));
				local pointX = math.Clamp(v.x, info.x, (info.x + 200) - 32);
				local pointY = math.Clamp(v.y, info.y, (info.y + 200) - 32);
				
				surface.SetDrawColor(v.color.r, v.color.g, v.color.b, math.min(pointAlpha, info.alpha));
					surface.SetMaterial(self.heartbeatPoint);
				surface.DrawTexturedRect(pointX, pointY, v.width, v.height);
			end;
			
			info.y = info.y + 212;
		end;
	end;
end;