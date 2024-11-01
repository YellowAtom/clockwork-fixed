
local Clockwork = Clockwork
local tonumber = tonumber
local CurTime = CurTime
local pairs = pairs
local type = type
local string = string
local table = table
local game = game
local math = math

Clockwork.class = Clockwork.kernel:NewLibrary("Class")

Clockwork.class.stored = Clockwork.class.stored or {}
Clockwork.class.buffer = Clockwork.class.buffer or {}

--[[ Set the __index meta function of the class. --]]
local CLASS_TABLE = {
	__index = CLASS_TABLE
}

--[[
	@codebase Shared
	@details A function to register a new class.
	@returns {Unknown}
--]]
function CLASS_TABLE:Register()
	return Clockwork.class:Register(self, self.name)
end

--[[
	@codebase Shared
	@details A function to get a new class.
	@param {Unknown} Missing description for name.
	@returns {Unknown}
--]]
function Clockwork.class:New(name)
	local object = Clockwork.kernel:NewMetaTable(CLASS_TABLE)
	object.name = name or "Unknown"

	return object
end

local assignedIDs = {}

function Clockwork.class:GetUniqueTeamID()
	for id = 1, 65535 do
        if (!assignedIDs[id]) then
            assignedIDs[id] = true  -- Mark this ID as used
            return id
        end
    end
    error("No available IDs")  -- Handle the case where all IDs are used
end

--[[
	@codebase Shared
	@details A function to register a new class.
	@param {Unknown} Missing description for data.
	@param {Unknown} Missing description for name.
	@returns {Unknown}
--]]
function Clockwork.class:Register(data, name)
	if not data.maleModel then
		data.maleModel = data.femaleModel
	end

	if not data.femaleModel then
		data.femaleModel = data.maleModel
	end

	data.flags = data.flags or "b"
	data.limit = data.limit or 128
	data.wages = data.wages or 0
	data.index = self:GetUniqueTeamID()
	data.name = name
	cwTeam.SetUp(data.index, data.name, data.color)
	self.buffer[data.index] = data
	self.stored[data.name] = data
	--[[ if (SERVER and data.image) then
		Clockwork.kernel:AddFile("materials/"..data.image..".png");
	end; ]]

	return data.index
end

--[[
	@codebase Shared
	@details A function to get the class limit.
	@param {Unknown} Missing description for name.
	@returns {Unknown}
--]]
function Clockwork.class:GetLimit(name)
	local class = self:FindByID(name)

	if class then
		if class.limit ~= 128 then
			return math.ceil(class.limit / (128 / #cwPlayer.GetAll()))
		else
			return game.MaxPlayers()
		end
	else
		return 0
	end
end

--[[
	@codebase Shared
	@details A function to get all of the classes.
	@returns {Unknown}
--]]
function Clockwork.class:GetAll()
	return Clockwork.class.stored
end

--[[
	@codebase Shared
	@details A function to find a class by an identifier.
	@param {Unknown} Missing description for identifier.
	@returns {Unknown}
--]]
function Clockwork.class:FindByID(identifier)
	if not identifier then return end

	if tonumber(identifier) then
		return self.buffer[tonumber(identifier)]
	else
		return self.stored[identifier]
	end
end

function Clockwork.class:AssignToDefault(player)
	local defaults = {}
	local faction = player:GetFaction()

	for k, v in pairs(self.stored) do
		if v.factions and v.isDefault and table.HasValue(v.factions, faction) then
			defaults[#defaults + 1] = v.index
		end
	end

	if #defaults > 0 then
		local class = defaults[math.random(1, #defaults)]
		if class then return self:Set(player, class) end
	else
		for k, v in pairs(self.stored) do
			if Clockwork.kernel:HasObjectAccess(player, v) then return self:Set(player, v.index) end
		end
	end
end

--[[
	@codebase Shared
	@details A function to get an appropriate class model for a player.
	@param {Unknown} Missing description for name.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for noSubstitute.
	@returns {Unknown}
--]]
function Clockwork.class:GetAppropriateModel(name, player, noSubstitute)
	local defaultModel
	local class = self:FindByID(name)
	local model
	local skin

	if SERVER then
		defaultModel = player:GetDefaultModel()
	else
		defaultModel = player:GetSharedVar("Model")
	end

	if class then
		model, skin = self:GetModelByGender(name, player:GetGender())

		if class.GetModel then
			model, skin = class:GetModel(player, defaultModel)
		end
	end

	if not model and not noSubstitute then
		model = defaultModel
	end

	if not skin and not noSubstitute then
		skin = 1
	end

	return model, skin
end

--[[
	@codebase Shared
	@details A function to get a class's model by gender.
	@param {Unknown} Missing description for name.
	@param {Unknown} Missing description for gender.
	@returns {Unknown}
--]]
function Clockwork.class:GetModelByGender(name, gender)
	local model = self:Query(name, string.lower(gender) .. "Model")

	if type(model) == "table" then
		return model[1], model[2]
	else
		return model, 0
	end
end

--[[
	@codebase Shared
	@details A function to check if a class has any flags.
	@param {Unknown} Missing description for name.
	@param {Unknown} Missing description for flags.
	@returns {Unknown}
--]]
function Clockwork.class:HasAnyFlags(name, flags)
	local flagString = self:Query(name, "flags")

	if flagString then
		for i = 1, #flags do
			local flag = string.utf8sub(flags, i, i)
			if string.find(flagString, flag) then return true end
		end
	end
end

--[[
	@codebase Shared
	@details A function to check if a class has flags.
	@param {Unknown} Missing description for name.
	@param {Unknown} Missing description for flags.
	@returns {Unknown}
--]]
function Clockwork.class:HasFlags(name, flags)
	local flagString = self:Query(name, "flags")

	if flagString then
		for i = 1, #flags do
			local flag = string.utf8sub(flags, i, i)
			if not string.find(flagString, flag) then return false end
		end

		return true
	end
end

--[[
	@codebase Shared
	@details A function to query a class.
	@param {Unknown} Missing description for name.
	@param {Unknown} Missing description for key.
	@param {Unknown} Missing description for default.
	@returns {Unknown}
--]]
function Clockwork.class:Query(name, key, default)
	local class = self:FindByID(name)

	if class then
		return class[key] or default
	else
		return default
	end
end

if SERVER then
	function Clockwork.class:Set(player, name, noRespawn, addDelay, noModelChange)
		local weapons = Clockwork.player:GetWeapons(player)
		local oldClass = self:FindByID(player:Team())
		local newClass = self:FindByID(name)
		local ammo = Clockwork.player:GetAmmo(player, not player.cwFirstSpawn)

		if newClass then
			player:SetTeam(newClass.index)

			if not noModelChange then
				Clockwork:PlayerSetModel(player)
			end

			if not noRespawn then
				player.cwChangeClass = true

				if not player:Alive() or player.cwFirstSpawn then
					player:Spawn()
				elseif not player:IsRagdolled() then
					Clockwork.player:LightSpawn(player, weapons, ammo)
				end
			end

			if addDelay then
				player.cwNextChangeClass = CurTime() + Clockwork.config:Get("change_class_interval"):Get()
			end

			Clockwork.plugin:Call("PlayerClassSet", player, newClass, oldClass, noRespawn, addDelay, noModelChange)

			return true
		else
			return false, {"ClassNotValid"}
		end
	end
end
