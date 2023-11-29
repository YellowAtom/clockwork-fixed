
local Clockwork = Clockwork
local AddCSLuaFile = AddCSLuaFile
local pairs = pairs
local scripted_ents = scripted_ents
local effects = effects
local weapons = weapons
local string = string
local table = table
local cwFile = cwFile
local util = util
local debug = debug

--[[ The plugin library is already defined! --]]
if Clockwork.plugin then return end
Clockwork.plugin = Clockwork.kernel:NewLibrary("Plugin")

if SERVER then
	CW_PLUGIN_SHARED = {
		iniTables = {}
	}
else
	CW_PLUGIN_SHARED = Clockwork.kernel:Deserialize(CW_PLUGIN_SHARED_SERIAL)
end

--[[
	We do local variables instead of global ones for performance increase.
	Most CW libraries use functions to return their tables anyways.
--]]
local stored = {}
local modules = {}
local unloaded = {}
local extras = {}
local hookCache = {}

--[[
	@codebase Shared
	@details A function to get the local stored table that contains all registered plugins.
	@returns {Table} The local stored plugin table.
--]]
function Clockwork.plugin:GetStored()
	return stored
end

--[[
	@codebase Shared
	@details A function to get the local plugin module table that contains all registered plugin modules.
	@returns {Table} The local plugin module table.
--]]
function Clockwork.plugin:GetModules()
	return modules
end

--[[
	@codebase Shared
	@details A function to get the local unloaded table that contains all unloaded plugins.
	@returns {Table} The local stored unloaded plugin table.
--]]
function Clockwork.plugin:GetUnloaded()
	return unloaded
end

--[[
	@codebase Shared
	@details A function to get the extras that will be included in each plugin.
	@returns {Table} The local table of extras to be searched for in plugins.
--]]
function Clockwork.plugin:GetExtras()
	return extras
end

--[[
	@codebase Shared
	@details A function to get the local plugin hook cache.
	@returns {Table} The local plugin hook cache table.
--]]
function Clockwork.plugin:GetHookCache()
	return hookCache
end

PLUGIN_META = {
	__index = PLUGIN_META
}

PLUGIN_META.description = "A serious roleplaying game set in the Half-Life universe."
PLUGIN_META.hookOrder = 0
PLUGIN_META.version = "1.0"
PLUGIN_META.author = "Unknown"
PLUGIN_META.name = "Unknown"

PLUGIN_META.SetGlobalAlias = function(PLUGIN_META, aliasName)
	_G[aliasName] = PLUGIN_META
end

PLUGIN_META.GetDescription = function(PLUGIN_META) return PLUGIN_META.description end
PLUGIN_META.GetBaseDir = function(PLUGIN_META) return PLUGIN_META.baseDir end
PLUGIN_META.GetHookOrder = function(PLUGIN_META) return PLUGIN_META.hookOrder end
PLUGIN_META.GetVersion = function(PLUGIN_META) return PLUGIN_META.version end
PLUGIN_META.GetAuthor = function(PLUGIN_META) return PLUGIN_META.author end
PLUGIN_META.GetName = function(PLUGIN_META) return PLUGIN_META.name end

PLUGIN_META.Register = function(PLUGIN_META)
	Clockwork.plugin:Register(PLUGIN_META)
end

debug.getregistry().Plugin = PLUGIN_META

