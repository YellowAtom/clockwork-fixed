	
	ENT.Base = "base_anim"
	ENT.PrintName = "Cassette"
	ENT.Author = "Thermadyle"
	ENT.IsCassette = true
	
	AccessorFunc(ENT, "key", "Key")
	
	function ENT:GetData()
		local key = self:GetKey()
		return t_cassette.cassettes[key]
	end