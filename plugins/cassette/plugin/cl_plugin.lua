	t_cassette = {}
	
	surface.CreateFont("CassettePlayer", {
		font = "Advanced Pixel LCD-7",
		size = 24,
		antialias = true
	})
	
	function t_cassette.SendClick(ent, key)
		net.Start("tcp_click")
		net.WriteEntity(ent)
		net.WriteUInt(key - 1, 2)
		net.SendToServer()
	end
	
	function t_cassette.ReceivePlay()
		local ent = net.ReadEntity()
		local bPlay = net.ReadBit() == 1
		if IsValid(ent) then
			if bPlay then
				ent:Play()
			else
				ent:Stop()
			end
		end
	end
	net.Receive("tcp_play", t_cassette.ReceivePlay)
	
	function t_cassette.KeyPress(pl, key)
		if key == IN_USE then
			local tr = pl:GetEyeTrace()
			local ent = tr.Entity
			if not IsValid(ent) or ent:GetClass() ~= "t_cassette_player" or 
				not ent:CanClick() or tr.HitNormal:Dot(ent:GetForward()) > -0.99 then
				return
			end
			
			for key, btn in pairs(ent:GetButtonData()) do
				if btn.hasfocus then
					ent.next_click = SysTime() + ent.data.click_delay
					--t_cassette.SendClick(ent, key)
					net.Start("tcp_click")
					net.WriteEntity(ent)
					net.WriteUInt(key - 1, 2)
					net.SendToServer()
					return
				end
			end
		end
	end
	hook.Add("KeyPress", "t_cassette_keypress", t_cassette.KeyPress)