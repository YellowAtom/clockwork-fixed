local PLUGIN = PLUGIN;
function PLUGIN:Tick()
	// Bird Flight :3.
	for k, v in pairs(player.GetAll()) do
		local w = 0
		local b = 0
		local vel = Vector(0, 0, 0)
		if (d == nil or tim == nil) then
			d = {}
			tim = {}
		end
		if (d[v] == nil or tim[v] == nil) then
			d[v] = 0
			tim[v] = CurTime()+math.random(10)
		end
		
		if (v:GetFaction() == FACTION_BIRD) then
			if (CurTime()>tim[v]) then
				tim[v] = CurTime()+math.random(10)
				v:EmitSound("npc/crow/idle"..math.random(4), 100, 100)
			end
		end
		
		if v:GetFaction() == FACTION_BIRD and !v:OnGround() then
			if (v:KeyDown(IN_FORWARD))then w = 1; end;
			if (v:KeyDown(IN_JUMP))then d[v] = d[v]+1; else d[v] = 0; end;
			if (w==1) then
				vel = vel + (v:GetVelocity():Length()*v:EyeAngles():Forward()*0.2)
				vel = vel - (v:GetVelocity()/5)
			end
			if (d[v]>0 and d[v]<30) then
				vel = vel + (v:EyeAngles():Up()*75)
			end
			if (vel!=Vector(0, 0, 0)) then
				v:SetVelocity(vel)
			end
		end
	end
end