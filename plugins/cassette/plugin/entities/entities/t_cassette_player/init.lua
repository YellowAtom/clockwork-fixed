	
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
	
	include("shared.lua")
	
	local Clockwork = Clockwork;
	local PLUGIN = PLUGIN;

	function ENT:SpawnFunction(player, trace)
		if (!trace.Hit) then return; end;

		local entity = ents.Create("t_cassette_player");
		entity:Spawn();
		entity:Activate();
		entity:SetPos( trace.HitPos + trace.HitNormal * 32 + Vector(0, 0, 53) );
		entity:SetAngles( Angle(0, 0, 0) );

		return entity;
	end;
	
	-- A function to get the entity's item table.
	function ENT:GetItemTable()
		return self.cwItemTable;
	end;

	-- A function to set the entity's item table.
	function ENT:SetItemTable(itemTable)
		self.cwItemTable = itemTable;
	end;
	
	function ENT:Initialize()
		self:SetModel("models/devcon/mrp/props/player_2.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:PhysWake()
		
		self:SetSongKey(1)
	end
	
	function ENT:Touch(ent)
		if not self.next_insert or self.next_insert < SysTime() then
			if (ent:GetClass() == "cw_item") and self:GetCassetteKey() == 0 then
				local itemTable = ent:GetItemTable();
				if (itemTable and itemTable("isCassette")) then
					self:SetCassetteKey(itemTable("key"))
					self.cassette_class = itemTable("uniqueID")
					ent:Remove()
					PLUGIN:SaveCassettes()
				end;
			end;
		end
	end
	
	function ENT:EjectCassette()
		if self:GetCassetteKey() ~= 0 then
			local pos, ang = self:GetCassettePos(true)
			local f = self:GetForward()
			local itemPosition = pos + f*19
			Clockwork.entity:CreateItem(nil, Clockwork.item:CreateInstance(self.cassette_class), itemPosition, self:GetAngles());
			
			self:Play(false)
			self:SetSongKey(1)
			self:SetCassetteKey(0)
			PLUGIN:SaveCassettes()
			
			self.next_insert = SysTime() + self.data.insert_delay
		end
	end
	
	function ENT:Think()
		local time = SysTime()
		if self.next_song and self.next_song < time then
			self:AdvanceSongKey()
			self:Play(true)
		end
	end
	
	function ENT:AdvanceSongKey(bNegative)
		local data = self:GetData()
		if data then
			local key, count = self:GetSongKey(), #data.playlist
			key = key + ((bNegative and -1) or 1)
			key = (key > count and 1) or (key < 1 and count) or key
			self:SetSongKey(key)
		end
	end
	
	function ENT:Play(bPlay, pl)
		local data = self:GetSongData()
		if data then
			self:SetPlaying(bPlay)
			self.next_song = (bPlay and SysTime() + data.length)
			self.active_song = (bPlay and data)
			
			net.Start("tcp_play")
			net.WriteEntity(self)
			net.WriteBit(bPlay)
			if pl then
				net.Send(pl)
			else
				net.SendPVS(self:GetPos())
			end
		end
	end