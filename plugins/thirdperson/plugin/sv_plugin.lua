local cwThirdPerson = cwThirdPerson

Clockwork.config:Add("enable_third_person", true)

function cwThirdPerson:CanToggleThirdPerson(player)
	-- Allow admins and operators to bypass the weapon check
	if (Clockwork.player:IsAdmin(player)) then
		return true
	end

	local bIsRaised = Clockwork.player:GetWeaponRaised(player, true)
	if bIsRaised == true and player:GetNWBool("thirdperson") == false then
		Clockwork.player:Notify(player, "You cannot toggle third-person with a raised weapon!")
		return false
	end
	
	return true
end

function cwThirdPerson:Disable(player)
	if not Clockwork.config:Get("enable_third_person"):Get() then return end
	if not self:CanToggleThirdPerson(player) then return end

	local entity = player:GetViewEntity()
	player:SetNWBool("thirdperson", false)
	player:SetViewEntity(player)

	if IsValid(entity) and entity:IsValid() then
		entity:Remove()
	end

	-- Logging
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " disabled third-person view.")
end

function cwThirdPerson:Enable(player)
	if not Clockwork.config:Get("enable_third_person"):Get() then return end
	if not self:CanToggleThirdPerson(player) then return end

	local entity = ents.Create("prop_dynamic")
	entity:SetModel("models/error.mdl")
	entity:SetColor(Color(0, 0, 0, 0))
	entity:Spawn()
	entity:SetNoDraw(true)
	entity:SetAngles(player:GetAngles())
	entity:SetMoveType(MOVETYPE_NONE)
	entity:SetParent(player)
	entity:SetPos(player:GetPos() + Vector(0, 0, 60))

	-- Logging
	Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " enabled third-person view.")
	entity:SetRenderMode(RENDERMODE_NONE)
	entity:SetSolid(SOLID_NONE)
	player:SetViewEntity(entity)
	player:SetNWBool("thirdperson", true)
end

function cwThirdPerson:SetThirdPerson(player, value)
	if not Clockwork.config:Get("enable_third_person"):GetBoolean() then return end

	if value == nil then
		value = not player:GetThirdPerson()
	end

	if value == "1" or value == true then
		if player:GetThirdPerson() then
			return
		else
			self:Enable(player)
		end
	else
		if not player:GetThirdPerson() then
			return
		else
			self:Disable(player)
		end
	end
end

function cwThirdPerson:ClockworkConfigChanged(key, data, previousValue, newValue)
	if key == "enable_third_person" then
		for k, v in pairs(player.GetAll()) do
			if v:GetThirdPerson() then
				self:Disable(v)
			end
		end
	end
end

function cwThirdPerson:PlayerCharacterUnloaded(player)
	player:SetThirdPerson(false)
end

function cwThirdPerson:GetPlayerWeaponRaised(player, class, weapon)
	local bIsRaised = Clockwork.player:GetWeaponRaised(player, true)
	local activeWeapon = player:GetActiveWeapon()
	if bIsRaised and not Clockwork.player:IsAdmin(player) then
		player:SetThirdPerson(false)
	end
end

local PLAYER_META = FindMetaTable("Player")

function PLAYER_META:SetThirdPerson(value)
	return cwThirdPerson:SetThirdPerson(self, value)
end

concommand.Add("chasecam_zoom", function(player, command, arguments)
	if player:GetVar("thirdperson_zoom") == 1 then
		player:SetVar("thirdperson_zoom", 0)
	else
		player:SetVar("thirdperson_zoom", 1)
	end
end)

concommand.Add("chasecam", function(player, command, arguments)
	player:SetThirdPerson(arguments[1])
end)

concommand.Add("chasecaminvert", function(player, command, arguments)
	if player:GetNWBool("ChaseCamInvert") == nil then return player:SetNWBool("ChaseCamInvert", true) end
	player:SetNWBool("ChaseCamInvert", not player:GetNWBool("ChaseCamInvert"))
end)