if SERVER then
	function Clockwork.plugin:SetUnloaded(name, isUnloaded)
		local plugin = self:FindByID(name)

		if plugin and plugin ~= Schema then
			if isUnloaded then
				unloaded[plugin.folderName] = true
			else
				unloaded[plugin.folderName] = nil
			end

			Clockwork.kernel:SaveSchemaData("plugins", unloaded)

			return true
		end

		return false
	end

	--[[
		@codebase Shared
		@details A function to get whether a plugin is disabled.
		@param {Unknown} Missing description for name.
		@param {Unknown} Missing description for bFolder.
		@returns {Unknown}
	--]]
	function Clockwork.plugin:IsDisabled(name, bFolder)
		if not bFolder then
			local plugin = self:FindByID(name)

			if plugin and plugin ~= Schema then
				for k, v in pairs(unloaded) do
					local unloaded = self:FindByID(k)

					if unloaded and unloaded ~= Schema and plugin.folderName ~= unloaded.folderName then
						if table.HasValue(unloaded.plugins, plugin.folderName) then return true end
					end
				end
			end
		else
			for k, v in pairs(unloaded) do
				local unloaded = self:FindByID(k)

				if unloaded and unloaded ~= Schema and name ~= unloaded.folderName then
					if table.HasValue(unloaded.plugins, name) then return true end
				end
			end
		end

		return false
	end

	--[[
		@codebase Shared
		@details A function to get whether a plugin is unloaded.
		@param {Unknown} Missing description for name.
		@param {Unknown} Missing description for bFolder.
		@returns {Unknown}
	--]]
	function Clockwork.plugin:IsUnloaded(name, bFolder)
		if not bFolder then
			local plugin = self:FindByID(name)
			if plugin and plugin ~= Schema then return unloaded[plugin.folderName] == true end
		else
			return unloaded[name] == true
		end

		return false
	end
else
	Clockwork.plugin.override = Clockwork.plugin.override or {}

	--[[
		@codebase Shared
		@details A function to set whether a plugin is unloaded.
		@param {Unknown} Missing description for name.
		@param {Unknown} Missing description for isUnloaded.
		@returns {Unknown}
	--]]
	function Clockwork.plugin:SetUnloaded(name, isUnloaded)
		local plugin = self:FindByID(name)

		if plugin then
			self.override[plugin.folderName] = isUnloaded
		end
	end

	--[[
		@codebase Shared
		@details A function to get whether a plugin is disabled.
		@param {Unknown} Missing description for name.
		@param {Unknown} Missing description for bFolder.
		@returns {Unknown}
	--]]
	function Clockwork.plugin:IsDisabled(name, bFolder)
		if not bFolder then
			local plugin = self:FindByID(name)

			if plugin and plugin ~= Schema then
				for k, v in pairs(unloaded) do
					local unloaded = self:FindByID(k)

					if unloaded and unloaded ~= Schema and plugin.folderName ~= unloaded.folderName then
						if table.HasValue(unloaded.plugins, plugin.folderName) then return true end
					end
				end
			end
		else
			for k, v in pairs(unloaded) do
				local unloaded = self:FindByID(k)

				if unloaded and unloaded ~= Schema and name ~= unloaded.folderName then
					if table.HasValue(unloaded.plugins, name) then return true end
				end
			end
		end

		return false
	end

	--[[
		@codebase Shared
		@details A function to get whether a plugin is unloaded.
		@param {Unknown} Missing description for name.
		@param {Unknown} Missing description for bFolder.
		@returns {Unknown}
	--]]
	function Clockwork.plugin:IsUnloaded(name, bFolder)
		if not bFolder then
			local plugin = self:FindByID(name)

			if plugin and plugin ~= Schema then
				if self.override[plugin.folderName] ~= nil then return self.override[plugin.folderName] end

				return unloaded[plugin.folderName] == true
			end
		else
			if self.override[name] ~= nil then return self.override[name] end

			return unloaded[name] == true
		end

		return false
	end
end

--[[
	@codebase Shared
	@details A function to set if the plugin system is initialized.
	@param {Unknown} Missing description for bInitialized.
	@returns {Unknown}
--]]
function Clockwork.plugin:SetInitialized(bInitialized)
	self.cwInitialized = bInitialized
end

--[[
	@codebase Shared
	@details A function to get whether the config has initialized.
	@returns {Unknown}
--]]
function Clockwork.plugin:HasInitialized()
	return self.cwInitialized
end

--[[
	@codebase Shared
	@details A function to initialize the plugin system.
	@returns {Unknown}
--]]
function Clockwork.plugin:Initialize()
	if self:HasInitialized() then return end

	if SERVER then
		unloaded = Clockwork.kernel:RestoreSchemaData("plugins")
	end

	self:SetInitialized(true)
