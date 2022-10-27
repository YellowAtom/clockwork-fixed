	
	ENT.Base = "base_anim"
	ENT.PrintName = "Cassette Player"
	ENT.Author = "Thermadyle"
	
	ENT.data = {
		insert_delay = 1,
		click_delay = 0.5,
		buttons = {
			{
				text = "PREV",
				GetPos = function(self, width, height, display)
					return 
						display.btn_padding, 
						display.height - display.btn_padding - height
				end,
				OnClick = function(self, ent)
					ent:AdvanceSongKey(true)
				end
			},
			
			{
				text = "NEXT",
				GetPos = function(self, width, height, display)
					return 
						display.width - width - display.btn_padding, 
						display.height - display.btn_padding - height
				end,
				OnClick = function(self, ent)
					ent:AdvanceSongKey()
				end
			},
			
			{
				GetText = function(self, ent)
					local song, key = ent.active_song, ent:GetSongKey()
					return (ent:GetCassetteKey() == 0 and "----") or
						((ent:GetPlaying() and song and song.key == key) and "STOP") or "PLAY"
				end,
				GetPos = function(self, width, height, display)
					return 
						(display.width / 2) - (width / 2),
						display.height - display.btn_padding - height
				end,
				OnClick = function(self, ent)
					local song, key = ent.active_song, ent:GetSongKey()
					if ent:GetPlaying() and (not song or song.key == key) then
						ent:Play(false)
					else
						ent:Play(true)
					end
				end
			},
			
			{
				GetText = function(self, ent)
					local data = ent:GetData()
					return string.format("EJECT> %s", (data and data.name) or "----")
				end,
				GetPos = function(self, width, height, display)
					return display.btn_padding, display.btn_padding
				end,
				OnClick = function(self, ent)
					ent:EjectCassette()
				end
			}
		}
	}
	
	function ENT:SetupDataTables()
		self:NetworkVar("Int", 0, "CassetteKey")
		self:NetworkVar("Int", 1, "SongKey")
		self:NetworkVar("Bool", 0, "Playing")
	end
	
	function ENT:GetData()
		local key = self:GetCassetteKey()
		return t_cassette.cassettes[key]
	end
	
	function ENT:GetSongData()
		local data = self:GetData()
		if data then
			local key = self:GetSongKey()
			return data.playlist[key]
		end
	end
	
	function ENT:GetCassettePos(bEject)
		local ang = self:GetAngles()
		local pos = self:GetPos() +
		(ang:Right() * -6.5) + (ang:Up() * 3.55) +
		(ang:Forward() * ((bEject and -3.25) or -1.5))
		return pos, ang
	end
	
	function ENT:CanClick()
		return not self.next_click or self.next_click < SysTime()
	end