end

--[[
	@codebase Shared
	@details A function to check Schema function mismatches.
	@returns {Unknown}
--]]
function Clockwork.plugin:CheckMismatches()
	if Schema then
		local funcIdxMismatches = {}

		for k, v in pairs(Schema) do
			if type(v) == "function" and Schema.__funcIdx[k] and tostring(v) ~= Schema.__funcIdx[k] then
				table.insert(funcIdxMismatches, k)
			end
		end

		if SERVER then
			for k, v in ipairs(funcIdxMismatches) do
				MsgC(Color(255, 255, 50), "[Clockwork:Plugin] The Schema hook '" .. v .. "' was overriden by a plugin!\n")
			end
		end
	end
end

--[[
	@codebase Shared
	@details A function to register a new plugin.
	@param {Unknown} Missing description for pluginTable.
	@returns {Unknown}
--]]
function Clockwork.plugin:Register(pluginTable)
	local newBaseDir = Clockwork.kernel:RemoveTextFromEnd(pluginTable.baseDir, "/schema")
	local _, pluginFolders = cwFile.Find(newBaseDir .. "/plugins/*", "LUA", "namedesc")

	stored[pluginTable.name] = pluginTable
	stored[pluginTable.name].plugins = {}

	for k, v in ipairs(pluginFolders) do
		if v ~= ".." and v ~= "." then
			table.insert(stored[pluginTable.name].plugins, v)
		end
	end

	if not self:IsUnloaded(pluginTable.folderName) then
		self:IncludeExtras(pluginTable:GetBaseDir())

		if CLIENT and Schema ~= pluginTable then
			pluginTable.helpID = Clockwork.directory:AddCode("HelpPlugins", [[
				<div class="cwTitleSeperator">
					<lang>]] .. pluginTable:GetName() .. [[</lang>
				</div>
				<div class="cwContentText">
					<div class="cwCodeText">]] .. pluginTable:GetAuthor() .. [[</div>
					<lang>]] .. string.gsub(pluginTable:GetDescription(), "\\n", "<br>") .. [[</lang>
				</div>
				<br>
			]], true, pluginTable:GetAuthor())
		end
	end

	--[[
		Schema functions shouldn't be overriden. There's always a way to do it
		with plugins, so this will be warned against!
	--]]
	if Schema == pluginTable then
		Schema.__funcIdx = {}

		for k, v in pairs(Schema) do
			if type(v) == "function" then
				Schema.__funcIdx[k] = tostring(v)
			end
		end
	end

	self:IncludePlugins(newBaseDir)

	if self.ClearHookCache then
		self:ClearHookCache()
		self.sortedModules = nil
		self.sortedPlugins = nil
	end
end

--[[
	@codebase Shared
	@details A function to find a plugin by an ID.
	@param {Unknown} Missing description for identifier.
	@returns {Unknown}
--]]
function Clockwork.plugin:FindByID(identifier)
	return stored[identifier]
end

--[[
	@codebase Shared
	@details A function to determine whether the framework supports a particular plugin.
	@param {Unknown} Missing description for compatibility.
	@param {Unknown} Missing description for branch.
	@returns {Unknown}
--]]
function Clockwork.plugin:CompareVersion(compatibility, branch)
	-- Clockwork Branch and Version Check.
	if branch then
		local clockworkBranch = Clockwork.kernel:GetBranch()
		local clockworkBranchVersion = tonumber(Clockwork.kernel:GetBranchVersion())

		local branchExplode = string.Explode("-", branch)

		local pluginBranch = branchExplode[1] or branch
		local pluginBranchVersion = tonumber(branchExplode[2])

		if pluginBranch ~= clockworkBranch then
			return true
		elseif pluginBranchVersion and pluginBranchVersion > clockworkBranchVersion then
			return true
		end
	end

	-- Clockwork Version and Build Check.
	if compatibility then
		local clockworkVersion = tonumber(Clockwork.kernel:GetVersion())
		local clockworkBuild = tonumber(Clockwork.kernel:GetBuild())

		local compatibilityExplode = string.Explode("-", compatibility)

		local pluginVersion = tonumber(compatibilityExplode[1] or compatibility)
		local pluginBuild = tonumber(compatibilityExplode[2])

		if pluginVersion and (pluginVersion < 0.9 or pluginVersion > clockworkVersion) then
			return true
		end

		if (pluginBuild and clockworkBuild) and (pluginBuild > clockworkBuild) then
			return true
		end
	end

	return false
end

--[[
	@codebase Shared
	@details A function to include a plugin.
	@param {Unknown} Missing description for directory.
	@param {Unknown} Missing description for isSchema.
	@returns {Unknown}
--]]
function Clockwork.plugin:Include(directory, isSchema)
	local explodeDir = string.Explode("/", directory)
	local folderName = explodeDir[#explodeDir - 1]
	local pathCRC = util.CRC(directory)

	PLUGIN_BASE_DIR = directory
	PLUGIN_FOLDERNAME = folderName

	if isSchema then
		PLUGIN = self:New()
		Schema = PLUGIN

		if SERVER then
			local schemaInfo = Clockwork.kernel:GetSchemaGamemodeInfo()
			table.Merge(Schema, schemaInfo)
			CW_PLUGIN_SHARED.schemaInfo = schemaInfo
		elseif Clockwork.plugin.schemaData then
			table.Merge(Schema, CW_PLUGIN_SHARED.schemaInfo)
		end

		if cwFile.Exists(directory .. "/sh_schema.lua", "LUA") then
			AddCSLuaFile(directory .. "/sh_schema.lua")
			include(directory .. "/sh_schema.lua")
		else
			MsgC(Color(255, 100, 0, 255), "\n[Clockwork:Plugin] The schema has no sh_schema.lua.\n")
		end

		Schema:Register()
	else
		local originalPLUGIN = PLUGIN
		PLUGIN = self:New()

		if SERVER then
			local iniDir = "gamemodes/" .. Clockwork.kernel:RemoveTextFromEnd(directory, "/plugin")
			local iniTable = Clockwork.config:LoadINI(iniDir .. "/plugin.ini", true, true)

			if iniTable then
				if iniTable["Plugin"] then
					iniTable = iniTable["Plugin"]
					iniTable.isUnloaded = self:IsUnloaded(PLUGIN_FOLDERNAME, true)

					table.Merge(PLUGIN, iniTable)
					CW_PLUGIN_SHARED.iniTables[pathCRC] = iniTable
				end

				local compatibility -- = iniTable["compatibility"] -- This no longer works as KUROZAEL made the newest version of clockwork numerically lower than 0.9 
				local branch = iniTable["branch"]
				local name = iniTable["name"] or PLUGIN_FOLDERNAME

				if (compatibility or branch) then
					if (self:CompareVersion(compatibility, branch)) then
						local version = string.format("%s%s%s", compatibility or "", (compatibility and branch) and " | " or "", branch or "")

						MsgC(Color(255, 165, 0), string.format("[Clockwork:Plugin] The \"%s\" plugin [%s] may not be compatible the Clockwork %s!\n", name, version, Clockwork.kernel:GetVersionBuild()))
					end
--				else
--					MsgC(Color(255, 165, 0),"[Clockwork:Plugin] The \"" .. name .. "\"" plugin has no compatibility value set!\n")
				end
			else
				MsgC(Color(255, 165, 0), "[Clockwork:Plugin] The \"" .. PLUGIN_FOLDERNAME .. "\" plugin has no plugin.ini!\n")
			end
		else
			local iniTable = CW_PLUGIN_SHARED.iniTables[pathCRC]

			if iniTable then
				table.Merge(PLUGIN, iniTable)

				if iniTable.isUnloaded then
					unloaded[PLUGIN_FOLDERNAME] = true
				end
			end
		end

		local isUnloaded = self:IsUnloaded(PLUGIN_FOLDERNAME, true)
		local isDisabled = self:IsDisabled(PLUGIN_FOLDERNAME, true)
		local shPluginDir = directory .. "/sh_plugin.lua"
		local addCSLua = true

		if not isUnloaded and not isDisabled then
			if cwFile.Exists(shPluginDir, "LUA") then
				Clockwork.kernel:IncludePrefixed(shPluginDir)
			end

			addCSLua = false
		end

		if SERVER and addCSLua then
			AddCSLuaFile(shPluginDir)
		end

		PLUGIN:Register()
		PLUGIN = originalPLUGIN
	end
end

--[[
	@codebase Shared
	@details A function to create a new plugin.
	@returns {Unknown}
--]]
function Clockwork.plugin:New()
	local pluginTable = Clockwork.kernel:NewMetaTable(PLUGIN_META)
	pluginTable.baseDir = PLUGIN_BASE_DIR
	pluginTable.folderName = PLUGIN_FOLDERNAME

	return pluginTable
end

--[[
	@codebase Shared
	@details A function to sort a list of plugins storted by k, v.
	@param {Unknown} Missing description for pluginList.
	@returns {Unknown}
--]]
function Clockwork.plugin:SortList(pluginList)
	local sortedTable = {}

	for k, v in pairs(pluginList) do
		sortedTable[#sortedTable + 1] = v
	end
	--[[table.sort(sortedTable, function(a, b)
		return a:GetHookOrder() > b:GetHookOrder();
	end);]]

	return sortedTable
end

--[[
	@codebase Shared
	@details A function to clear the hook cache for all hooks or a specific one.
	@param {Unknown} Missing description for name.
	@returns {Unknown}
--]]
function Clockwork.plugin:ClearHookCache(name)
	if not name then
		hookCache = {}
	elseif hookCache[name] then
		hookCache[name] = nil
	else
		MsgC(Color(255, 100, 0, 255), "[Clockwork:Plugin] Attempted to clear cache for invalid hook '" .. name .. "'")
	end
end

--[[
	@codebase Shared
	@details A function to run the plugin hooks.
	@param {Unknown} Missing description for name.
	@param {Unknown} Missing description for isGamemode.
	@param {Unknown} Missing description for ....
	@returns {Unknown}
--]]
function Clockwork.plugin:RunHooks(name, isGamemode, ...)
	if not self.sortedModules then
		self.sortedModules = self:SortList(modules)
	end

	if not self.sortedPlugins then
		self.sortedPlugins = self:SortList(stored)
	end

	local currentRun = {}

	for k, v in ipairs(self.sortedModules) do
		if modules[v.name] and v[name] then
			table.insert(currentRun, {v[name], v})
		end
	end

	for k, v in ipairs(self.sortedPlugins) do
		if stored[v.name] and Schema ~= v and v[name] then
			table.insert(currentRun, {v[name], v})
		end
	end

	if Schema and Schema[name] then
		table.insert(currentRun, {Schema[name], Schema})
	end

	for k, v in ipairs(currentRun) do
		local wasSuccess, a, b, c = xpcall(v[1], debug.traceback, v[2], ...)

		if not wasSuccess then
			MsgC(Color(255, 100, 0, 255), "[Clockwork:" .. v[2].name .. "] The '" .. name .. "' hook has failed to run.\n" .. a .. "\n")
		elseif a ~= nil then
			return a, b, c
		end
	end

	if isGamemode and Clockwork[name] then
		local wasSuccess, a, b, c = xpcall(Clockwork[name], debug.traceback, Clockwork, ...)

		if not wasSuccess then
			MsgC(Color(255, 100, 0, 255), "[Clockwork:Kernel] The '" .. name .. "' Clockwork hook has failed to run.\n" .. a .. "\n")
		elseif a ~= nil then
			return a, b, c
		end
	end
end

--[[
	@codebase Shared
	@details A function to call a function for all plugins.
	@param {Unknown} Missing description for name.
	@param {Unknown} Missing description for ....
	@returns {Unknown}
--]]
function Clockwork.plugin:Call(name, ...)
	return self:RunHooks(name, true, ...)
end

--[[
	@codebase Shared
	@details A function to remove a module by name.
	@param {Unknown} Missing description for name.
	@returns {Unknown}
--]]
function Clockwork.plugin:Remove(name)
	modules[name] = nil
end

--[[
	@codebase Shared
	@details A function to add a table as a module.
	@param {Unknown} Missing description for name.
	@param {Unknown} Missing description for moduleTable.
	@param {Unknown} Missing description for hookOrder.
	@returns {Unknown}
--]]
function Clockwork.plugin:Add(name, moduleTable, hookOrder)
	if not moduleTable.name then
		moduleTable.name = name
	end

	moduleTable.hookOrder = hookOrder or 0
	modules[name] = moduleTable

	if self.ClearHookCache then
		self:ClearHookCache()
		self.sortedModules = nil
		self.sortedPlugins = nil
	end
end

local function IncludeFolderEntity(path)
	if SERVER then
		if cwFile.Exists(path .. "/init.lua", "LUA") then
			include(path .. "/init.lua")
		elseif cwFile.Exists(path .. "/shared.lua", "LUA") then
			AddCSLuaFile(path .. "/shared.lua")
			include(path .. "/shared.lua")
		end

		if cwFile.Exists(path .. "/cl_init.lua", "LUA") then
			AddCSLuaFile(path .. "/cl_init.lua")
		end
	elseif cwFile.Exists(path .. "/cl_init.lua", "LUA") then
		include(path .. "/cl_init.lua")
	elseif cwFile.Exists(path .. "/shared.lua", "LUA") then
		include(path .. "/shared.lua")
	end
end

--[[
	@codebase Shared
	@details A function to include a plugin's entities.
	@param {Unknown} Missing description for directory.
	@returns {Unknown}
--]]
function Clockwork.plugin:IncludeEntities(directory)
	local path

	local entityFiles, entityFolders = cwFile.Find(directory .. "/entities/entities/*", "LUA", "namedesc")

	for _, v in ipairs(entityFolders) do
		if v == ".." or v == "." then return end

		path = directory .. "/entities/entities/" .. v

		ENT = {
			Type = "anim",
			Base = "base_gmodentity",
			Spawnable = true,
			Folder = path
		}

		IncludeFolderEntity(path)

		scripted_ents.Register(ENT, v)
		ENT = nil
	end


	for _, v in ipairs(entityFiles) do
		if v == ".." or v == "." then return end

		path = directory .. "/entities/entities/" .. v

		ENT = {
			Type = "anim",
			Base = "base_gmodentity",
			Spawnable = true,
			Folder = path
		}

		if SERVER then
			AddCSLuaFile(path)
			include(path)
		else
			include(path)
		end

		scripted_ents.Register(ENT, string.StripExtension(v))
		ENT = nil
	end
end

--[[
	@codebase Shared
	@details A function to include a plugin's effects.
	@param {Unknown} Missing description for directory.
	@returns {Unknown}
--]]
function Clockwork.plugin:IncludeEffects(directory)
	local path

	local effectFiles, effectFolders = cwFile.Find(directory .. "/entities/effects/*", "LUA", "namedesc")

	for _, v in ipairs(effectFolders) do
		if v == ".." or v == "." then return end

		path = directory .. "/entities/effects/" .. v

		if SERVER then
			if cwFile.Exists(path .. "/cl_init.lua", "LUA") then
				AddCSLuaFile(path .. "/cl_init.lua")
			elseif cwFile.Exists(path .. "/init.lua", "LUA") then
				AddCSLuaFile(path .. "/init.lua")
			end
		elseif cwFile.Exists(path .. "/cl_init.lua", "LUA") then
			EFFECT = {
				Folder = path
			}

			include(path .. "/cl_init.lua")

			effects.Register(EFFECT, v)
			EFFECT = nil
		elseif cwFile.Exists(path .. "/init.lua", "LUA") then
			EFFECT = {
				Folder = path
			}

			include(path .. "/init.lua")

			effects.Register(EFFECT, v)
			EFFECT = nil
		end
	end

	for _, v in ipairs(effectFiles) do
		if v == ".." or v == "." then return end

		path = directory .. "/entities/effects/" .. v

		if SERVER then
			AddCSLuaFile(path)
		else
			EFFECT = {
				Folder = path
			}

			include(path)

			effects.Register(EFFECT, string.StripExtension(v))
			EFFECT = nil
		end
	end
end

--[[
	@codebase Shared
	@details A function to include a plugin's weapons.
	@param {Unknown} Missing description for directory.
	@returns {Unknown}
--]]
function Clockwork.plugin:IncludeWeapons(directory)
	local path

	local weaponFiles, weaponFolders = cwFile.Find(directory .. "/entities/weapons/*", "LUA")

	for _, v in ipairs(weaponFolders) do
		if v == ".." or v == "." then return end

		path = directory .. "/entities/weapons/" .. v

		SWEP = {
			Folder = path,
			Base = "weapon_base",
			Primary = {},
			Secondary = {}
		}

		IncludeFolderEntity(path)

		weapons.Register(SWEP, v)
		SWEP = nil
	end

	for _, v in ipairs(weaponFiles) do
		if v == ".." or v == "." then return end

		path = directory .. "/entities/weapons/" .. v

		SWEP = {
			Folder = path,
			Base = "weapon_base",
			Primary = {},
			Secondary = {}
		}

		if SERVER then
			AddCSLuaFile(path)
			include(path)
		else
			include(path)
		end

		weapons.Register(SWEP, string.StripExtension(v))
		SWEP = nil
	end
end

--[[
	@codebase Shared
	@details A function to include a plugin's plugins.
	@param {Unknown} Missing description for directory.
	@returns {Unknown}
--]]
function Clockwork.plugin:IncludePlugins(directory)
	local _, pluginFolders = cwFile.Find(directory .. "/plugins/*", "LUA", "namedesc")

	if not self:HasInitialized() then
		self:Initialize()
	end

	for k, v in ipairs(pluginFolders) do
		self:Include(directory .. "/plugins/" .. v .. "/plugin")
	end
end

--[[
	@codebase Shared
	@details A function to add an extra folder to include for plugins.
	@param {Unknown} Missing description for folderName.
	@returns {Unknown}
--]]
function Clockwork.plugin:AddExtra(folderName)
	if not table.HasValue(extras, folderName) then
		extras[#extras + 1] = folderName
	end
end

--[[
	@codebase Shared
	@details A function to include a plugin's extras.
	@param {Unknown} Missing description for directory.
	@returns {Unknown}
--]]
function Clockwork.plugin:IncludeExtras(directory)
	self:IncludeEffects(directory)
	self:IncludeWeapons(directory)
	self:IncludeEntities(directory)

	for k, v in ipairs(extras) do
		Clockwork.kernel:IncludeDirectory(directory .. v)
	end
end

Clockwork.plugin:AddExtra("/libraries/")
Clockwork.plugin:AddExtra("/directory/")
Clockwork.plugin:AddExtra("/system/")
Clockwork.plugin:AddExtra("/factions/")
Clockwork.plugin:AddExtra("/classes/")
Clockwork.plugin:AddExtra("/traits/")
Clockwork.plugin:AddExtra("/attributes/")
Clockwork.plugin:AddExtra("/items/")
Clockwork.plugin:AddExtra("/derma/")
Clockwork.plugin:AddExtra("/commands/")
Clockwork.plugin:AddExtra("/language/")
Clockwork.plugin:AddExtra("/config/")
Clockwork.plugin:AddExtra("/tools/")
Clockwork.plugin:AddExtra("/blueprints/")
Clockwork.plugin:AddExtra("/themes/")