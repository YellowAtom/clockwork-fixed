--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]
--[[ Initiate the shared booting process. --]]
include("sh_boot.lua")
--[[
	Micro-optimizations.
	We do this because local variables are faster to access than global ones.
--]]
local Clockwork = Clockwork
local RunConsoleCommand = RunConsoleCommand
local DeriveGamemode = DeriveGamemode
local FindMetaTable = FindMetaTable
local AddCSLuaFile = AddCSLuaFile
local ErrorNoHalt = ErrorNoHalt
local FrameTime = FrameTime
local tonumber = tonumber
local tostring = tostring
local SysTime = SysTime
local CurTime = CurTime
local IsValid = IsValid
local Vector = Vector
local Angle = Angle
local Color = Color
local pairs = pairs
local print = print
local concommand = concommand
local player = player
local timer = timer
local table = table
local ents = ents
local hook = hook
local math = math
local game = game
local os = os
--[[ Clockwork Library Localizations --]]
local cwConfig = Clockwork.config
local cwPly = Clockwork.player
local cwPlugin = Clockwork.plugin
local cwStorage = Clockwork.storage
local cwEvent = Clockwork.event
local cwLimb = Clockwork.limb
local cwItem = Clockwork.item
local cwEntity = Clockwork.entity
local cwKernel = Clockwork.kernel
local cwOption = Clockwork.option
local cwBans = Clockwork.bans
local cwDatabase = Clockwork.database
local cwDatastream = Clockwork.datastream
local cwFaction = Clockwork.faction
local cwInventory = Clockwork.inventory
local cwHint = Clockwork.hint
local cwCommand = Clockwork.command
local cwClass = Clockwork.class
local cwQuiz = Clockwork.quiz
local cwAttributes = Clockwork.attributes
local cwChatbox = Clockwork.chatBox

--[[ Downloads the content addon for clients. --]]
-- resource.AddWorkshop("1828874406"); -- Replace this with UG's version of clockwork's content.

--[[ Do this internally, because it's one less step for schemas. --]]
AddCSLuaFile(cwKernel:GetSchemaGamemodePath() .. "/cl_init.lua")

--[[
	Derive from Sandbox, because we want the spawn menu and such!
	We also want the base Sandbox entities and weapons.
--]]
DeriveGamemode("sandbox")

--[[
	This is a hack to stop file.Read returning an unnecessary newline
	at the end of each file when using Linux.
--]]
if system.IsLinux() then
	local ClockworkFileRead = file.Read

	function file.Read(fileName, pathName)
		local contents = ClockworkFileRead(fileName, pathName)

		if contents and utf8.len(contents) and string.utf8sub(contents, -1) == "\n" then
			contents = string.utf8sub(contents, 1, -2)
		end

		return contents
	end
end

--[[
	This is a hack to allow us to call plugin hooks based
	on default GMod hooks that are called.

	It modifies the hook.Call funtion to call hooks inside Clockwork plugins
	as well as hooks that are added normally with hook.Add.
--]]
hook.ClockworkCall = hook.ClockworkCall or hook.Call
hook.Timings = hook.Timings or {}
hook.Averages = hook.Averages or {}

function hook.Call(name, gamemode, ...)
	if name == "EntityTakeDamage" then
		if cwKernel:DoEntityTakeDamageHook(...) then return end
	elseif name == "PlayerDisconnected" then
		local arguments = {...}

		if not IsValid(arguments[1]) then return end
	end

	local status, a, b, c = xpcall(cwPlugin.RunHooks, debug.traceback, cwPlugin, name, nil, ...)

	if not status then
		MsgC(Color(255, 100, 0, 255), "[Clockwork:Kernel] The '" .. name .. "' hook has failed to run.\n" .. a .. "\n")
	end

	if a == nil or name == "Think" then
		status, a, b, c = xpcall(hook.ClockworkCall, debug.traceback, name, gamemode or Clockwork, ...)

		if not status then
			MsgC(Color(255, 100, 0, 255), "[Clockwork:Kernel] The '" .. name .. "' hook failed to run.\n" .. a .. "\n")
		else
			return a, b, c
		end
	else
		return a, b, c
	end
end

--[[
	@codebase Server
	@details Called when the Clockwork kernel has loaded.
--]]
function Clockwork:ClockworkKernelLoaded()
end

--[[
	@codebase Server
	@details Called when the Clockwork schema has loaded.
--]]
function Clockwork:ClockworkSchemaLoaded()
end

--[[
	@codebase Server
	@details Called when the server has initialized.
--]]
function Clockwork:Initialize()
	cwItem:Initialize()

	cwConfig:Import("gamemodes/clockwork/clockwork.cfg")
	cwPlugin:Call("ClockworkKernelLoaded")

	local useLocalMachineDate = cwConfig:Get("use_local_machine_date"):Get()
	local useLocalMachineTime = cwConfig:Get("use_local_machine_time"):Get()

	local defaultDate = cwOption:GetKey("default_date")
	local defaultTime = cwOption:GetKey("default_time")
	local defaultDays = cwOption:GetKey("default_days")
	local dateInfo = os.date("*t")

	local adapter = cwConfig:Get("mysql_adapter"):Get()
	local host = string.gsub(cwConfig:Get("mysql_host"):Get(), "^http[s]?://", "", 1) -- Matches at beginning of string, matches http:// or https://, no need to check twice
	local username = cwConfig:Get("mysql_username"):Get()
	local password = cwConfig:Get("mysql_password"):Get()
	local database = cwConfig:Get("mysql_database"):Get()
	local port = cwConfig:Get("mysql_port"):Get()

	cwDatabase:Connect(adapter, host, username, password, database, port)

	if useLocalMachineTime then
		cwConfig:Get("minute_time"):Set(60)
	end

	cwConfig:SetInitialized(true)
	table.Merge(self.time, defaultTime)
	table.Merge(self.date, defaultDate)
	math.randomseed(os.time())

	if useLocalMachineTime then
		local realDay = dateInfo.wday - 1

		if realDay == 0 then
			realDay = #defaultDays
		end

		table.Merge(self.time, {
			minute = dateInfo.min,
			hour = dateInfo.hour,
			day = realDay
		})

		self.NextDateTimeThink = SysTime() + (60 - dateInfo.sec)
	else
		table.Merge(self.time, cwKernel:RestoreSchemaData("time"))
	end

	if useLocalMachineDate then
		dateInfo.year = dateInfo.year + (defaultDate.year - dateInfo.year)

		table.Merge(self.time, {
			month = dateInfo.month,
			year = dateInfo.year,
			day = dateInfo.yday
		})
	else
		table.Merge(self.date, cwKernel:RestoreSchemaData("date"))
	end

	CW_CONVAR_LOG = cwKernel:CreateConVar("cwLog", 1)

	for k, v in pairs(cwConfig.stored) do
		cwPlugin:Call("ClockworkConfigInitialized", k, v.value)
	end

	cwPlugin:Call("ClockworkInitialized")
	cwPlugin:CheckMismatches()
	cwPlugin:ClearHookCache()
	hook.Remove("PlayerTick", "TickWidgets")
	--[[ Hotfix to allow downloads ]]
	--
	hook.Remove("Think", "exploit.fix")
	RunConsoleCommand("sv_allowdownload", "1")
end

--[[
	@codebase Server
	@details Called at an interval while a player is connected.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for curTime.
	@param {Unknown} Missing description for infoTable.
	@returns {Unknown}
--]]
function Clockwork:PlayerThink(player, curTime, infoTable)
	local storageTable = player:GetStorageTable()

	if not cwConfig:Get("cash_enabled"):Get() then
		player:SetCharacterData("Cash", 0, true)
		infoTable.wages = 0
	end

	if player.cwReloadHoldTime and curTime >= player.cwReloadHoldTime then
		cwPly:ToggleWeaponRaised(player)
		player.cwReloadHoldTime = nil
		player.cwNextShootTime = curTime + cwConfig:Get("shoot_after_raise_time"):Get()
	end

	if player:IsRagdolled() then
		player:SetMoveType(MOVETYPE_OBSERVER)
	end

	if storageTable and cwPlugin:Call("PlayerStorageShouldClose", player, storageTable) then
		cwStorage:Close(player)
	end

	player:SetSharedVar("InvWeight", math.ceil(infoTable.inventoryWeight))
	player:SetSharedVar("InvSpace", math.ceil(infoTable.inventorySpace))
	player:SetSharedVar("Wages", math.ceil(infoTable.wages))

	if cwEvent:CanRun("limb_damage", "disability") then
		local leftLeg = cwLimb:GetDamage(player, HITGROUP_LEFTLEG, true)
		local rightLeg = cwLimb:GetDamage(player, HITGROUP_RIGHTLEG, true)
		local legDamage = math.max(leftLeg, rightLeg)

		if legDamage > 0 then
			infoTable.runSpeed = infoTable.runSpeed / (1 + legDamage)
			infoTable.jumpPower = infoTable.jumpPower / (1 + legDamage)
		end
	end

	if player:KeyDown(IN_BACK) then
		infoTable.runSpeed = infoTable.runSpeed * 0.5
	end

	if infoTable.isJogging then
		infoTable.walkSpeed = infoTable.walkSpeed * 1.75
	end

	if infoTable.runSpeed < infoTable.walkSpeed then
		infoTable.runSpeed = infoTable.walkSpeed
	end

	--[[ Update whether the weapon has fired, or is being raised. --]]
	player:UpdateWeaponFired()
	player:UpdateWeaponRaised()
	player:SetSharedVar("IsRunMode", infoTable.isRunning)
	player:SetCrouchedWalkSpeed(math.max(infoTable.crouchedSpeed, 0), true)
	player:SetWalkSpeed(math.max(infoTable.walkSpeed, 0), true)
	player:SetJumpPower(math.max(infoTable.jumpPower, 0), true)
	player:SetRunSpeed(math.max(infoTable.runSpeed, 0), true)
	local activeWeapon = player:GetActiveWeapon()
	local weaponItemTable = cwItem:GetByWeapon(activeWeapon)

	if weaponItemTable and weaponItemTable:IsInstance() then
		local clipOne = activeWeapon:Clip1()
		local clipTwo = activeWeapon:Clip2()

		if clipOne >= 0 then
			weaponItemTable:SetData("ClipOne", clipOne)
		end

		if clipTwo >= 0 then
			weaponItemTable:SetData("ClipTwo", clipTwo)
		end
	end

	if not player:KeyDown(IN_SPEED) then return end
	local traceLine = player:GetEyeTraceNoCursor()
	local velocity = player:GetVelocity():Length()
	local entity = traceLine.Entity
	if traceLine.HitPos:Distance(player:GetShootPos()) > math.max(48, math.min(velocity, 256)) or not IsValid(entity) then return end
	if entity:GetClass() ~= "prop_door_rotating" or cwPly:IsNoClipping(player) then return end
	local doorPartners = cwEntity:GetDoorPartners(entity)

	for k, v in pairs(doorPartners) do
		if (not cwEntity:IsDoorLocked(v) and cwConfig:Get("bash_in_door_enabled"):Get()) and (not v.cwNextBashDoor or curTime >= v.cwNextBashDoor) then
			cwEntity:BashInDoor(v, player)
			player:ViewPunch(Angle(math.Rand(-32, 32), math.Rand(-80, 80), math.Rand(-16, 16)))
		end
	end
end

--[[
	@codebase Server
	@details Called when a player fires a weapon.
	@returns {Unknown}
--]]
function Clockwork:PlayerFireWeapon(player, weapon, clipType, ammoType)
end

--[[
	@codebase Server
	@details Called when a player has disconnected.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerDisconnected(player)
	local tempData = player:CreateTempData()

	if player:HasInitialized() then
		if cwPlugin:Call("PlayerCharacterUnloaded", player) ~= true then
			player:SaveCharacter()
		end

		if tempData then
			cwPlugin:Call("PlayerSaveTempData", player, tempData)
		end

		cwKernel:PrintLog(LOGTYPE_MINOR, {"LogPlayerDisconnected", player:Name(), player:SteamID(), player:IPAddress()})

		cwChatbox:Add(nil, nil, "disconnect", {"PlayerDisconnected", player:SteamName()})
	end
end

--[[
	@codebase Server
	@details Called when CloudAuth has been validated.
	@returns {Unknown}
--]]
function Clockwork:CloudAuthValidated()
end

--[[
	@codebase Server
	@details Called when CloudAuth has been blacklisted.
	@returns {Unknown}
--]]
function Clockwork:CloudAuthBlacklisted()
	self.Unauthorized = true
end

--[[
	@codebase Server
	@details Called when Clockwork has initialized.
	@returns {Unknown}
--]]
function Clockwork:ClockworkInitialized()
	if not cwConfig:Get("cash_enabled"):Get() then
		cwCommand:SetHidden("GiveCash", true)
		cwCommand:SetHidden("DropCash", true)
		cwCommand:SetHidden("StorageTakeCash", true)
		cwCommand:SetHidden("StorageGiveCash", true)
		cwConfig:Get("scale_prop_cost"):Set(0, nil, true, true)
		cwConfig:Get("door_cost"):Set(0, nil, true, true)
	end

	if cwConfig:Get("use_own_group_system"):Get() then
		cwCommand:SetHidden("PlySetGroup", true)
		cwCommand:SetHidden("PlyDemote", true)
	end

	--[[ local gradientTexture = cwOption:GetKey("gradient")
	local schemaLogo = cwOption:GetKey("schema_logo")
	local introImage = cwOption:GetKey("intro_image")

	if (gradientTexture != "gui/gradient_up") then
		cwKernel:AddFile("materials/"..gradientTexture..".png")
	end

	if (schemaLogo != "") then
		cwKernel:AddFile("materials/"..schemaLogo..".png")
	end

	if (introImage != "") then
		cwKernel:AddFile("materials/"..introImage..".png")
	end ]]

	local toolGun = weapons.GetStored("gmod_tool")

	for k, v in pairs(self.tool:GetAll()) do
		toolGun.Tool[v.Mode] = v
	end
end

--[[
	@codebase Server
	@details Called when the Clockwork database has connected.
	@returns {Unknown}
--]]
function Clockwork:ClockworkDatabaseConnected()
	cwBans:Load()
end

--[[
	@codebase Server
	@details Called when the Clockwork database connection fails.
	@returns {Unknown}
--]]
function Clockwork:ClockworkDatabaseConnectionFailed()
	cwDatabase:Error(errText)
end

--[[
	@codebase Server
	@details Called when Clockwork should log and event.
	@returns {Unknown}
--]]
function Clockwork:ClockworkLog(text, unixTime)
end

--[[
	@codebase Server
	@details Called when a player is banned.
	@returns {Unknown}
--]]
function Clockwork:PlayerBanned(player, duration, reason)
end

--[[
	@codebase Server
	@details Called when a player's skin has changed.
	@returns {Unknown}
--]]
function Clockwork:PlayerSkinChanged(player, skin)
end

--[[
	@codebase Server
	@details Called when a player's model has changed.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for model.
	@returns {Unknown}
--]]
function Clockwork:PlayerModelChanged(player, model)
	local hands = player:GetHands()

	if IsValid(hands) and hands:IsValid() then
		self:PlayerSetHandsModel(player, player:GetHands())
	end
end

--[[
	@codebase Server
	@details Called when a player's saved inventory should be added to.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for character.
	@param {Unknown} Missing description for Callback.
	@returns {Unknown}
--]]
function Clockwork:PlayerAddToSavedInventory(player, character, Callback)
	for k, v in pairs(player:GetWeapons()) do
		local weaponItemTable = cwItem:GetByWeapon(v)

		if weaponItemTable then
			Callback(weaponItemTable)
		end
	end
end

--[[
	@codebase Server
	@details Called when a player's unlock info is needed.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:PlayerGetUnlockInfo(player, entity)
	if cwEntity:IsDoor(entity) then
		local unlockTime = cwConfig:Get("unlock_time"):Get()

		if cwEvent:CanRun("limb_damage", "unlock_time") then
			local leftArm = cwLimb:GetDamage(player, HITGROUP_LEFTARM, true)
			local rightArm = cwLimb:GetDamage(player, HITGROUP_RIGHTARM, true)
			local armDamage = math.max(leftArm, rightArm)

			if armDamage > 0 then
				unlockTime = unlockTime * (1 + armDamage)
			end
		end

		return {
			duration = unlockTime,
			Callback = function(player, entity)
				entity:Fire("unlock", "", 0)
			end
		}
	end
end

--[[
	@codebase Server
	@details Called when an Clockwork item has initialized.
	@returns {Unknown}
--]]
function Clockwork:ClockworkItemInitialized(itemTable)
end

--[[
	@codebase Server
	@details Called after Clockwork items have been initialized.
	@param {Table} The table of items that have been initialized.
--]]
function Clockwork:ClockworkPostItemsInitialized(itemsTable)
end

--[[
	@codebase Server
	@details Called when a player's lock info is needed.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:PlayerGetLockInfo(player, entity)
	if cwEntity:IsDoor(entity) then
		local lockTime = cwConfig:Get("lock_time"):Get()

		if cwEvent:CanRun("limb_damage", "lock_time") then
			local leftArm = cwLimb:GetDamage(player, HITGROUP_LEFTARM, true)
			local rightArm = cwLimb:GetDamage(player, HITGROUP_RIGHTARM, true)
			local armDamage = math.max(leftArm, rightArm)

			if armDamage > 0 then
				lockTime = lockTime * (1 + armDamage)
			end
		end

		return {
			duration = lockTime,
			Callback = function(player, entity)
				entity:Fire("lock", "", 0)
			end
		}
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to fire a weapon.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for bIsRaised.
	@param {Unknown} Missing description for weapon.
	@param {Unknown} Missing description for bIsSecondary.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanFireWeapon(player, bIsRaised, weapon, bIsSecondary)
	local canShootTime = player.cwNextShootTime
	local curTime = CurTime()
	if player:IsRunning() and cwConfig:Get("sprint_lowers_weapon"):Get() then return false end
	if not bIsRaised and not cwPlugin:Call("PlayerCanUseLoweredWeapon", player, weapon, bIsSecondary) then return false end
	if canShootTime and canShootTime > curTime then return false end

	if cwEvent:CanRun("limb_damage", "weapon_fire") then
		local leftArm = cwLimb:GetDamage(player, HITGROUP_LEFTARM, true)
		local rightArm = cwLimb:GetDamage(player, HITGROUP_RIGHTARM, true)
		local armDamage = math.max(leftArm, rightArm)
		if armDamage == 0 then return true end

		if player.cwArmDamageNoFire then
			if curTime >= player.cwArmDamageNoFire then
				player.cwArmDamageNoFire = nil
			end

			return false
		else
			if not player.cwNextArmDamage then
				player.cwNextArmDamage = curTime + (1 - armDamage * 0.5)
			end

			if curTime >= player.cwNextArmDamage then
				player.cwNextArmDamage = nil

				if math.random() <= armDamage * 0.75 then
					player.cwArmDamageNoFire = curTime + (1 + armDamage * 2)
				end
			end
		end
	end

	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to use a lowered weapon.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for weapon.
	@param {Unknown} Missing description for secondary.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanUseLoweredWeapon(player, weapon, secondary)
	if secondary then
		return weapon.NeverRaised or weapon.Secondary and weapon.Secondary.NeverRaised
	else
		return weapon.NeverRaised or weapon.Primary and weapon.Primary.NeverRaised
	end
end

--[[
	@codebase Server
	@details Called when a player's recognised names have been cleared.
	@returns {Unknown}
--]]
function Clockwork:PlayerRecognisedNamesCleared(player, status, isAccurate)
end

--[[
	@codebase Server
	@details Called when a player's name has been cleared.
	@returns {Unknown}
--]]
function Clockwork:PlayerNameCleared(player, status, isAccurate)
end

--[[
	@codebase Server
	@details Called when an offline player has been given property.
	@returns {Unknown}
--]]
function Clockwork:PlayerPropertyGivenOffline(key, uniqueID, entity, networked, removeDelay)
end

--[[
	@codebase Server
	@details Called when an offline player has had property taken.
	@returns {Unknown}
--]]
function Clockwork:PlayerPropertyTakenOffline(key, uniqueID, entity)
end

--[[
	@codebase Server
	@details Called when a player has been given property.
	@returns {Unknown}
--]]
function Clockwork:PlayerPropertyGiven(player, entity, networked, removeDelay)
end

--[[
	@codebase Server
	@details Called when a player has had property taken.
	@returns {Unknown}
--]]
function Clockwork:PlayerPropertyTaken(player, entity)
end

--[[
	@codebase Server
	@details Called when a player has been given flags.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for flags.
	@returns {Unknown}
--]]
function Clockwork:PlayerFlagsGiven(player, flags)
	if string.find(flags, "p") and player:Alive() then
		cwPly:GiveSpawnWeapon(player, "weapon_physgun")
	end

	if string.find(flags, "t") and player:Alive() then
		cwPly:GiveSpawnWeapon(player, "gmod_tool")
	end

	player:SetSharedVar("Flags", player:GetFlags())
end

--[[
	@codebase Server
	@details Called when a player has had flags taken.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for flags.
	@returns {Unknown}
--]]
function Clockwork:PlayerFlagsTaken(player, flags)
	if string.find(flags, "p") and player:Alive() then
		if not cwPly:HasFlags(player, "p") then
			cwPly:TakeSpawnWeapon(player, "weapon_physgun")
		end
	end

	if string.find(flags, "t") and player:Alive() then
		if not cwPly:HasFlags(player, "t") then
			cwPly:TakeSpawnWeapon(player, "gmod_tool")
		end
	end

	player:SetSharedVar("Flags", player:GetFlags())
end

--[[
	@codebase Server
	@details Called when a player's phys desc override is needed.
	@returns {Unknown}
--]]
function Clockwork:GetPlayerPhysDescOverride(player, physDesc)
end

--[[
	@codebase Server
	@details Called when a player's default skin is needed.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:GetPlayerDefaultSkin(player)
	local _, skin = cwClass:GetAppropriateModel(player:Team(), player)

	return skin
end

--[[
	@codebase Server
	@details Called when a player's default model is needed.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:GetPlayerDefaultModel(player)
	local model, _ = cwClass:GetAppropriateModel(player:Team(), player)

	return model
end

--[[
	@codebase Server
	@details Called when a player's default inventory is needed.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for character.
	@param {Unknown} Missing description for inventory.
	@returns {Unknown}
--]]
function Clockwork:GetPlayerDefaultInventory(player, character, inventory)
	local startingInv = cwFaction:FindByID(character.faction).startingInv

	if istable(startingInv) then
		for k, v in pairs(startingInv) do
			cwInventory:AddInstance(inventory, cwItem:CreateInstance(k), v)
		end
	end
end

--[[
	@codebase Server
	@details Called to get whether a player's weapon is raised.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for class.
	@param {Unknown} Missing description for weapon.
	@returns {Unknown}
--]]
function Clockwork:GetPlayerWeaponRaised(player, class, weapon)
	if cwKernel:IsDefaultWeapon(weapon) then return true end
	if player:IsRunning() and cwConfig:Get("sprint_lowers_weapon"):Get() then return false end
	if weapon:GetNWBool("Ironsights") then return true end
	if weapon:GetNWInt("Zoom") ~= 0 then return true end
	if weapon:GetNWBool("Scope") then return true end

	if cwConfig:Get("raised_weapon_system"):Get() then
		if player.cwWeaponRaiseClass == class then
			return true
		else
			player.cwWeaponRaiseClass = nil
		end

		if player.cwAutoWepRaised == class then
			return true
		else
			player.cwAutoWepRaised = nil
		end

		return false
	end

	return true
end

--[[
	@codebase Server
	@details Called when a player's attribute has been updated.
	@returns {Unknown}
--]]
function Clockwork:PlayerAttributeUpdated(player, attributeTable, amount)
end

--[[
	@codebase Server
	@details Called to get whether a player can give an item to storage.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for storageTable.
	@param {Unknown} Missing description for itemTable.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanGiveToStorage(player, storageTable, itemTable)
	return true
end

--[[
	@codebase Server
	@details Called to get whether a player can take an item to storage.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for storageTable.
	@param {Unknown} Missing description for itemTable.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanTakeFromStorage(player, storageTable, itemTable)
	if itemTable.cwPropertyTab and cwEntity:BelongsToAnotherCharacter(player, itemTable) then
		cwPly:Notify(player, L(player, "CannotTakeItemStored"))

		return false
	end

	return true
end

--[[
	@codebase Server
	@details Called when a player has given an item to storage.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for storageTable.
	@param {Unknown} Missing description for itemTable.
	@returns {Unknown}
--]]
function Clockwork:PlayerGiveToStorage(player, storageTable, itemTable)
	itemTable.cwPropertyTab = itemTable.cwPropertyTab or {
		key = player:GetCharacterKey(),
		uniqueID = player:UniqueID()
	}

	if player:IsWearingItem(itemTable) then
		player:RemoveClothes()
	end

	if player:IsWearingAccessory(itemTable) then
		player:RemoveAccessory(itemTable)
	end
end

--[[
	@codebase Server
	@details Called when a player has taken an item to storage.
	@returns {Unknown}
--]]
function Clockwork:PlayerTakeFromStorage(player, storageTable, itemTable)
	itemTable.cwPropertyTab = nil
end

--[[
	@codebase Server
	@details Called when a player is given an item.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for itemTable.
	@param {Unknown} Missing description for shouldForce.
	@returns {Unknown}
--]]
function Clockwork:PlayerItemGiven(player, itemTable, shouldForce)
	cwStorage:SyncItem(player, itemTable)
end

--[[
	@codebase Server
	@details Called when a player has an item taken.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for itemTable.
	@returns {Unknown}
--]]
function Clockwork:PlayerItemTaken(player, itemTable)
	cwStorage:SyncItem(player, itemTable)

	if player:IsWearingItem(itemTable) then
		player:RemoveClothes()
	end

	if player:IsWearingAccessory(itemTable) then
		player:RemoveAccessory(itemTable)
	end
end

--[[
	@codebase Server
	@details Called when a player's cash has been updated.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for amount.
	@param {Unknown} Missing description for reason.
	@param {Unknown} Missing description for bNoMsg.
	@returns {Unknown}
--]]
function Clockwork:PlayerCashUpdated(player, amount, reason, bNoMsg)
	cwStorage:SyncCash(player)
end

--[[
	@codebase Server
	@details A function to scale damage by hit group.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for attacker.
	@param {Unknown} Missing description for hitGroup.
	@param {Unknown} Missing description for damageInfo.
	@param {Unknown} Missing description for baseDamage.
	@returns {Unknown}
--]]
function Clockwork:PlayerScaleDamageByHitGroup(player, attacker, hitGroup, damageInfo, baseDamage)
	if attacker:IsVehicle() or attacker:IsPlayer() and attacker:InVehicle() then
		damageInfo:ScaleDamage(0.25)
	end
end

--[[
	@codebase Server
	@details Called when a player switches their flashlight on or off.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for bIsOn.
	@returns {Unknown}
--]]
function Clockwork:PlayerSwitchFlashlight(player, bIsOn)
	if player:HasInitialized() and bIsOn and player:IsRagdolled() then return false end

	return true
end

--[[
	@codebase Server
	@details Called when time has passed.
	@returns {Unknown}
--]]
function Clockwork:TimePassed(quantity)
end

--[[
	@codebase Server
	@details Called when Clockwork config has initialized.
	@param {Unknown} Missing description for key.
	@param {Unknown} Missing description for value.
	@returns {Unknown}
--]]
function Clockwork:ClockworkConfigInitialized(key, value)
	if key == "cash_enabled" and not value then
		for k, v in pairs(cwItem:GetAll()) do
			v.cost = 0
		end
	elseif key == "local_voice" then
		if value then
			RunConsoleCommand("sv_alltalk", "0")
		end
	elseif key == "use_smooth_rates" then
		if value then
			RunConsoleCommand("sv_maxupdaterate", "66")
			RunConsoleCommand("sv_minupdaterate", "0")
			RunConsoleCommand("sv_maxcmdrate", "66")
			RunConsoleCommand("sv_mincmdrate", "0")
			RunConsoleCommand("sv_maxrate", "25000")
			RunConsoleCommand("sv_minrate", "0")
		end
	elseif key == "use_mid_performance_rates" then
		if value then
			RunConsoleCommand("sv_maxupdaterate", "40")
			RunConsoleCommand("sv_minupdaterate", "0")
			RunConsoleCommand("sv_maxcmdrate", "40")
			RunConsoleCommand("sv_mincmdrate", "0")
			RunConsoleCommand("sv_maxrate", "25000")
			RunConsoleCommand("sv_minrate", "0")
		end
	elseif key == "use_lag_free_rates" then
		if value then
			RunConsoleCommand("sv_maxupdaterate", "24")
			RunConsoleCommand("sv_minupdaterate", "0")
			RunConsoleCommand("sv_maxcmdrate", "24")
			RunConsoleCommand("sv_mincmdrate", "0")
			RunConsoleCommand("sv_maxrate", "25000")
			RunConsoleCommand("sv_minrate", "0")
		end
	end
end

--[[
	@codebase Server
	@details Called when a Clockwork ConVar has changed.
	@param {Unknown} Missing description for name.
	@param {Unknown} Missing description for previousValue.
	@param {Unknown} Missing description for newValue.
	@returns {Unknown}
--]]
function Clockwork:ClockworkConVarChanged(name, previousValue, newValue)
	if name == "local_voice" and newValue then
		RunConsoleCommand("sv_alltalk", "1")
	end
end

--[[
	@codebase Server
	@details Called when Clockwork config has changed.
	@param {Unknown} Missing description for key.
	@param {Unknown} Missing description for data.
	@param {Unknown} Missing description for previousValue.
	@param {Unknown} Missing description for newValue.
	@returns {Unknown}
--]]
function Clockwork:ClockworkConfigChanged(key, data, previousValue, newValue)
	local plyTable = player.GetAll()

	if key == "default_flags" then
		for k, v in pairs(plyTable) do
			if v:HasInitialized() and v:Alive() then
				if string.find(previousValue, "p") then
					if not string.find(newValue, "p") then
						if not cwPly:HasFlags(v, "p") then
							cwPly:TakeSpawnWeapon(v, "weapon_physgun")
						end
					end
				elseif not string.find(previousValue, "p") then
					if string.find(newValue, "p") then
						cwPly:GiveSpawnWeapon(v, "weapon_physgun")
					end
				end

				if string.find(previousValue, "t") then
					if not string.find(newValue, "t") then
						if not cwPly:HasFlags(v, "t") then
							cwPly:TakeSpawnWeapon(v, "gmod_tool")
						end
					end
				elseif not string.find(previousValue, "t") then
					if string.find(newValue, "t") then
						cwPly:GiveSpawnWeapon(v, "gmod_tool")
					end
				end
			end
		end
	elseif key == "use_own_group_system" then
		if newValue then
			cwCommand:SetHidden("PlySetGroup", true)
			cwCommand:SetHidden("PlyDemote", true)
		else
			cwCommand:SetHidden("PlySetGroup", false)
			cwCommand:SetHidden("PlyDemote", false)
		end
	elseif key == "crouched_speed" then
		for k, v in pairs(plyTable) do
			v:SetCrouchedWalkSpeed(newValue)
		end
	elseif key == "ooc_interval" then
		for k, v in pairs(plyTable) do
			v.cwNextTalkOOC = nil
		end
	elseif key == "jump_power" then
		for k, v in pairs(plyTable) do
			v:SetJumpPower(newValue)
		end
	elseif key == "walk_speed" then
		for k, v in pairs(plyTable) do
			v:SetWalkSpeed(newValue)
		end
	elseif key == "run_speed" then
		for k, v in pairs(plyTable) do
			v:SetRunSpeed(newValue)
		end
	end
end

--[[
	@codebase Server
	@details Called when a player's name has changed.
	@returns {Unknown}
--]]
function Clockwork:PlayerNameChanged(player, previousName, newName)
end

--[[
	@codebase Server
	@details Called when a player attempts to sprays their tag.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpray(player)
	if not player:Alive() or player:IsRagdolled() then
		return true
	elseif cwEvent:CanRun("config", "player_spray") then
		return cwConfig:Get("disable_sprays"):Get()
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to use an entity.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:PlayerUse(player, entity)
	if player:IsRagdolled(RAGDOLL_FALLENOVER) then
		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player throws a punch.
	@returns {Unknown}
--]]
function Clockwork:PlayerPunchThrown(player)
end

--[[
	@codebase Server
	@details Called when a player knocks on a door.
	@returns {Unknown}
--]]
function Clockwork:PlayerKnockOnDoor(player, door)
end

--[[
	@codebase Server
	@details Called when a player attempts to knock on a door.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanKnockOnDoor(player, door)
	return true
end

--[[
	@codebase Server
	@details Called when a player uses a ration.
	@returns {Unknown}
--]]
function Clockwork:PlayerUseRation(player)
	return true
end

--[[
	@codebase Server
	@details Called when a player punches an entity.
	@returns {Unknown}
--]]
function Clockwork:PlayerPunchEntity(player, entity)
end

--[[
	Called when a player orders an item shipment.

	If itemTables is set, the order is a shipment. This means that
	you should use the itemTables table, and not the itemTable parameter.
--]]
function Clockwork:PlayerOrderShipment(player, itemTable, entity, itemTables)
end

--[[
	@codebase Server
	@details Called when a player holsters a weapon.
	@returns {Unknown}
--]]
function Clockwork:PlayerHolsterWeapon(player, itemTable, weapon, shouldForce)
end

--[[
	@codebase Server
	@details Called when a player attempts to save a recognised name.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for target.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanSaveRecognisedName(player, target)
	if player ~= target then return true end
end

--[[
	@codebase Server
	@details Called when a player attempts to restore a recognised name.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for target.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanRestoreRecognisedName(player, target)
	if player ~= target then return true end
end

--[[
	@codebase Server
	@details Called when a player attempts to order an item shipment.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for itemTable.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanOrderShipment(player, itemTable)
	local curTime = CurTime()
	if player.cwNextOrderTime and curTime < player.cwNextOrderTime then return false end

	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to get up.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanGetUp(player)
	return true
end

--[[
	@codebase Server
	@details Called when a player knocks out a player with a punch.
	@returns {Unknown}
--]]
function Clockwork:PlayerPunchKnockout(player, target)
end

--[[
	@codebase Server
	@details Called when a player attempts to throw a punch.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanThrowPunch(player)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to punch an entity.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanPunchEntity(player, entity)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to knock a player out with a punch.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanPunchKnockout(player, target)
	return true
end

--[[
	@codebase Server
	@details Called when a player gets damaged and should receive knockback.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanTakeKnockbackFromDamage(player, damageInfo)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to bypass the faction limit.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanBypassFactionLimit(player, character)
	return false
end

--[[
	@codebase Server
	@details Called when a player attempts to bypass the class limit.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanBypassClassLimit(player, class)
	return false
end

--[[
	@codebase Server
	@details Called when a player's pain sound should be played.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for gender.
	@param {Unknown} Missing description for damageInfo.
	@param {Unknown} Missing description for hitGroup.
	@returns {Unknown}
--]]
function Clockwork:PlayerPlayPainSound(player, gender, damageInfo, hitGroup)
	if damageInfo:IsBulletDamage() and math.random() <= 0.5 then
		if hitGroup == HITGROUP_HEAD then
			return "vo/npc/" .. gender .. "01/ow0" .. math.random(1, 2) .. ".wav"
		elseif hitGroup == HITGROUP_CHEST or hitGroup == HITGROUP_GENERIC then
			return "vo/npc/" .. gender .. "01/hitingut0" .. math.random(1, 2) .. ".wav"
		elseif hitGroup == HITGROUP_LEFTLEG or hitGroup == HITGROUP_RIGHTLEG then
			return "vo/npc/" .. gender .. "01/myleg0" .. math.random(1, 2) .. ".wav"
		elseif hitGroup == HITGROUP_LEFTARM or hitGroup == HITGROUP_RIGHTARM then
			return "vo/npc/" .. gender .. "01/myarm0" .. math.random(1, 2) .. ".wav"
		elseif hitGroup == HITGROUP_GEAR then
			return "vo/npc/" .. gender .. "01/startle0" .. math.random(1, 2) .. ".wav"
		end
	end

	return "vo/npc/" .. gender .. "01/pain0" .. math.random(1, 9) .. ".wav"
end

--[[
	@codebase Server
	@details Called when a player has spawned.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawn(player)
	if player:HasInitialized() then
		player:ShouldDropWeapon(false)

		if not player.cwLightSpawn then
			local factionTable = cwFaction:FindByID(player:GetFaction())
			local relation = factionTable.entRelationship
			local _, rank = player:GetFactionRank()
			local uniqueID = player:UniqueID()
			cwPly:SetWeaponRaised(player, false)
			cwPly:SetRagdollState(player, RAGDOLL_RESET)
			cwPly:SetAction(player, false)
			cwPly:SetDrunk(player, false)
			cwAttributes:ClearBoosts(player)
			cwLimb:ResetDamage(player)
			self:PlayerSetModel(player)
			self:PlayerLoadout(player)

			if player:FlashlightIsOn() then
				player:Flashlight(false)
			end

			player:SetForcedAnimation(false)
			player:SetCollisionGroup(COLLISION_GROUP_PLAYER)
			player:SetMaterial("")
			player:SetMoveType(MOVETYPE_WALK)
			player:Extinguish()
			player:UnSpectate()
			player:GodDisable()
			player:RunCommand("-duck")
			player:SetColor(Color(255, 255, 255, 255))
			player:SetupHands()
			player:SetCrouchedWalkSpeed(cwConfig:Get("crouched_speed"):Get())
			player:SetWalkSpeed(cwConfig:Get("walk_speed"):Get())
			player:SetJumpPower(cwConfig:Get("jump_power"):Get())
			player:SetRunSpeed(cwConfig:Get("run_speed"):Get())
			player:CrosshairDisable()
			player:SetMaxHealth(factionTable.maxHealth or 100)
			player:SetMaxArmor(factionTable.maxArmor or 0)
			player:SetHealth(factionTable.maxHealth or 100)
			player:SetArmor(factionTable.maxArmor or 0)

			if rank then
				player:SetMaxHealth(rank.maxHealth or player:GetMaxHealth())
				player:SetMaxArmor(rank.maxArmor or player:GetMaxArmor())
				player:SetHealth(rank.maxHealth or player:GetMaxHealth())
				player:SetArmor(rank.maxArmor or player:GetMaxArmor())
			end

			if istable(factionTable.respawnInv) then
				local inventory = player:GetInventory()
				local itemQuantity

				for k, v in pairs(factionTable.respawnInv) do
					for i = 1, v or 1 do
						itemQuantity = table.Count(inventory[k])

						if itemQuantity < v then
							player:GiveItem(cwItem:CreateInstance(k), true)
						end
					end
				end
			end

			if STORED_RELATIONS and STORED_RELATIONS[uniqueID] then
				for k, v in pairs(ents.GetAll()) do
					if v:IsNPC() then
						local storedRelation = STORED_RELATIONS[uniqueID][v:GetClass()]

						if storedRelation then
							v:AddEntityRelationship(player, storedRelation, 1)
						end
					end
				end
			end

			if istable(relation) then
				local relationEnts
				STORED_RELATIONS = STORED_RELATIONS or {}
				STORED_RELATIONS[uniqueID] = STORED_RELATIONS[uniqueID] or {}

				for k, v in pairs(relation) do
					relationEnts = ents.FindByClass(k)

					if relationEnts then
						for k2, v2 in pairs(relationEnts) do
							if string.lower(v) == "like" then
								STORED_RELATIONS[uniqueID][k] = v2:Disposition(player)
								v2:AddEntityRelationship(player, D_LI, 1)
							elseif string.lower(v) == "fear" then
								STORED_RELATIONS[uniqueID][k] = v2:Disposition(player)
								v2:AddEntityRelationship(player, D_FR, 1)
							elseif string.lower(v) == "hate" then
								STORED_RELATIONS[uniqueID][k] = v2:Disposition(player)
								v2:AddEntityRelationship(player, D_HT, 1)
							else
								ErrorNoHalt("Attempting to add relationship using invalid relation '" .. v .. "' towards faction '" .. factionTable.name .. "'.\r\n")
							end
						end
					end
				end
			end

			if player.cwFirstSpawn then
				local ammo = player:GetSavedAmmo()

				for k, v in pairs(ammo) do
					if not string.find(k, "p_") and not string.find(k, "s_") then
						player:GiveAmmo(v, k)
						ammo[k] = nil
					end
				end
			else
				player:UnLock()
			end
		end

		if player.cwLightSpawn and player.cwSpawnCallback then
			player.cwSpawnCallback(player, true)
			player.cwSpawnCallback = nil
		end

		cwPlugin:Call("PostPlayerSpawn", player, player.cwLightSpawn, player.cwChangeClass, player.cwFirstSpawn)
		cwPly:SetRecognises(player, player, RECOGNISE_TOTAL)
		local accessoryData = player:GetAccessoryData()
		local clothesItem = player:GetClothesItem()

		if clothesItem then
			player:SetClothesData(clothesItem)
		end

		for k, v in pairs(accessoryData) do
			local itemTable = player:FindItemByID(v, k)

			if itemTable then
				itemTable:OnWearAccessory(player, true)
			else
				accessoryData[k] = nil
			end
		end

		player.cwChangeClass = false
		player.cwLightSpawn = false
	else
		player:KillSilent()
	end
end

--[[
	@codebase Server
	@details Choose the model for hands according to their player model.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:PlayerSetHandsModel(player, entity)
	local model = player:GetModel()
	local simpleModel = player_manager.TranslateToPlayerModelName(model)
	local info = self.animation:GetHandsInfo(model) or player_manager.TranslatePlayerHands(simpleModel)

	if info then
		entity:SetModel(info.model)
		entity:SetSkin(info.skin)
		local bodyGroups = tostring(info.body)

		if bodyGroups then
			bodyGroups = string.Explode("", bodyGroups)

			for k, v in pairs(bodyGroups) do
				local num = tonumber(v)

				if num then
					entity:SetBodygroup(k, num)
				end
			end
		end
	end

	cwPlugin:Call("PostCModelHandsSet", player, model, entity, info)
end

--[[
	@codebase Server
	@details Called every frame.
	@returns {Unknown}
--]]
function Clockwork:Think()
	cwKernel:CallTimerThink(CurTime())
end

--[[
	@codebase Server
	@details Called when a player attempts to connect to the server.
	@param {Unknown} Missing description for steamID.
	@param {Unknown} Missing description for ipAddress.
	@param {Unknown} Missing description for svPassword.
	@param {Unknown} Missing description for clPassword.
	@param {Unknown} Missing description for name.
	@returns {Unknown}
--]]
function Clockwork:CheckPassword(steamID, ipAddress, svPassword, clPassword, name)
	steamID = util.SteamIDFrom64(steamID)
	local banTable = self.bans.stored[ipAddress] or self.bans.stored[steamID]

	if banTable then
		local unixTime = os.time()
		local unbanTime = tonumber(banTable.unbanTime)
		local timeLeft = unbanTime - unixTime
		local hoursLeft = math.Round(math.max(timeLeft / 3600, 0))
		local minutesLeft = math.Round(math.max(timeLeft / 60, 0))

		if unbanTime > 0 and unixTime < unbanTime then
			local bannedMessage = cwConfig:Get("banned_message"):Get()

			if hoursLeft >= 1 then
				hoursLeft = tostring(hoursLeft)
				bannedMessage = string.gsub(bannedMessage, "!t", hoursLeft)
				bannedMessage = string.gsub(bannedMessage, "!f", "hour(s)")
			elseif minutesLeft >= 1 then
				minutesLeft = tostring(minutesLeft)
				bannedMessage = string.gsub(bannedMessage, "!t", minutesLeft)
				bannedMessage = string.gsub(bannedMessage, "!f", "minutes(s)")
			else
				timeLeft = tostring(timeLeft)
				bannedMessage = string.gsub(bannedMessage, "!t", timeLeft)
				bannedMessage = string.gsub(bannedMessage, "!f", "second(s)")
			end

			return false, bannedMessage
		elseif unbanTime == 0 then
			return false, banTable.reason
		else
			self.bans:Remove(ipAddress)
			self.bans:Remove(steamID)
		end
	end
end

--[[
	@codebase Server
	@details Called when the Clockwork data is saved.
	@returns {Unknown}
--]]
function Clockwork:SaveData()
	cwPlugin:Call("PreSaveData")

	for _, v in pairs(player.GetAll()) do
		if v:HasInitialized() then
			v:SaveCharacter()
		end
	end

	if not cwConfig:Get("use_local_machine_time"):Get() then
		cwKernel:SaveSchemaData("time", self.time:GetSaveData())
	end

	if not cwConfig:Get("use_local_machine_date"):Get() then
		cwKernel:SaveSchemaData("date", self.date:GetSaveData())
	end

	cwPlugin:Call("PostSaveData")

	--MsgC(Color(0, 255, 0), "[Clockwork] Persistant data has been saved!\n")
end

function Clockwork:PlayerCanInteractCharacter(player, action, character)
	if self.quiz:GetEnabled() and not self.quiz:GetCompleted(player) then
		return false, {"YouHaveNotCompletedThe", self.quiz:GetName()}
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called whe the map entities are initialized.
	@returns {Unknown}
--]]
function Clockwork:InitPostEntity()
	for k, v in pairs(ents.GetAll()) do
		if IsValid(v) then
			if v:GetModel() then
				cwEntity:SetMapEntity(v, true)
				cwEntity:SetStartAngles(v, v:GetAngles())
				cwEntity:SetStartPosition(v, v:GetPos())

				if cwEntity:SetChairAnimations(v) then
					v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
					local physicsObject = v:GetPhysicsObject()

					if IsValid(physicsObject) then
						physicsObject:EnableMotion(false)
					end
				end
			end

			if cwEntity:IsDoor(v) then
				local entIndex = v:EntIndex()

				if not cwEntity.DoorEntities then
					cwEntity.DoorEntities = {}
				end

				local doorEnts = cwEntity.DoorEntities

				if not doorEnts[entIndex] then
					doorEnts[entIndex] = v
				end
			end
		end
	end

	if not Clockwork.NoMySQL then
		cwKernel:SetSharedVar("NoMySQL")
	else
		cwKernel:SetSharedVar("NoMySQL", Clockwork.NoMySQL)
	end

	cwPlugin:Call("ClockworkInitPostEntity")
end

--[[
	@codebase Server
	@details Called when a player initially spawns.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerInitialSpawn(player)
	player.cwCharacterList = player.cwCharacterList or {}
	player.cwHasSpawned = true
	player.cwSharedVars = player.cwSharedVars or {}

	if IsValid(player) then
		player:KillSilent()
	end

	if player:IsBot() then
		cwConfig:Send(player)
	end

	if not player:IsKicked() then
		cwKernel:PrintLog(LOGTYPE_MINOR, {"LogPlayerConnected", player:SteamName(), player:SteamID(), player:IPAddress()})

		cwChatbox:Add(nil, nil, "connect", {"PlayerConnected", player:SteamName()})
	end
end

--[[
	@codebase Server
	@details Called every frame while a player is dead.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerDeathThink(player)
	local action = cwPly:GetAction(player)
	if not player:HasInitialized() or player:GetCharacterData("CharBanned") then return true end
	if player:IsCharacterMenuReset() then return true end

	if action == "spawn" then
		return true
	else
		player:Spawn()
	end
end

--[[
	@codebase Server
	@details Called when a player's data has loaded.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerDataLoaded(player)
	if cwConfig:Get("clockwork_intro_enabled"):Get() then
			cwDatastream:Start(player, "ClockworkIntro", true)
		end
			cwDatastream:Start(player, "Donations", player.cwDonations)
	end

--[[
	@codebase Server
	@details Called when a player attempts to be given a weapon.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for class.
	@param {Unknown} Missing description for itemTable.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanBeGivenWeapon(player, class, itemTable)
	return true
end

--[[
	@codebase Server
	@details Called when a player has been given a weapon.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for class.
	@param {Unknown} Missing description for itemTable.
	@returns {Unknown}
--]]
function Clockwork:PlayerGivenWeapon(player, class, itemTable)
	self.inventory:Rebuild(player)

	if cwItem:IsWeapon(itemTable) and not itemTable:IsFakeWeapon() then
		if itemTable:IsMeleeWeapon() then
		cwPly:CreateGear(player, "Melee", itemTable)
		elseif itemTable:IsThrowableWeapon() then
		cwPly:CreateGear(player, "Throwable", itemTable)
		elseif itemTable:IsPrimaryWeapon() then
		cwPly:CreateGear(player, "Primary", itemTable)
		elseif itemTable:IsSecondaryWeapon() then
		cwPly:CreateGear(player, "Secondary", itemTable)
		end
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to create a character.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for character.
	@param {Unknown} Missing description for characterID.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanCreateCharacter(player, character, characterID)
	if self.quiz:GetEnabled() and not self.quiz:GetCompleted(player) then
		return "You have not completed the quiz!"
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player's bullet info should be adjusted.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustBulletInfo(player, bulletInfo)
end

--[[
	@codebase Server
	@details Called when an entity fires some bullets.
	@returns {Unknown}
--]]
function Clockwork:EntityFireBullets(entity, bulletInfo)
end

--[[
	@codebase Server
	@details Called when a player's fall damage is needed.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for velocity.
	@returns {Unknown}
--]]
function GM:GetFallDamage(player, velocity)
	local damage = math.max((velocity - 526.5) * (100 / 396), 0) * cwConfig:Get("scale_fall_damage"):Get()

	if cwConfig:Get("wood_breaks_fall"):Get() then
		local reduction = damage * 0.4
		local position = player:GetPos()

		local filter = {player}

		if (player:IsRagdolled()) then
			local ragdollEntity = player:GetRagdollEntity()

			position = ragdollEntity:GetPos()
			filter = {player, ragdollEntity}
		end

		local data = {}
		data.start = position
		data.endpos = data.start - Vector(0, 0, 64)
		data.filter = filter

		local trace = util.TraceLine(data)
		local entity = trace.Entity

		if IsValid(entity) and entity:GetClass() == "prop_physics" and trace.MatType == MAT_WOOD then
			local entHealth = entity:Health()
			local dmgInfo = DamageInfo()

			dmgInfo:SetDamage(reduction * 4)
			dmgInfo:SetDamageType(DMG_CRUSH)
			dmgInfo:SetAttacker(player)
			entity:DispatchTraceAttack(dmgInfo, data.start, data.endpos)

			if entHealth > entity:Health() then
				damage = damage - reduction
			end
		end
	end

	return damage
end

--[[
	@codebase Server
	@details Called when a player's data stream info has been sent.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerDataStreamInfoSent(player)
	if player:IsBot() then
		cwPly:LoadData(player, function(player)
			cwPlugin:Call("PlayerDataLoaded", player)
			local factions = table.ClearKeys(self.faction:GetAll(), true)
			local faction = factions[math.random(1, #factions)]

			if faction then
				local genders = {GENDER_MALE, GENDER_FEMALE}

				local gender = faction.singleGender and GENDER_NONE or genders[math.random(1, #genders)]
				local models = faction.singleGender and faction.models or faction.models[string.lower(gender)]
				local model = models[math.random(1, #models)]

				cwPly:LoadCharacter(player, 1, {
					faction = faction.name,
					gender = gender,
					model = model,
					name = player:Name(),
					data = {}
				}, function()
					cwPly:LoadCharacter(player, 1)
				end)
			end
		end)
	elseif table.Count(self.faction:GetAll()) > 0 then
		cwPly:LoadData(player, function()
			cwPlugin:Call("PlayerDataLoaded", player)
			local whitelisted = player:GetData("Whitelisted")
			local steamName = player:SteamName()
			local unixTime = os.time()
			cwPly:SetCharacterMenuState(player, CHARACTER_MENU_OPEN)

			if whitelisted then
				for k, v in pairs(whitelisted) do
					if self.faction.stored[v] then
						cwDatastream:Start(player, "SetWhitelisted", {v, true})
					else
						whitelisted[k] = nil
					end
				end
			end

			cwPly:GetCharacters(player, function(characters)
				if characters then
					for k, v in pairs(characters) do
						cwPly:ConvertCharacterMySQL(v)
						player.cwCharacterList[v.characterID] = {}

						for k2, v2 in pairs(v) do
							if k2 == "timeCreated" then
								if v2 == "" then
									player.cwCharacterList[v.characterID][k2] = unixTime
								else
									player.cwCharacterList[v.characterID][k2] = v2
								end
							elseif k2 == "lastPlayed" then
								player.cwCharacterList[v.characterID][k2] = unixTime
							elseif k2 == "steamName" then
								player.cwCharacterList[v.characterID][k2] = steamName
							else
								player.cwCharacterList[v.characterID][k2] = v2
							end
						end
					end

					for k, v in pairs(player.cwCharacterList) do
						cwPlugin:Call("PlayerAdjustCharacterTable", player, v)
						local shouldDelete = cwPlugin:Call("ShouldDeleteCharacter", player, v)

						if not shouldDelete then
							cwPly:CharacterScreenAdd(player, v)
						else
							cwPly:ForceDeleteCharacter(player, k)
						end
					end
				end

				cwPly:SetCharacterMenuState(player, CHARACTER_MENU_LOADED)
			end)
		end)
	end
end

--[[
	@codebase Server
	@details Called when a player's data stream info should be sent.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerSendDataStreamInfo(player)
	cwDatastream:Start(player, "SharedTables", self.SharedTables)

	if self.OverrideColorMod and self.OverrideColorMod ~= nil then
		cwDatastream:Start(player, "SystemColGet", self.OverrideColorMod)
	end
end

--[[
	@codebase Server
	@details Called when a player's death sound should be played.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for gender.
	@returns {Unknown}
--]]
function Clockwork:PlayerPlayDeathSound(player, gender)
	return "vo/npc/" .. string.lower(gender) .. "01/pain0" .. math.random(1, 9) .. ".wav"
end

--[[
	@codebase Server
	@details Called when a player's character data should be restored.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for data.
	@returns {Unknown}
--]]
function Clockwork:PlayerRestoreCharacterData(player, data)
	if data["PhysDesc"] then
		data["PhysDesc"] = cwKernel:ModifyPhysDesc(data["PhysDesc"])
	end

	if not data["LimbData"] then
		data["LimbData"] = {}
	end

	if not data["Clothes"] then
		data["Clothes"] = {}
	end

	if not data["Accessories"] then
		data["Accessories"] = {}
	end

	if not data["Traits"] then
		data["Traits"] = {}
	end

	cwPly:RestoreCharacterData(player, data)
end

--[[
	@codebase Server
	@details Called when a player's limb damage is bIsHealed.
	@returns {Unknown}
--]]
function Clockwork:PlayerLimbDamageHealed(player, hitGroup, amount)
end

--[[
	@codebase Server
	@details Called when a player's limb takes damage.
	@returns {Unknown}
--]]
function Clockwork:PlayerLimbTakeDamage(player, hitGroup, damage)
end

--[[
	@codebase Server
	@details Called when a player's limb damage is reset.
	@returns {Unknown}
--]]
function Clockwork:PlayerLimbDamageReset(player)
end

--[[
	@codebase Server
	@details Called when a player's character data should be saved.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for data.
	@returns {Unknown}
--]]
function Clockwork:PlayerSaveCharacterData(player, data)
	if cwConfig:Get("save_attribute_boosts"):Get() then
		cwKernel:SavePlayerAttributeBoosts(player, data)
	end

	data["Health"] = player:Health()
	data["Armor"] = player:Armor()

	if data["Health"] <= 1 then
		data["Health"] = nil
	end

	if data["Armor"] <= 1 then
		data["Armor"] = nil
	end
end

--[[
	@codebase Server
	@details Called when a player's data should be saved.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for data.
	@returns {Unknown}
--]]
function Clockwork:PlayerSaveData(player, data)
	cwPly:RestoreData(player, data)

	if data["Whitelisted"] and table.Count(data["Whitelisted"]) == 0 then
		data["Whitelisted"] = nil
	end
end

--[[
	@codebase Server
	@details Called when a player's storage should close.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for storageTable.
	@returns {Unknown}
--]]
function Clockwork:PlayerStorageShouldClose(player, storageTable)
	local entity = player:GetStorageEntity()

	if player:IsRagdolled() or not player:Alive() or storageTable.entity and not entity or storageTable.entity and storageTable.distance and player:GetShootPos():Distance(entity:GetPos()) > storageTable.distance then
		return true
	elseif storageTable.ShouldClose and storageTable.ShouldClose(player, storageTable) then
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to pickup a weapon.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for weapon.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanPickupWeapon(player, weapon)
	if player.cwForceGive or player:GetEyeTraceNoCursor().Entity == weapon and player:KeyDown(IN_USE) then
		return true
	else
		return false
	end
end

--[[
	@codebase Server
	@details Called to modify the generator interval.
	@returns {Unknown}
--]]
function Clockwork:ModifyGeneratorInterval(info)
end

--[[
	@codebase Server
	@details Called to modify the wages interval.
	@returns {Unknown}
--]]
function Clockwork:ModifyWagesInterval(info)
end

--[[
	@codebase Server
	@details Called to modify a player's wages info.
	@returns {Unknown}
--]]
function Clockwork:PlayerModifyWagesInfo(player, info)
end

--[[
	@codebase Server
	@details Called each tick.
	@returns {Unknown}
--]]
function Clockwork:Tick()
	local sysTime = SysTime()
	local curTime = CurTime()
	local plyTable = player.GetAll()

	if not self.NextHint or curTime >= self.NextHint then
		cwHint:Distribute()
		self.NextHint = curTime + cwConfig:Get("hint_interval"):Get()
	end

	if not self.NextWagesTime or curTime >= self.NextWagesTime then
		cwKernel:DistributeWagesCash()

		local info = {
			interval = cwConfig:Get("wages_interval"):Get();
		}

		cwPlugin:Call("ModifyWagesInterval", info)
		self.NextWagesTime = curTime + info.interval
	end

	if not self.NextGeneratorTime or curTime >= self.NextGeneratorTime then
		cwKernel:DistributeGeneratorCash()

		local info = {
			interval = cwConfig:Get("generator_interval"):Get();
		}

		cwPlugin:Call("ModifyGeneratorInterval", info)
		self.NextGeneratorTime = curTime + info.interval
	end

	if not self.NextDateTimeThink or sysTime >= self.NextDateTimeThink then
		cwKernel:PerformDateTimeThink()
		self.NextDateTimeThink = sysTime + cwConfig:Get("minute_time"):Get()
	end

	if not self.NextSaveData or sysTime >= self.NextSaveData then
		cwPlugin:Call("SaveData")
		self.NextSaveData = sysTime + cwConfig:Get("save_data_interval"):Get()
	end

	if not self.NextCheckEmpty then
		self.NextCheckEmpty = sysTime + 1200
	end

	if sysTime >= self.NextCheckEmpty then
		self.NextCheckEmpty = nil

		if #plyTable == 0 then
			RunConsoleCommand("changelevel", game.GetMap())
		end
	end

	for k, v in pairs(plyTable) do
		if v:HasInitialized() then
			if not v.cwNextThink then
				v.cwNextThink = curTime + 0.1
			end

			if not v.cwNextSetSharedVars then
				v.cwNextSetSharedVars = curTime + 1
			end

			if curTime >= v.cwNextThink then
				cwPly:CallThinkHook(v, curTime >= v.cwNextSetSharedVars, curTime)
			end
		end
	end

	if self.config:Get("enable_disease"):GetBoolean() then
		local nextDisease = self.nextDisease

		if not nextDisease or nextDisease < CurTime() then
			for k, v in pairs(plyTable) do
				if Clockwork.player:HasDiseases(v) then
					local symptoms = Clockwork.player:GetSymptoms(v)

					for k2, v2 in pairs(symptoms) do
						v2(v)
					end
				end
			end

			self.nextDisease = CurTime() + self.config:Get("disease_interval"):Get()
		end
	end
end

--[[
	@codebase Server
	@details Called when a player's health should regenerate.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerShouldHealthRegenerate(player)
	return true
end

--[[
	@codebase Server
	@details Called to get the entity that a player is holding.
	@returns {Unknown}
--]]
function Clockwork:PlayerGetHoldingEntity(player)
end

--[[
	@codebase Server
	@details A function to regenerate a player's health.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for health.
	@param {Unknown} Missing description for maxHealth.
	@returns {Unknown}
--]]
function Clockwork:PlayerHealthRegenerate(player, health, maxHealth)
	local curTime = CurTime()
	local maxHealth = player:GetMaxHealth()
	local health = player:Health()

	if player:Alive() and (not player.cwNextHealthRegen or curTime >= player.cwNextHealthRegen) then
		if health >= maxHealth / 2 and health < maxHealth then
			player:SetHealth(math.Clamp(health + 2, 0, maxHealth))
			player.cwNextHealthRegen = curTime + 5
		elseif health > 0 then
			player:SetHealth(math.Clamp(health + 2, 0, maxHealth))
			player.cwNextHealthRegen = curTime + 10
		end
	end
end

--[[
	@codebase Server
	@details Called when a player's shared variables should be set.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for curTime.
	@returns {Unknown}
--]]
function Clockwork:PlayerSetSharedVars(player, curTime)
--	local weaponClass = cwPly:GetWeaponClass(player)
	local color = player:GetColor()
	local isDrunk = cwPly:GetDrunk(player)
	player:HandleAttributeProgress(curTime)
	player:HandleAttributeBoosts(curTime)
	local clothesItem = player:IsWearingClothes()

	if clothesItem then
		player:NetworkClothesData()
	else
		player:RemoveClothes()
	end

	if cwConfig:Get("health_regeneration_enabled"):Get() and cwPlugin:Call("PlayerShouldHealthRegenerate", player) then
		cwPlugin:Call("PlayerHealthRegenerate", player, health, maxHealth)
	end

	if color.r == 255 and color.g == 0 and color.b == 0 and color.a == 0 then
		player:SetColor(Color(255, 255, 255, 255))
	end

	for k, v in pairs(player:GetWeapons()) do
		local ammoType = v:GetPrimaryAmmoType()

		if ammoType == "grenade" and player:GetAmmoCount(ammoType) == 0 then
			player:StripWeapon(v:GetClass())
		end
	end

	if player.cwDrunkTab then
		for k, v in pairs(player.cwDrunkTab) do
			if curTime >= v then
				table.remove(player.cwDrunkTab, k)
			end
		end
	end

	if isDrunk then
		player:SetSharedVar("IsDrunk", isDrunk)
	else
		player:SetSharedVar("IsDrunk", 0)
	end
end

--[[
	@codebase Server
	@details Called when a player picks an item up.
	@returns {Unknown}
--]]
function Clockwork:PlayerPickupItem(player, itemTable, itemEntity, quickUse)
end

--[[
	@codebase Server
	@details Called when a player uses an item.
	@returns {Unknown}
--]]
function Clockwork:PlayerUseItem(player, itemTable, itemEntity)
end

--[[
	@codebase Server
	@details Called when a player drops an item.
	@returns {Unknown}
--]]
function Clockwork:PlayerDropItem(player, itemTable, position, entity)
end

--[[
	@codebase Server
	@details Called when a player destroys an item.
	@returns {Unknown}
--]]
function Clockwork:PlayerDestroyItem(player, itemTable)
end

--[[
	@codebase Server
	@details Called when a player drops a weapon.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for itemTable.
	@param {Unknown} Missing description for entity.
	@param {Unknown} Missing description for weapon.
	@returns {Unknown}
--]]
function Clockwork:PlayerDropWeapon(player, itemTable, entity, weapon)
	if itemTable:IsInstance() and IsValid(weapon) then
		local clipOne = weapon:Clip1()
		local clipTwo = weapon:Clip2()

		if clipOne > 0 then
			itemTable:SetData("ClipOne", clipOne)
		end

		if clipTwo > 0 then
			itemTable:SetData("ClipTwo", clipTwo)
		end
	end
end

--[[
	@codebase Server
	@details Called when a player charges generator.
	@returns {Unknown}
--]]
function Clockwork:PlayerChargeGenerator(player, entity, generator)
end

--[[
	@codebase Server
	@details Called when a player destroys generator.
	@returns {Unknown}
--]]
function Clockwork:PlayerDestroyGenerator(player, entity, generator)
end

--[[
	@codebase Server
	@details Called when a player's data should be restored.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for data.
	@returns {Unknown}
--]]
function Clockwork:PlayerRestoreData(player, data)
	if not data["Whitelisted"] then
		data["Whitelisted"] = {}
	end

	--[[ Backwards Compatability... --]]
	if data["serverwhitelist"] then
		data["ServerWhitelist"] = data["serverwhitelist"]
		data["serverwhitelist"] = nil
	end

	cwPly:RestoreData(player, data)
end

--[[
	@codebase Server
	@details Called to get whether a player can pickup an entity.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:AllowPlayerPickup(player, entity)
	return false
end

--[[
	@codebase Server
	@details Called when a player's temporary info should be saved.
	@returns {Unknown}
--]]
function Clockwork:PlayerSaveTempData(player, tempData)
end

--[[
	@codebase Server
	@details Called when a player's temporary info should be restored.
	@returns {Unknown}
--]]
function Clockwork:PlayerRestoreTempData(player, tempData)
end

--[[
	@codebase Server
	@details Called when a player selects a custom character option.
	@returns {Unknown}
--]]
function Clockwork:PlayerSelectCharacterOption(player, character, option)
end

--[[
	@codebase Server
	@details Called when a player attempts to see another player's status.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for target.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanSeeStatus(player, target)
	return "# " .. target:UserID() .. " | " .. target:Name() .. " | " .. target:SteamName() .. " | " .. target:SteamID() .. " | " .. target:IPAddress()
end

--[[
	@codebase Server
	@details Called when a player attempts to see a player's chat.
	@param {Unknown} Missing description for text.
	@param {Unknown} Missing description for teamOnly.
	@param {Unknown} Missing description for listener.
	@param {Unknown} Missing description for speaker.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanSeePlayersChat(text, teamOnly, listener, speaker)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to hear another player's voice.
	@param {Unknown} Missing description for listener.
	@param {Unknown} Missing description for speaker.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanHearPlayersVoice(listener, speaker)
	if not cwConfig:Get("voice_enabled"):Get() then
		return false
	elseif speaker:GetData("VoiceBan") then
		return false
	end

	if speaker:GetActiveChannel() and listener:GetActiveChannel() then
		local speakerChannel = speaker:GetActiveChannel()
		if self.voice:IsInChannel(listener, speakerChannel) then return true end
	end

	if cwConfig:Get("local_voice"):Get() then
		if listener:IsRagdolled(RAGDOLL_KNOCKEDOUT) or not listener:Alive() then
			return false
		elseif speaker:IsRagdolled(RAGDOLL_KNOCKEDOUT) or not speaker:Alive() then
			return false
		elseif listener:GetPos():Distance(speaker:GetPos()) > cwConfig:Get("talk_radius"):Get() then
			return false
		end
	end

	return true, true
end

--[[
	@codebase Server
	@details Called when a player attempts to delete a character.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for character.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanDeleteCharacter(player, character)
	if cwConfig:Get("cash_enabled"):Get() and character.cash < cwConfig:Get("default_cash"):Get() then
		if not character.data["CharBanned"] then return L(player, "CannotDeleteCharacterDefaultCash", cwKernel:FormatCash(cwConfig:Get("default_cash"):Get(), nil, true)) end
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to switch to a character.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for character.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanSwitchCharacter(player, character)
	if not player:Alive() and not player:IsCharacterMenuReset() and not player:GetSharedVar("CharBanned") then
		return "You cannot switch characters when you are dead!"
	elseif player:GetRagdollState() == RAGDOLL_KNOCKEDOUT then
		return "You cannot switch characters when you are knocked out!"
	end

	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to use a character.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for character.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanUseCharacter(player, character)
	if character.data["CharBanned"] then return character.name .. " is banned and cannot be used!" end
	local faction = cwFaction:FindByID(character.faction)
	local playerRank, rank = player:GetFactionRank(character)
	local factionCount = 0
	local rankCount = 0

	for k, v in ipairs(_player.GetAll()) do
		if v:HasInitialized() then
			if v:GetFaction() == character.faction then
				if player ~= v then
					if rank and v:GetFactionRank() == playerRank then
						rankCount = rankCount + 1
					end

					factionCount = factionCount + 1
				end
			end
		end
	end

	if faction.playerLimit and factionCount >= faction.playerLimit then return "There are too many characters of this faction online!" end
	if rank and rank.playerLimit and rankCount >= rank.playerLimit then return "There are too many characters of this rank online!" end
end

--[[
	@codebase Server
	@details Called when a player's weapons should be given.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerGiveWeapons(player)
	local _, rank = player:GetFactionRank()
	local faction = cwFaction:FindByID(player:GetFaction())

	if rank and rank.weapons then
		for k, v in pairs(rank.weapons) do
			cwPly:GiveSpawnWeapon(player, v)
		end
	end

	if faction and faction.weapons then
		for k, v in pairs(faction.weapons) do
			cwPly:GiveSpawnWeapon(player, v)
		end
	end
end

--[[
	@codebase Server
	@details Called when a player deletes a character.
	@returns {Unknown}
--]]
function Clockwork:PlayerDeleteCharacter(player, character)
end

--[[
	@codebase Server
	@details Called when a player's armor is set.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for newArmor.
	@param {Unknown} Missing description for oldArmor.
	@returns {Unknown}
--]]
function Clockwork:PlayerArmorSet(player, newArmor, oldArmor)
	if player:IsRagdolled() then
		player:GetRagdollTable().armor = newArmor
	end
end

--[[
	@codebase Server
	@details Called when a player's health is set.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for newHealth.
	@param {Unknown} Missing description for oldHealth.
	@returns {Unknown}
--]]
function Clockwork:PlayerHealthSet(player, newHealth, oldHealth)
	local bIsRagdolled = player:IsRagdolled()
	local maxHealth = player:GetMaxHealth()

	if newHealth > oldHealth then
		cwLimb:HealBody(player, (newHealth - oldHealth) / 2)
	end

	if newHealth >= maxHealth then
		cwLimb:HealBody(player, 100)
		player:RemoveAllDecals()

		if bIsRagdolled then
			player:GetRagdollEntity():RemoveAllDecals()
		end
	end

	if bIsRagdolled then
		player:GetRagdollTable().health = newHealth
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to own a door.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for door.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanOwnDoor(player, door)
	if cwEntity:IsDoorUnownable(door) then
		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to view a door.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for door.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanViewDoor(player, door)
	if cwEntity:IsDoorUnownable(door) then return false end

	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to holster a weapon.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for itemTable.
	@param {Unknown} Missing description for weapon.
	@param {Unknown} Missing description for shouldForce.
	@param {Unknown} Missing description for bNoMsg.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanHolsterWeapon(player, itemTable, weapon, shouldForce, bNoMsg)
	if cwPly:GetSpawnWeapon(player, itemTable("weaponClass")) then
		if not bNoMsg then
			cwPly:Notify(player, {"CannotHolsterWeapon"})
		end

		return false
	elseif itemTable.CanHolsterWeapon then
		return itemTable:CanHolsterWeapon(player, weapon, shouldForce, bNoMsg)
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to drop a weapon.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for itemTable.
	@param {Unknown} Missing description for weapon.
	@param {Unknown} Missing description for bNoMsg.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanDropWeapon(player, itemTable, weapon, bNoMsg)
	if cwPly:GetSpawnWeapon(player, itemTable("weaponClass")) then
		if not bNoMsg then
			cwPly:Notify(player, {"CannotDropWeapon"})
		end

		return false
	elseif itemTable.CanDropWeapon then
		return itemTable:CanDropWeapon(player, bNoMsg)
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to use an item.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for itemTable.
	@param {Unknown} Missing description for bNoMsg.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanUseItem(player, itemTable, bNoMsg)
	if cwItem:IsWeapon(itemTable) and cwPly:GetSpawnWeapon(player, itemTable("weaponClass")) then
		if not bNoMsg then
			cwPly:Notify(player, {"CannotUseWeapon"})
		end

		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to drop an item.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanDropItem(player, itemTable, bNoMsg)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to destroy an item.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanDestroyItem(player, itemTable, bNoMsg)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to destroy generator.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanDestroyGenerator(player, entity, generator)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to knockout a player.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanKnockout(player, target)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to use the radio.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanRadio(player, text, listeners, eavesdroppers)
	return true
end

--[[
	@codebase Server
	@details Called when death attempts to clear a player's name.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanDeathClearName(player, attacker, damageInfo)
	return false
end

--[[
	@codebase Server
	@details Called when death attempts to clear a player's recognised names.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanDeathClearRecognisedNames(player, attacker, damageInfo)
	return false
end

--[[
	@codebase Server
	@details Called when death attempts to strip a player's ammo.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanDeathStripAmmo(player, attacker, damageInfo)
	return true
end

--[[
	@codebase Server
	@details Called when a player's ragdoll attempts to take damage.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for ragdoll.
	@param {Unknown} Missing description for inflictor.
	@param {Unknown} Missing description for attacker.
	@param {Unknown} Missing description for hitGroup.
	@param {Unknown} Missing description for damageInfo.
	@returns {Unknown}
--]]
function Clockwork:PlayerRagdollCanTakeDamage(player, ragdoll, inflictor, attacker, hitGroup, damageInfo)
	if not attacker:IsPlayer() and player:GetRagdollTable().immunity then
		if CurTime() <= player:GetRagdollTable().immunity then return false end
	end

	return true
end

--[[
	@codebase Server
	@details Called when the player attempts to be ragdolled.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for state.
	@param {Unknown} Missing description for delay.
	@param {Unknown} Missing description for decay.
	@param {Unknown} Missing description for ragdoll.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanRagdoll(player, state, delay, decay, ragdoll)
	return true
end

--[[
	@codebase Server
	@details Called when the player attempts to be unragdolled.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for state.
	@param {Unknown} Missing description for ragdoll.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanUnragdoll(player, state, ragdoll)
	return true
end

--[[
	@codebase Server
	@details Called when a player has been ragdolled.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for state.
	@param {Unknown} Missing description for ragdoll.
	@returns {Unknown}
--]]
function Clockwork:PlayerRagdolled(player, state, ragdoll)
	player:SetSharedVar("FallenOver", false)
end

--[[
	@codebase Server
	@details Called when a player has been unragdolled.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for state.
	@param {Unknown} Missing description for ragdoll.
	@returns {Unknown}
--]]
function Clockwork:PlayerUnragdolled(player, state, ragdoll)
	player:SetSharedVar("FallenOver", false)
end

--[[
	@codebase Server
	@details Called to check if a player does have a flag.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for flag.
	@returns {Unknown}
--]]
function Clockwork:PlayerDoesHaveFlag(player, flag)
	if string.find(cwConfig:Get("default_flags"):Get(), flag) then return true end
end

--[[
	@codebase Server
	@details Called when a player's model should be set.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerSetModel(player)
	cwPly:SetDefaultModel(player)
	cwPly:SetDefaultSkin(player)
end

--[[
	@codebase Server
	@details Called to check if a player does have door access.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for door.
	@param {Unknown} Missing description for access.
	@param {Unknown} Missing description for isAccurate.
	@returns {Unknown}
--]]
function Clockwork:PlayerDoesHaveDoorAccess(player, door, access, isAccurate)
	if cwEntity:GetOwner(door) ~= player then
		local key = player:GetCharacterKey()

		if door.accessList and door.accessList[key] then
			if isAccurate then
				return door.accessList[key] == access
			else
				return door.accessList[key] >= access
			end
		end

		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called to check if a player does know another player.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for target.
	@param {Unknown} Missing description for status.
	@param {Unknown} Missing description for isAccurate.
	@param {Unknown} Missing description for realValue.
	@returns {Unknown}
--]]
function Clockwork:PlayerDoesRecognisePlayer(player, target, status, isAccurate, realValue)
	return realValue
end

--[[
	@codebase Server
	@details Called when a player attempts to lock an entity.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanLockEntity(player, entity)
	if cwEntity:IsDoor(entity) then
		return cwPly:HasDoorAccess(player, entity)
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player's class has been set.
	@returns {Unknown}
--]]
function Clockwork:PlayerClassSet(player, newClass, oldClass, noRespawn, addDelay, noModelChange)
end

--[[
	@codebase Server
	@details Called when a player attempts to unlock an entity.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanUnlockEntity(player, entity)
	if cwEntity:IsDoor(entity) then
		return cwPly:HasDoorAccess(player, entity)
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to use a door.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for door.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanUseDoor(player, door)
	if cwEntity:GetOwner(door) and not cwPly:HasDoorAccess(player, door) then return false end
	if cwEntity:IsDoorFalse(door) then return false end

	return true
end

--[[
	@codebase Server
	@details Called when a player uses a door.
	@returns {Unknown}
--]]
function Clockwork:PlayerUseDoor(player, door)
end

--[[
	@codebase Server
	@details Called when a player attempts to use an entity in a vehicle.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@param {Unknown} Missing description for vehicle.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanUseEntityInVehicle(player, entity, vehicle)
	if entity.UsableInVehicle or cwEntity:IsDoor(entity) then return true end
end

--[[
	@codebase Server
	@details Called when a player's ragdoll attempts to decay.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for ragdoll.
	@param {Unknown} Missing description for seconds.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanRagdollDecay(player, ragdoll, seconds)
	return false
end

--[[
	@codebase Server
	@details Called when a player attempts to exit a vehicle.
	@param {Unknown} Missing description for vehicle.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:CanExitVehicle(vehicle, player)
	local curTime = CurTime()
	if player.cwNextExitVehicle and player.cwNextExitVehicle > curTime then return false end

	if IsValid(player) and player:IsPlayer() then
		local trace = player:GetEyeTraceNoCursor()

		if IsValid(trace.Entity) and not trace.Entity:IsVehicle() then
			if cwPlugin:Call("PlayerCanUseEntityInVehicle", player, trace.Entity, vehicle) then return false end
		end
	end

	if cwEntity:IsChairEntity(vehicle) and not IsValid(vehicle:GetParent()) then
		local trace = player:GetEyeTraceNoCursor()

		if trace.HitPos:Distance(player:GetShootPos()) <= 192 then
			trace = {
				start = trace.HitPos,
				endpos = trace.HitPos - Vector(0, 0, 1024),
				filter = {player, vehicle}
			}

			player.cwExitVehiclePos = util.TraceLine(trace).HitPos
			player:SetMoveType(MOVETYPE_NOCLIP)
		else
			return false
		end
	end

	return true
end

--[[
	@codebase Server
	@details Called when a player leaves a vehicle.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for vehicle.
	@returns {Unknown}
--]]
function Clockwork:PlayerLeaveVehicle(player, vehicle)
	timer.Simple(FrameTime() * 0.5, function()
		if IsValid(player) and not player:InVehicle() then
			if IsValid(vehicle) then
				if cwEntity:IsChairEntity(vehicle) then
					local position = player.cwExitVehiclePos or vehicle:GetPos()
					local targetPosition = cwPly:GetSafePosition(player, position, vehicle)

					if targetPosition then
						player:SetMoveType(MOVETYPE_NOCLIP)
						player:SetPos(targetPosition)
					end

					player:SetMoveType(MOVETYPE_WALK)
					player.cwExitVehiclePos = nil
				end
			end
		end
	end)
end

--[[
	@codebase Server
	@details Called when a player attempts to enter a vehicle.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for vehicle.
	@param {Unknown} Missing description for role.
	@returns {Unknown}
--]]
function Clockwork:CanPlayerEnterVehicle(player, vehicle, role)
	return true
end

--[[
	@codebase Server
	@details Called when a player enters a vehicle.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for vehicle.
	@param {Unknown} Missing description for class.
	@returns {Unknown}
--]]
function Clockwork:PlayerEnteredVehicle(player, vehicle, class)
	timer.Simple(FrameTime() * 0.5, function()
		if IsValid(player) then
			local model = player:GetModel()
			local class = self.animation:GetModelClass(model)

			if IsValid(vehicle) and not string.find(model, "/player/") then
				if class == "maleHuman" or class == "femaleHuman" then
					if cwEntity:IsChairEntity(vehicle) then
						player:SetLocalPos(Vector(16.5438, -0.1642, -20.5493))
					else
						player:SetLocalPos(Vector(30.1880, 4.2020, -6.6476))
					end
				end
			end

			player:SetCollisionGroup(COLLISION_GROUP_PLAYER)
		end
	end)
end

--[[
	@codebase Server
	@details Called when a player attempts to change class.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for class.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanChangeClass(player, class)
	local curTime = CurTime()

	if player.cwNextChangeClass and curTime < player.cwNextChangeClass then
		cwPly:Notify(player, {"CannotChangeClassFor", math.ceil(player.cwNextChangeClass - curTime)})

		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to earn generator cash.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for info.
	@param {Unknown} Missing description for cash.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanEarnGeneratorCash(player, info, cash)
	return true
end

--[[
	@codebase Server
	@details Called when a player earns generator cash.
	@returns {Unknown}
--]]
function Clockwork:PlayerEarnGeneratorCash(player, info, cash)
end

--[[
	@codebase Server
	@details Called when a player attempts to earn wages cash.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for cash.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanEarnWagesCash(player, cash)
	if (cwConfig:Get("wages_interval"):Get() == 0) then
		return false
	end

	return true
end

--[[
	@codebase Server
	@details Called when a player is given wages cash.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for cash.
	@param {Unknown} Missing description for wagesName.
	@returns {Unknown}
--]]
function Clockwork:PlayerGiveWagesCash(player, cash, wagesName)
	return true
end

--[[
	@codebase Server
	@details Called when a player earns wages cash.
	@returns {Unknown}
--]]
function Clockwork:PlayerEarnWagesCash(player, cash)
end

--[[
	@codebase Server
	@details Called when Clockwork has loaded all of the entities.
	@returns {Unknown}
--]]
function Clockwork:ClockworkInitPostEntity()
end

--[[
	@codebase Server
	@details Called when a player attempts to say something in-character.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for text.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanSayIC(player, text)
	if (not player:Alive() or player:IsRagdolled(RAGDOLL_FALLENOVER)) and not cwPly:GetDeathCode(player, true) then
		cwPly:Notify(player, {"CannotActionRightNow"})

		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to say something out-of-character.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanSayOOC(player, text)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to say something locally out-of-character.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanSayLOOC(player, text)
	return true
end

--[[
	@codebase Server
	@details Called when attempts to use a command.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for commandTable.
	@param {Unknown} Missing description for arguments.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanUseCommand(player, commandTable, arguments)
	return true
end

--[[
	@codebase Server
	@details Called when a player speaks from the client.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for text.
	@param {Unknown} Missing description for bPublic.
	@returns {Unknown}
--]]
function Clockwork:PlayerSay(player, text, bPublic)
	local prefix = cwConfig:Get("command_prefix"):Get()
	local prefixLength = string.len(prefix)

	if string.sub(text, 1, prefixLength) == prefix then
		local arguments = cwKernel:ExplodeByTags(text, " ", "\"", "\"", true)
		local command = string.sub(arguments[1], prefixLength + 1)
		local realCommand = cwCommand:GetAlias()[command] or command

		return string.Replace(text, prefix .. command, prefix .. realCommand)
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to suicide.
	@returns {Unknown}
--]]
function Clockwork:CanPlayerSuicide(player)
	return false
end

--[[
	@codebase Server
	@details Called when a player attempts to punt an entity with the gravity gun.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:GravGunPunt(player, entity)
	return cwConfig:Get("enable_gravgun_punt"):Get()
end

--[[
	@codebase Server
	@details Called when a player attempts to pickup an entity with the gravity gun.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:GravGunPickupAllowed(player, entity)
	if IsValid(entity) then
		if not cwPly:IsAdmin(player) and not cwEntity:IsInteractable(entity) then
			return false
		else
			return self.BaseClass:GravGunPickupAllowed(player, entity)
		end
	end

	return false
end

--[[
	@codebase Server
	@details Called when a player picks up an entity with the gravity gun.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:GravGunOnPickedUp(player, entity)
	player.cwIsHoldingEnt = entity
	entity.cwIsBeingHeld = player
end

--[[
	@codebase Server
	@details Called when a player drops an entity with the gravity gun.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:GravGunOnDropped(player, entity)
	player.cwIsHoldingEnt = nil
	entity.cwIsBeingHeld = nil
end

--[[
	@codebase Server
	@details Called when a player attempts to unfreeze an entity.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@param {Unknown} Missing description for physicsObject.
	@returns {Unknown}
--]]
function Clockwork:CanPlayerUnfreeze(player, entity, physicsObject)
	local isAdmin = cwPly:IsAdmin(player)

	if cwConfig:Get("enable_prop_protection"):Get() and not isAdmin then
		local ownerKey = entity:GetOwnerKey()
		if ownerKey and player:GetCharacterKey() ~= ownerKey then return false end
	end

	if not isAdmin and not cwEntity:IsInteractable(entity) then return false end

	if entity:IsVehicle() then
		if IsValid(entity:GetDriver()) then return false end
	end

	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to freeze an entity with the physics gun.
	@param {Unknown} Missing description for weapon.
	@param {Unknown} Missing description for physicsObject.
	@param {Unknown} Missing description for entity.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:OnPhysgunFreeze(weapon, physicsObject, entity, player)
	local isAdmin = cwPly:IsAdmin(player)

	if cwConfig:Get("enable_prop_protection"):Get() and not isAdmin then
		local ownerKey = entity:GetOwnerKey()
		if ownerKey and player:GetCharacterKey() ~= ownerKey then return false end
	end

	if not isAdmin and cwEntity:IsChairEntity(entity) then
		local entities = ents.FindInSphere(entity:GetPos(), 64)

		for k, v in pairs(entities) do
			if cwEntity:IsDoor(v) then return false end
		end
	end

	if entity:GetPhysicsObject():IsPenetrating() then return false end
	if not isAdmin and entity.PhysgunDisabled then return false end

	if not isAdmin and not cwEntity:IsInteractable(entity) then
		return false
	else
		return self.BaseClass:OnPhysgunFreeze(weapon, physicsObject, entity, player)
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to pickup an entity with the physics gun.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:PhysgunPickup(player, entity)
	local canPickup = nil
	local isAdmin = cwPly:IsAdmin(player)

	if not cwConfig:Get("enable_map_props_physgrab"):Get() then
		if cwEntity:IsMapEntity(entity) then
			canPickup = false
		end
	end

	if not isAdmin and not cwEntity:IsInteractable(entity) then return false end
	if not isAdmin and cwEntity:IsPlayerRagdoll(entity) then return false end

	if not isAdmin and entity:GetClass() == "prop_ragdoll" then
		local ownerKey = entity:GetOwnerKey()
		if ownerKey and player:GetCharacterKey() ~= ownerKey then return false end
	end

	if not isAdmin then
		canPickup = self.BaseClass:PhysgunPickup(player, entity)
	else
		canPickup = true
	end

	if cwEntity:IsChairEntity(entity) and not isAdmin then
		local entities = ents.FindInSphere(entity:GetPos(), 256)

		for k, v in pairs(entities) do
			if cwEntity:IsDoor(v) then return false end
		end
	end

	if cwConfig:Get("enable_prop_protection"):Get() and not isAdmin then
		local ownerKey = entity:GetOwnerKey()

		if ownerKey and player:GetCharacterKey() ~= ownerKey then
			canPickup = false
		end
	end

	if entity:IsPlayer() and entity:InVehicle() or entity.cwObserverMode then
		canPickup = false
	end

	if canPickup then
		player.cwIsHoldingEnt = entity
		entity.cwIsBeingHeld = player

		if not entity:IsPlayer() then
			if cwConfig:Get("prop_kill_protection"):Get() and not entity.cwLastCollideGroup then
				cwEntity:StopCollisionGroupRestore(entity)
				entity.cwLastCollideGroup = entity:GetCollisionGroup()
				entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			end

			entity.cwDamageImmunity = CurTime() + 60
		elseif not entity.cwMoveType then
			entity.cwMoveType = entity:GetMoveType()
			entity:SetMoveType(MOVETYPE_NOCLIP)
		end

		return true
	else
		return false
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to drop an entity with the physics gun.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:PhysgunDrop(player, entity)
	if not entity:IsPlayer() and entity.cwLastCollideGroup then
		cwEntity:ReturnCollisionGroup(entity, entity.cwLastCollideGroup)
		entity.cwLastCollideGroup = nil
	elseif entity.cwMoveType then
		entity:SetMoveType(MOVETYPE_WALK)
		entity.cwMoveType = nil
	end

	entity.cwDamageImmunity = CurTime() + 60
	player.cwIsHoldingEnt = nil
	entity.cwIsBeingHeld = nil
end

--[[
	@codebase Server
	@details Called when a player attempts to spawn an NPC.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for model.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawnNPC(player, model)
	if not cwPly:HasFlags(player, "n") then return false end

	if not player:Alive() or player:IsRagdolled() then
		cwPly:Notify(player, {"CannotActionRightNow"})

		return false
	end

	if not cwPly:IsAdmin(player) then
		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when an NPC has been killed.
	@returns {Unknown}
--]]
function Clockwork:OnNPCKilled(entity, attacker, inflictor)
end

--[[
	@codebase Server
	@details Called to get whether an entity is being held.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:GetEntityBeingHeld(entity)
	return entity.cwIsBeingHeld or entity:IsPlayerHolding()
end

--[[
	@codebase Server
	@details Called when an entity is removed.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:EntityRemoved(entity)
	if not cwKernel:IsShuttingDown() then
		if IsValid(entity) then
			if entity:GetClass() == "prop_ragdoll" then
				if entity.cwIsBelongings and entity.cwInventory and entity.cwCash and (table.Count(entity.cwInventory) > 0 or entity.cwCash > 0) then
					local belongings = ents.Create("cw_belongings")
					belongings:SetAngles(Angle(0, 0, -90))
					belongings:SetData(entity.cwInventory, entity.cwCash)
					belongings:SetPos(entity:GetPos() + Vector(0, 0, 32))
					belongings:Spawn()
					entity.cwInventory = nil
					entity.cwCash = nil
				end
			end

			local allProperty = cwPly:GetAllProperty()
			local entIndex = entity:EntIndex()

			if entity.cwGiveRefundTab and CurTime() <= entity.cwGiveRefundTab[1] then
				if IsValid(entity.cwGiveRefundTab[2]) then
					cwPly:GiveCash(entity.cwGiveRefundTab[2], entity.cwGiveRefundTab[3], {"CashPropRefund"})
				end
			end

			allProperty[entIndex] = nil

			if entity:GetClass() == "cw_item" then
				cwItem:RemoveItemEntity(entity)
			end
		end

		cwEntity:ClearProperty(entity)
	end
end

--[[
	@codebase Server
	@details Called when an entity's menu option should be handled.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@param {Unknown} Missing description for option.
	@param {Unknown} Missing description for arguments.
	@returns {Unknown}
--]]
function Clockwork:EntityHandleMenuOption(player, entity, option, arguments)
	local class = entity:GetClass()
	local generator = self.generator:FindByID(class)

	if class == "cw_item" and (arguments == "cwItemTake" or arguments == "cwItemUse") then
		if cwEntity:BelongsToAnotherCharacter(player, entity) then
			cwPly:Notify(player, {"DroppedItemsOtherChar"})

			return
		end

		local itemTable = entity.cwItemTable
		local quickUse = arguments == "cwItemUse"

		if itemTable then
			local didPickupItem = true
			local canPickup = not itemTable.CanPickup or itemTable:CanPickup(player, quickUse, entity)

			if canPickup ~= false then
				player:SetItemEntity(entity)

				if quickUse then
					itemTable = player:GiveItem(itemTable, true)
					Clockwork.item:AddItemEntity(entity, itemTable)

					if not cwPly:InventoryAction(player, itemTable, "use") then
						player:TakeItem(itemTable, true)
						Clockwork.item:AddItemEntity(entity, entity.cwItemTable)
						didPickupItem = false
					else
						player:FakePickup(entity)
					end
				else
					local wasSuccess, fault = player:GiveItem(itemTable)

					if not wasSuccess then
						cwPly:Notify(player, fault)
						didPickupItem = false
					else
						player:FakePickup(entity)
					end
				end

				cwPlugin:Call("PlayerPickupItem", player, itemTable, entity, quickUse)

				if didPickupItem then
					if not itemTable.OnPickup or itemTable:OnPickup(player, quickUse, entity) ~= false then
						entity:Remove()
					end
				end

				local pickupSound = itemTable.pickupSound or "physics/body/body_medium_impact_soft" .. math.random(1, 7) .. ".wav"
				local quickUse = arguments == "cwItemUse"
				
				if quickUse then
				return false end
				if type(pickupSound) == "table" then
					pickupSound = pickupSound[math.random(1, #pickupSound)]
				end

				player:EmitSound(pickupSound)
				player:SetItemEntity(nil)
			end
		end
	elseif class == "cw_item" and arguments == "cwItemExamine" then
		local itemTable = entity.cwItemTable
		local examineText = itemTable("description")

		if itemTable.GetEntityExamineText then
			examineText = itemTable:GetEntityExamineText(entity)
		end

		cwPly:Notify(player, examineText)
	elseif class == "cw_item" and arguments == "cwItemAmmo" then
		local itemTable = entity.cwItemTable

		if cwItem:IsWeapon(itemTable) then
			if itemTable:HasSecondaryClip() or itemTable:HasPrimaryClip() then
				local clipOne = itemTable:GetData("ClipOne")
				local clipTwo = itemTable:GetData("ClipTwo")

				if clipTwo > 0 then
					player:GiveAmmo(clipTwo, itemTable("secondaryAmmoClass"))
				end

				if clipOne > 0 then
					player:GiveAmmo(clipOne, itemTable("primaryAmmoClass"))
				end

				itemTable:SetData("ClipOne", 0)
				itemTable:SetData("ClipTwo", 0)
				player:FakePickup(entity)
			end
		end
	elseif class == "cw_item" then
		local itemTable = entity.cwItemTable

		if itemTable and itemTable.EntityHandleMenuOption then
			itemTable:EntityHandleMenuOption(player, entity, option, arguments)
		end
	elseif entity:GetClass() == "cw_belongings" and arguments == "cwBelongingsOpen" then
		player:EmitSound("physics/body/body_medium_impact_soft" .. math.random(1, 7) .. ".wav")

		cwStorage:Open(player, {
			name = "Belongings",
			cash = entity.cwCash,
			weight = 100,
			space = 200,
			entity = entity,
			distance = 192,
			inventory = entity.cwInventory,
			isOneSided = true,
			OnGiveCash = function(player, storageTable, cash)
				entity.cwCash = storageTable.cash
			end,
			OnTakeCash = function(player, storageTable, cash)
				entity.cwCash = storageTable.cash
			end,
			OnClose = function(player, storageTable, entity)
				if IsValid(entity) then
					if not entity.cwInventory and not entity.cwCash or table.Count(entity.cwInventory) == 0 and entity.cwCash == 0 then
						entity:Explode(entity:BoundingRadius() * 2)
						entity:Remove()
					end
				end
			end,
			CanGiveItem = function(player, storageTable, itemTable) return false end
		})
	elseif class == "cw_shipment" and arguments == "cwShipmentOpen" then
		player:EmitSound("physics/body/body_medium_impact_soft" .. math.random(1, 7) .. ".wav")
		player:FakePickup(entity)

		cwStorage:Open(player, {
			name = "Shipment",
			weight = entity.cwWeight,
			space = entity.cwSpace,
			entity = entity,
			distance = 192,
			inventory = entity.cwInventory,
			isOneSided = true,
			OnClose = function(player, storageTable, entity)
				if IsValid(entity) and cwInventory:IsEmpty(entity.cwInventory) then
					entity:Explode(entity:BoundingRadius() * 2)
					entity:Remove()
				end
			end,
			CanGiveItem = function(player, storageTable, itemTable) return false end
		})
	elseif class == "cw_cash" and arguments == "cwCashTake" then
		if cwEntity:BelongsToAnotherCharacter(player, entity) then
			cwPly:Notify(player, {"DroppedCashOtherChar", L(player, "Cash")})

			return
		end

		cwPly:GiveCash(player, entity.cwAmount, L(player, "Cash"))
		player:EmitSound("physics/body/body_medium_impact_soft" .. math.random(1, 7) .. ".wav")
		player:FakePickup(entity)
		entity:Remove()
	elseif generator and arguments == "cwGeneratorSupply" then
		if entity:GetPower() < generator.power then
			if not entity.CanSupply or entity:CanSupply(player, generator) then
				cwPlugin:Call("PlayerChargeGenerator", player, entity, generator)
				entity:SetDTInt(0, generator.power)
				player:FakePickup(entity)

				if entity.OnSupplied then
					entity:OnSupplied(player)
				end

				entity:Explode()
			end
		end
	end
end

--[[
	@codebase Server
	@details Called when a player has spawned a prop.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for model.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawnedProp(player, model, entity)
	if IsValid(entity) then
		local scalePropCost = cwConfig:Get("scale_prop_cost"):Get()

		if scalePropCost > 0 then
			local cost = math.ceil(math.max((entity:BoundingRadius() / 2) * scalePropCost, 1))

			local info = {
				cost = cost,
				name = "Prop"
			}

			cwPlugin:Call("PlayerAdjustPropCostInfo", player, entity, info)

			if cwPly:CanAfford(player, info.cost) then
				cwPly:GiveCash(player, -info.cost, info.name)

				entity.cwGiveRefundTab = {CurTime() + 10, player, info.cost}
			else
				player:NotifyMissingCash(info.cost - player:GetCash())
				entity:Remove()

				return
			end
		end

		if IsValid(entity) then
			self.BaseClass:PlayerSpawnedProp(player, model, entity)
			entity:SetOwnerKey(player:GetCharacterKey())

			if IsValid(entity) then
				cwKernel:PrintLog(LOGTYPE_URGENT, {"LogPlayerSpawnedModel", player:Name(), tostring(model)})

				if cwConfig:Get("prop_kill_protection"):Get() then
					entity.cwDamageImmunity = CurTime() + 60
				end
			end
		end
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to spawn a prop.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for model.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawnProp(player, model)
	if not cwPly:HasFlags(player, "e") then return false end

	if not player:Alive() or player:IsRagdolled() then
		cwPly:Notify(player, {"CannotActionRightNow"})

		return false
	end

	if cwPly:IsAdmin(player) then return true end

	return self.BaseClass:PlayerSpawnProp(player, model)
end

--[[
	@codebase Server
	@details Called when a player attempts to spawn a ragdoll.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for model.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawnRagdoll(player, model)
	if not cwPly:HasFlags(player, "r") then return false end

	if not player:Alive() or player:IsRagdolled() then
		cwPly:Notify(player, {"CannotActionRightNow"})

		return false
	end

	if not cwPly:IsAdmin(player) then
		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to spawn an effect.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for model.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawnEffect(player, model)
	if not player:Alive() or player:IsRagdolled() then
		cwPly:Notify(player, {"CannotActionRightNow"})

		return false
	end

	if not cwPly:IsAdmin(player) then
		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to spawn a vehicle.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for model.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawnVehicle(player, model)
	if not string.find(model, "chair") and not string.find(model, "seat") then
		if not cwPly:HasFlags(player, "C") then return false end
	elseif not cwPly:HasFlags(player, "c") then
		return false
	end

	if not player:Alive() or player:IsRagdolled() then
		cwPly:Notify(player, {"CannotActionRightNow"})

		return false
	end

	if cwPly:IsAdmin(player) then return true end

	return self.BaseClass:PlayerSpawnVehicle(player, model)
end

--[[
	@codebase Server
	@details Called when a player attempts to use a tool.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for trace.
	@param {Unknown} Missing description for tool.
	@returns {Unknown}
--]]
function Clockwork:CanTool(player, trace, tool)
	local isAdmin = cwPly:IsAdmin(player)

	if IsValid(trace.Entity) then
		local bPropProtectionEnabled = cwConfig:Get("enable_prop_protection"):Get()
		local characterKey = player:GetCharacterKey()
		if not isAdmin and not cwEntity:IsInteractable(trace.Entity) then return false end
		if not isAdmin and cwEntity:IsPlayerRagdoll(trace.Entity) then return false end

		if bPropProtectionEnabled and not isAdmin then
			local ownerKey = trace.Entity:GetOwnerKey()
			if ownerKey and characterKey ~= ownerKey then return false end
		end

		if not isAdmin then
			if tool == "nail" then
				local newTrace = {}
				newTrace.start = trace.HitPos
				newTrace.endpos = trace.HitPos + player:GetAimVector() * 16

				newTrace.filter = {player, trace.Entity}

				newTrace = util.TraceLine(newTrace)

				if IsValid(newTrace.Entity) then
					if not cwEntity:IsInteractable(newTrace.Entity) or cwEntity:IsPlayerRagdoll(newTrace.Entity) then return false end

					if bPropProtectionEnabled then
						local ownerKey = newTrace.Entity:GetOwnerKey()
						if ownerKey and characterKey ~= ownerKey then return false end
					end
				end
			elseif tool == "remover" and player:KeyDown(IN_ATTACK2) and not player:KeyDownLast(IN_ATTACK2) then
				if not trace.Entity:IsMapEntity() then
					local entities = constraint.GetAllConstrainedEntities(trace.Entity)

					for k, v in pairs(entities) do
						if v:IsMapEntity() or cwEntity:IsPlayerRagdoll(v) then return false end

						if bPropProtectionEnabled then
							local ownerKey = v:GetOwnerKey()
							if ownerKey and characterKey ~= ownerKey then return false end
						end
					end
				else
					return false
				end
			end
		end
	end

	if not isAdmin then
		if tool == "dynamite" or tool == "duplicator" then return false end

		return self.BaseClass:CanTool(player, trace, tool)
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player attempts to use the property menu.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for property.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:CanProperty(player, property, entity)
	local isAdmin = cwPly:IsAdmin(player)
	if not player:Alive() or player:IsRagdolled() or not isAdmin then return false end

	return self.BaseClass:CanProperty(player, property, entity)
end

--[[
	@codebase Server
	@details Called when a player attempts to use drive.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for entity.
	@returns {Unknown}
--]]
function Clockwork:CanDrive(player, entity)
	local isAdmin = cwPly:IsAdmin(player)
	if not player:Alive() or player:IsRagdolled() or not isAdmin then return false end

	return self.BaseClass:CanDrive(player, entity)
end

--[[
	@codebase Server
	@details Called when a player attempts to NoClip.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerNoClip(player)
	if player:IsRagdolled() then
		return false
	elseif player:IsSuperAdmin() then
		return true
	else
		return false
	end
end

--[[
	@codebase Server
	@details Called when a player's character has initialized.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerCharacterInitialized(player)
	cwDatastream:Start(player, "InvClear", true)
	cwDatastream:Start(player, "AttrClear", true)
	cwDatastream:Start(player, "ReceiveLimbDamage", player:GetCharacterData("LimbData"))

	if not cwClass:FindByID(player:Team()) then
		cwClass:AssignToDefault(player)
	end

	player.cwAttrProgress = player.cwAttrProgress or {}
	player.cwAttrProgressTime = 0

	for k, v in pairs(self.attribute:GetAll()) do
		player:UpdateAttribute(k)
	end

	for k, v in pairs(player:GetAttributes()) do
		player.cwAttrProgress[k] = math.floor(v.progress)
	end

	local startHintsDelay = 4

	local starterHintsTable = {"Directory", "GiveName", "TargetRecognises", "RaiseWeapon"}

	for k, v in pairs(starterHintsTable) do
		local hintTable = self.hint:Find(v)

		if hintTable and not player:GetData("Hint" .. k) then
			if not hintTable.Callback or hintTable.Callback(player) ~= false then
				timer.Simple(startHintsDelay, function()
					if IsValid(player) then
						self.hint:Send(player, hintTable.text, 30)
						player:SetData("Hint" .. k, true)
					end
				end)

				startHintsDelay = startHintsDelay + 30
			end
		end
	end

	if startHintsDelay > 4 then
		player.cwViewStartHints = true

		timer.Simple(startHintsDelay, function()
			if IsValid(player) then
				player.cwViewStartHints = false
			end
		end)
	end

	timer.Simple(FrameTime() * 0.5, function()
		self.inventory:SendUpdateAll(player)
		player:NetworkAccessories()
	end)

	cwDatastream:Start(player, "CharacterInit", player:GetCharacterKey())
	local _, originalRankTable = Clockwork.player:GetFactionRank(player)

	if not originalRankTable then
		local faction = player:GetFaction()
		local defaultRankName, defaultRankTable = cwFaction:GetDefaultRank(faction)
		local lowestRankName, lowestRankTable = cwFaction:GetLowestRank(faction)

		if defaultRankTable or lowestRankTable then
			player:SetFactionRank(defaultRankTable and defaultRankName or lowestRankName)
		end
	end

	local _, rankTable = Clockwork.player:GetFactionRank(player)

	if rankTable and rankTable.class and cwClass:GetAll()[rankTable.class] then
		cwClass:Set(player, rankTable.class)
	end

	cwPlugin:Call("PostPlayerCharacterInitialized", player)
end

--[[
	@codebase Server
	@details Called when a player has used their death code.
	@returns {Unknown}
--]]
function Clockwork:PlayerDeathCodeUsed(player, commandTable, arguments)
end

--[[
	@codebase Server
	@details Called when a player has created a character.
	@returns {Unknown}
--]]
function Clockwork:PlayerCharacterCreated(player, character)
end

--[[
	@codebase Server
	@details Called when a player's character has unloaded.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerCharacterUnloaded(player)
	cwPly:SetupRemovePropertyDelays(player)
	cwPly:DisableProperty(player)
	cwPly:SetRagdollState(player, RAGDOLL_RESET)
	cwStorage:Close(player, true)
	player:SetTeam(TEAM_UNASSIGNED)
end

--[[
	@codebase Server
	@details Called when a player's character has loaded.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerCharacterLoaded(player)
	player:SetSharedVar("InvWeight", cwConfig:Get("default_inv_weight"):Get())
	player:SetSharedVar("InvSpace", cwConfig:Get("default_inv_space"):Get())
	player.cwCharLoadedTime = CurTime()
	player.cwCrouchedSpeed = cwConfig:Get("crouched_speed"):Get()

	player.cwClipTwoInfo = {
		weapon = NULL,
		ammo = 0
	}

	player.cwClipOneInfo = {
		weapon = NULL,
		ammo = 0
	}

	player.cwInitialized = true
	player.cwAttrBoosts = player.cwAttrBoosts or {}
	player.cwRagdollTab = player.cwRagdollTab or {}
	player.cwSpawnWeps = player.cwSpawnWeps or {}
	player.cwFirstSpawn = true
	player.cwLightSpawn = false
	player.cwChangeClass = false
	player.cwInfoTable = player.cwInfoTable or {}
	player.cwSpawnAmmo = player.cwSpawnAmmo or {}
	player.cwJumpPower = cwConfig:Get("jump_power"):Get()
	player.cwWalkSpeed = cwConfig:Get("walk_speed"):Get()
	player.cwRunSpeed = cwConfig:Get("run_speed"):Get()
	hook.Call("PlayerRestoreCharacterData", Clockwork, player, player:QueryCharacter("Data"))
	hook.Call("PlayerRestoreTempData", Clockwork, player, player:CreateTempData())
	cwPly:SetCharacterMenuState(player, CHARACTER_MENU_CLOSE)
	cwPlugin:Call("PlayerCharacterInitialized", player)
	cwPly:RestoreRecognisedNames(player)
	cwPly:ReturnProperty(player)
	cwPly:SetInitialized(player, true)
	player.cwFirstSpawn = false
	local charactersTable = cwConfig:Get("mysql_characters_table"):Get()
	local schemaFolder = cwKernel:GetSchemaFolder()
	local characterID = player:GetCharacterID()
	local onNextLoad = player:QueryCharacter("OnNextLoad")
	local steamID = player:SteamID()
--	local query = "UPDATE " .. charactersTable .. " SET _OnNextLoad = \"\" WHERE"
	local playerFlags = player:GetPlayerFlags()

	if onNextLoad ~= "" then
		local queryObj = cwDatabase:Update(charactersTable)
		queryObj:SetValue("_OnNextLoad", "")
		queryObj:AddWhere("_Schema = ?", schemaFolder)
		queryObj:AddWhere("_SteamID = ?", steamID)
		queryObj:AddWhere("_CharacterID = ?", characterID)
		queryObj:Push()
		player:SetCharacterData("OnNextLoad", "", true)
		CHARACTER = player:GetCharacter()
		PLAYER = player
		RunString(onNextLoad)
		PLAYER = nil
		CHARACTER = nil
	end

	local itemsList = cwInventory:GetAsItemsList(player:GetInventory())

	for k, v in pairs(itemsList) do
		if v.OnRestorePlayerGear then
			v:OnRestorePlayerGear(player)
		end
	end

	if playerFlags then
		cwPly:GiveFlags(player, playerFlags)
	end
end

--[[
	@codebase Server
	@details Called when a player's property should be restored.
	@returns {Unknown}
--]]
function Clockwork:PlayerReturnProperty(player)
end

--[[
	@codebase Server
	@details Called when config has initialized for a player.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerConfigInitialized(player)
	cwPlugin:Call("PlayerSendDataStreamInfo", player)

	if not player:IsBot() then
		timer.Simple(FrameTime() * 32, function()
			if IsValid(player) then
				cwDatastream:Start(player, "DataStreaming", true)
			end
		end)
	else
		cwPlugin:Call("PlayerDataStreamInfoSent", player)
	end
end

--[[
	@codebase Server
	@details Called when a player has used their radio.
	@returns {Unknown}
--]]
function Clockwork:PlayerRadioUsed(player, text, listeners, eavesdroppers)
end

--[[
	@codebase Server
	@details Called when a player's drop weapon info should be adjusted.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for info.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustDropWeaponInfo(player, info)
	return true
end

--[[
	@codebase Server
	@details Called when a player's character creation info should be adjusted.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustCharacterCreationInfo(player, info, data)
end

--[[
	@codebase Server
	@details Called when a player's earn generator info should be adjusted.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustEarnGeneratorInfo(player, info)
end

--[[
	@codebase Server
	@details Called when a player's order item should be adjusted.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustOrderItemTable(player, itemTable)
end

--[[
	@codebase Server
	@details Called when a player's next punch info should be adjusted.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustNextPunchInfo(player, info)
end

--[[
	@codebase Server
	@details Called when a player uses an unknown item function.
	@returns {Unknown}
--]]
function Clockwork:PlayerUseUnknownItemFunction(player, itemTable, itemFunction)
end

--[[
	@codebase Server
	@details Called when deciding whether to automatically delete a character.
	@param The entity of the player who created the character.
	@param The character which is being considered for deletion.
	@returns A boolean indicating whether or not the character should be deleted.
--]]
function Clockwork:ShouldDeleteCharacter(player, character)
	if not self.faction.stored[character.faction] then return true end
end

--[[
	@codebase Server
	@details Called when a player's character table should be adjusted.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for character.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustCharacterTable(player, character)
	if self.faction.stored[character.faction] then
		if self.faction.stored[character.faction].whitelist and not cwPly:IsWhitelisted(player, character.faction) then
			character.data["CharBanned"] = true
		end
	end
end

--[[
	@codebase Server
	@details Called when a player's character screen info should be adjusted.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for character.
	@param {Unknown} Missing description for info.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustCharacterScreenInfo(player, character, info)
	local _, rank = player:GetFactionRank()

	if rank and rank.model then
		info.model = rank.model
	end
end

--[[
	@codebase Server
	@details Called when a player's prop cost info should be adjusted.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustPropCostInfo(player, entity, info)
end

--[[
	@codebase Server
	@details Called when a player's death info should be adjusted.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustDeathInfo(player, info)
end

--[[
	@codebase Server
	@details Called when chat box info should be adjusted.
	@param {Unknown} Missing description for info.
	@returns {Unknown}
--]]
function Clockwork:ChatBoxAdjustInfo(info)
	if table.HasValue(Clockwork.voices.chatClasses, info.class) then
		if IsValid(info.speaker) and info.speaker:HasInitialized() then
			info.text = string.upper(string.sub(info.text, 1, 1)) .. string.sub(info.text, 2)
			local areVoiceCommandsEnabled = cwConfig:Get("enable_voice_commands"):Get()
			local voiceGroups = Clockwork.voices:GetAll()
			local voices = {}

			if areVoiceCommandsEnabled then
				for k, v in pairs(voiceGroups) do
					if v.IsPlayerMember(info.speaker) then
						for k2, v2 in pairs(v.voices) do
							table.insert(voices, v2)
						end
					end
				end
			end

			local textTable = string.Explode("; ?", info.text, true)
			local voiceList = {}

			for k, v in pairs(textTable) do
				local wasFound = false
				local cmd = string.upper(v)

				for k2, v2 in pairs(voices or {}) do
					if string.upper(v2.command) == cmd then
						wasFound = true
						local voice = v2 or {}
						voice.global = voice.global or false
						voice.volume = voice.volume or v2.volume or 80
						voice.sound = voice.sound or v2.sound
						voice.pitch = voice.pitch or v2.pitch

						if v2.gender then
							if v2.female and info.speaker:QueryCharacter("Gender") == GENDER_FEMALE then
								voice.sound = string.Replace(voice.sound, "/male", "/female")
							end
						end

						if info.class == "whisper" then
							voice.volume = voice.volume * 0.75
						elseif info.class == "yell" then
							voice.volume = voice.volume * 1.25
						end

						if v2.phrase == nil or v2.phrase == "" then
							if k < 1 then
								info.visible = false
							end
						else
							textTable[k] = v2.phrase
						end

						if k > 0 then
							voice.duration = SoundDuration(voice.sound)
						end

						voiceList[#voiceList + 1] = voice
						break
					end
				end

				if wasFound == false and k < 1 then
					textTable[k] = v .. ";"
				end
			end

			local function fixMarkup(a, b)
				return a .. " " .. string.upper(b)
			end

			info.text = table.concat(textTable, " ")
			info.text = string.gsub(info.text, " ?([.?!]) (%l?)", fixMarkup)

			if voiceList[1] then
				info.voiceList = voiceList
			end
		end
	end

	info.textTransformer = info.textTransformer or function(text) return text end
	info.text = info.textTransformer(info.text)

	if info.class == "ic" then
		cwKernel:PrintLog(LOGTYPE_GENERIC, {"LogPlayerSays", info.speaker:Name(), info.text})
	elseif info.class == "looc" then
		cwKernel:PrintLog(LOGTYPE_GENERIC, {"LogPlayerSaysLOOC", info.speaker:Name(), info.text})
	end
end

--[[
	@codebase Shared
	@details Called when a chat box message has been added.
	@param {Unknown} Missing description for info.
	@returns {Unknown}
--]]
function Clockwork:ChatBoxMessageAdded(info)
	if info.voiceList and info.voiceList[1] then
		local delay = 0

		for key, voice in pairs(info.voiceList) do
			if IsValid(info.speaker) and info.speaker:HasInitialized() then
				if delay == 0 then
					info.speaker:EmitSound(voice.sound, voice.volume, voice.pitch)
				else
					timer.Simple(delay, function()
						info.speaker:EmitSound(voice.sound, voice.volume, voice.pitch)
					end)
				end
			end

			if voice.global then
				if delay == 0 then
					for k, v in pairs(info.listeners) do
						if v ~= info.speaker then
							Clockwork.player:PlaySound(v, voice.sound)
						end
					end
				else
					timer.Simple(delay, function()
						for k, v in pairs(info.listeners) do
							if v ~= info.speaker then
								Clockwork.player:PlaySound(v, voice.sound)
							end
						end
					end)
				end
			end

			delay = delay + voice.duration + 0.01
		end
	end
end

--[[
	@codebase Server
	@details Called when a player's radio text should be adjusted.
	@returns {Unknown}
--]]
function Clockwork:PlayerAdjustRadioInfo(player, info)
end

--[[
	@codebase Server
	@details Called when a player should gain a frag.
	@returns {Unknown}
--]]
function Clockwork:PlayerCanGainFrag(player, victim)
	return true
end

--[[
	@codebase Server
	@details Called just after a player spawns.
	@returns {Unknown}
--]]
function Clockwork:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	if firstSpawn then
		local attrBoosts = player:GetCharacterData("AttrBoosts")
		local health = player:GetCharacterData("Health")
		local armor = player:GetCharacterData("Armor")

		if health and health > 1 then
			player:SetHealth(health)
		end

		if armor and armor > 1 then
			player:SetArmor(armor)
		end

		if attrBoosts then
			for k, v in pairs(attrBoosts) do
				for k2, v2 in pairs(v) do
					cwAttributes:Boost(player, k2, k, v2.amount, v2.duration)
				end
			end
		end
	else
		player:SetCharacterData("AttrBoosts", nil)
		player:SetCharacterData("Health", nil)
		player:SetCharacterData("Armor", nil)
	end

	player:Fire("Targetname", player:GetFaction(), 0)
end

--[[
	@codebase Server
	@details Called just before a player would take damage.
	@returns {Unknown}
--]]
function Clockwork:PrePlayerTakeDamage(player, attacker, inflictor, damageInfo)
end

--[[
	@codebase Server
	@details Called when a player should take damage.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for attacker.
	@param {Unknown} Missing description for inflictor.
	@param {Unknown} Missing description for damageInfo.
	@returns {Unknown}
--]]
function Clockwork:PlayerShouldTakeDamage(player, attacker, inflictor, damageInfo)
	return not cwPly:IsNoClipping(player)
end

--[[
	@codebase Server
	@details Called when a player is attacked by a trace.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for damageInfo.
	@param {Unknown} Missing description for direction.
	@param {Unknown} Missing description for trace.
	@returns {Unknown}
--]]
function Clockwork:PlayerTraceAttack(player, damageInfo, direction, trace)
	player.cwLastHitGroup = trace.HitGroup

	return false
end

--[[
	@codebase Server
	@details Called just before a player dies.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for attacker.
	@param {Unknown} Missing description for damageInfo.
	@returns {Unknown}
--]]
function Clockwork:DoPlayerDeath(player, attacker, damageInfo)
	cwPly:DropWeapons(player, attacker)
	cwPly:SetAction(player, false)
	cwPly:SetDrunk(player, false)
	local deathSound = cwPlugin:Call("PlayerPlayDeathSound", player, player:GetGender())
	local decayTime = cwConfig:Get("body_decay_time"):Get()

	if decayTime > 0 then
		cwPly:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, nil, decayTime, cwKernel:ConvertForce(damageInfo:GetDamageForce() * 32))
	else
		cwPly:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, nil, 600, cwKernel:ConvertForce(damageInfo:GetDamageForce() * 32))
	end

	if cwPlugin:Call("PlayerCanDeathClearRecognisedNames", player, attacker, damageInfo) then
		cwPly:ClearRecognisedNames(player)
	end

	if cwPlugin:Call("PlayerCanDeathClearName", player, attacker, damageInfo) then
		cwPly:ClearName(player)
	end

	if deathSound then
		player:EmitSound("physics/flesh/flesh_impact_hard" .. math.random(1, 5) .. ".wav", 150)

		timer.Simple(FrameTime() * 25, function()
			if IsValid(player) then
				player:EmitSound(deathSound)
			end
		end)
	end

	if cwPlugin:Call("PlayerCanDeathStripAmmo", player, attacker, damageInfo) then
		player:SetCharacterData("Ammo", {}, true)
		player:StripAmmo()
	end

	player:SetForcedAnimation(false)
	player:StripWeapons()
	player.cwSpawnAmmo = {}
	player:Extinguish()
	player:AddDeaths(1)
	player:UnLock()

	if IsValid(attacker) and attacker:IsPlayer() and player ~= attacker then
		if cwPlugin:Call("PlayerCanGainFrag", attacker, player) then
			attacker:AddFrags(1)
		end
	end
end

--[[
	@codebase Server
	@details Called when a player dies.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for inflictor.
	@param {Unknown} Missing description for attacker.
	@param {Unknown} Missing description for damageInfo.
	@returns {Unknown}
--]]
function Clockwork:PlayerDeath(player, inflictor, attacker, damageInfo)
	cwKernel:CalculateSpawnTime(player, inflictor, attacker, damageInfo)
	local ragdoll = player:GetRagdollEntity()

	if ragdoll then
		if IsValid(inflictor) and inflictor:GetClass() == "prop_combine_ball" then
			if damageInfo then
				cwEntity:Disintegrate(ragdoll, 3, damageInfo:GetDamageForce() * 32)
			else
				cwEntity:Disintegrate(ragdoll, 3)
			end
		end
	end

	if damageInfo then
		if attacker:IsPlayer() then
			if IsValid(attacker:GetActiveWeapon()) then
				local weapon = attacker:GetActiveWeapon()
				local itemTable = cwItem:GetByWeapon(weapon)

				if IsValid(weapon) and itemTable then
					cwKernel:PrintLog(LOGTYPE_CRITICAL, {
						"LogPlayerDealDamageWithKill", attacker:Name(), tostring(math.ceil(damageInfo:GetDamage())), player:Name(), {itemTable("name")}
					})
				else
					cwKernel:PrintLog(LOGTYPE_CRITICAL, {"LogPlayerDealDamageWithKill", attacker:Name(), tostring(math.ceil(damageInfo:GetDamage())), player:Name(), cwPly:GetWeaponClass(attacker)})
				end
			else
				cwKernel:PrintLog(LOGTYPE_CRITICAL, {"LogPlayerDealDamageKill", attacker:Name(), tostring(math.ceil(damageInfo:GetDamage())), player:Name()})
			end
		else
			cwKernel:PrintLog(LOGTYPE_CRITICAL, {"LogPlayerDealDamageKill", attacker:GetClass(), tostring(math.ceil(damageInfo:GetDamage())), player:Name()})
		end
	end
end

--[[
	@codebase Server
	@details Called when an item entity has taken damage.
	@param {Unknown} Missing description for itemEntity.
	@param {Unknown} Missing description for itemTable.
	@param {Unknown} Missing description for damageInfo.
	@returns {Unknown}
--]]
function Clockwork:ItemEntityTakeDamage(itemEntity, itemTable, damageInfo)
	return true
end

--[[
	@codebase Server
	@details Called when an item entity has been destroyed.
	@returns {Unknown}
--]]
function Clockwork:ItemEntityDestroyed(itemEntity, itemTable)
end

--[[
	@codebase Server
	@details Called when an item's network observers are needed.
	@param {Unknown} Missing description for itemTable.
	@param {Unknown} Missing description for info.
	@returns {Unknown}
--]]
function Clockwork:ItemGetNetworkObservers(itemTable, info)
	local uniqueID = itemTable("uniqueID")
	local itemID = itemTable("itemID")
	local entity = cwItem:FindEntityByInstance(itemTable)

	if entity then
		info.sendToAll = true

		return false
	end

	for k, v in pairs(player.GetAll()) do
		if v:HasInitialized() then
			local inventory = cwStorage:Query(v, "inventory")

			if inventory and inventory[uniqueID] and inventory[uniqueID][itemID] or v:HasItemInstance(itemTable) then
				info.observers[v] = v
			elseif v:HasItemAsWeapon(itemTable) then
				info.observers[v] = v
			end
		end
	end
end

--[[
	@codebase Server
	@details Called when a player's weapons should be given.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:PlayerLoadout(player)
	local weapons = cwClass:Query(player:Team(), "weapons")
	local ammo = cwClass:Query(player:Team(), "ammo")
	player.cwSpawnWeps = {}
	player.cwSpawnAmmo = {}

	if cwPly:HasFlags(player, "t") then
		cwPly:GiveSpawnWeapon(player, "gmod_tool")
	end

	if cwPly:HasFlags(player, "p") then
		cwPly:GiveSpawnWeapon(player, "weapon_physgun")

		if cwConfig:Get("custom_weapon_color"):Get() then
			local weaponColor = player:GetInfo("cl_weaponcolor")
			player:SetWeaponColor(Vector(weaponColor))
		end
	end

	cwPly:GiveSpawnWeapon(player, "weapon_physcannon")

	if cwConfig:Get("give_hands"):Get() then
		cwPly:GiveSpawnWeapon(player, "cw_hands")
	end

	if cwConfig:Get("give_keys"):Get() then
		cwPly:GiveSpawnWeapon(player, "cw_keys")
	end

	if weapons then
		for k, v in pairs(weapons) do
			if not player:HasItemByID(v) then
				local itemTable = cwItem:CreateInstance(v)

				if not cwPly:GiveSpawnItemWeapon(player, itemTable) then
					player:Give(v)
				end
			end
		end
	end

	if ammo then
		for k, v in pairs(ammo) do
			cwPly:GiveSpawnAmmo(player, k, v)
		end
	end

	cwPlugin:Call("PlayerGiveWeapons", player)

	if cwConfig:Get("give_hands"):Get() then
		player:SelectWeapon("cw_hands")
	end
end

--[[
	@codebase Server
	@details Called when the server shuts down.
	@returns {Unknown}
--]]
function Clockwork:ShutDown()
	Clockwork.ShuttingDown = true

	cwPlugin:Call("SaveData")
end

--[[
	@codebase Server
	@details Called when a player presses F1.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:ShowHelp(player)
	cwDatastream:Start(player, "InfoToggle", true)
end

--[[
	@codebase Server
	@details Called when a player presses F2.
	@param {Unknown} Missing description for ply.
	@returns {Unknown}
--]]
function Clockwork:ShowTeam(ply)
	if not cwPly:IsNoClipping(ply) then
		local doRecogniseMenu = true
		local entity = ply:GetEyeTraceNoCursor().Entity
		local plyTable = player.GetAll()

		if IsValid(entity) and cwEntity:IsDoor(entity) then
			if entity:GetPos():Distance(ply:GetShootPos()) <= 192 then
				if cwPlugin:Call("PlayerCanViewDoor", ply, entity) then
					if cwPlugin:Call("PlayerUse", ply, entity) then
						local owner = cwEntity:GetOwner(entity)

						if IsValid(owner) then
							if cwPly:HasDoorAccess(ply, entity, DOOR_ACCESS_COMPLETE) then
								local data = {
									sharedAccess = cwEntity:DoorHasSharedAccess(entity),
									sharedText = cwEntity:DoorHasSharedText(entity),
									unsellable = cwEntity:IsDoorUnsellable(entity),
									accessList = {},
									isParent = cwEntity:IsDoorParent(entity),
									entity = entity,
									owner = owner
								}

								for k, v in pairs(plyTable) do
									if v ~= ply and v ~= owner then
										if cwPly:HasDoorAccess(v, entity, DOOR_ACCESS_COMPLETE) then
											data.accessList[v] = DOOR_ACCESS_COMPLETE
										elseif cwPly:HasDoorAccess(v, entity, DOOR_ACCESS_BASIC) then
											data.accessList[v] = DOOR_ACCESS_BASIC
										end
									end
								end

								cwDatastream:Start(ply, "DoorManagement", data)
							end
						else
							cwDatastream:Start(ply, "PurchaseDoor", entity)
						end
					end
				end

				doRecogniseMenu = false
			end
		end

		if cwConfig:Get("recognise_system"):Get() then
			if doRecogniseMenu then
				cwDatastream:Start(ply, "RecogniseMenu", true)
			end
		end
	end
end

--[[
	@codebase Server
	@details Called when a player selects a custom character option.
	@returns {Unknown}
--]]
function Clockwork:PlayerSelectCustomCharacterOption(player, action, character)
end

--[[
	@codebase Server
	@details Called when a player takes damage.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for inflictor.
	@param {Unknown} Missing description for attacker.
	@param {Unknown} Missing description for hitGroup.
	@param {Unknown} Missing description for damageInfo.
	@returns {Unknown}
--]]
function Clockwork:PlayerTakeDamage(player, inflictor, attacker, hitGroup, damageInfo)
	if damageInfo:IsBulletDamage() and cwEvent:CanRun("limb_damage", "stumble") then
		if hitGroup == HITGROUP_LEFTLEG or hitGroup == HITGROUP_RIGHTLEG then
			local rightLeg = cwLimb:GetDamage(player, HITGROUP_RIGHTLEG)
			local leftLeg = cwLimb:GetDamage(player, HITGROUP_LEFTLEG)

			if rightLeg > 50 and leftLeg > 50 and not player:IsRagdolled() then
				cwPly:SetRagdollState(player, RAGDOLL_FALLENOVER, 8, nil, cwKernel:ConvertForce(damageInfo:GetDamageForce() * 32))
				damageInfo:ScaleDamage(0.25)
			end
		end
	end
end

--[[
	@codebase Server
	@details Called when an entity takes damage.
	@param {Unknown} Missing description for entity.
	@param {Unknown} Missing description for damageInfo.
	@returns {Unknown}
--]]
function Clockwork:EntityTakeDamage(entity, damageInfo)
	local inflictor = damageInfo:GetInflictor()
	local attacker = damageInfo:GetAttacker()
	local amount = damageInfo:GetDamage()

	if cwConfig:Get("prop_kill_protection"):Get() then
		local curTime = CurTime()

		if IsValid(inflictor) and inflictor.cwDamageImmunity and inflictor.cwDamageImmunity > curTime and not inflictor:IsVehicle() or IsValid(attacker) and attacker.cwDamageImmunity and attacker.cwDamageImmunity > curTime then
			entity.cwDamageImmunity = curTime + 1
			damageInfo:SetDamage(0)

			return false
		end

		if IsValid(attacker) and attacker:GetClass() == "worldspawn" and entity.cwDamageImmunity and entity.cwDamageImmunity > curTime then
			damageInfo:SetDamage(0)

			return false
		end

		if IsValid(inflictor) and inflictor:IsBeingHeld() or attacker:IsBeingHeld() then
			damageInfo:SetDamage(0)

			return false
		end
	end

	if entity:IsPlayer() and entity:InVehicle() and not IsValid(entity:GetVehicle():GetParent()) then
		entity.cwLastHitGroup = cwKernel:GetRagdollHitBone(entity, damageInfo:GetDamagePosition(), HITGROUP_GEAR)

		if damageInfo:IsBulletDamage() then
			if (attacker:IsPlayer() or attacker:IsNPC()) and attacker ~= player then
				damageInfo:ScaleDamage(10000)
			end
		end
	end

	if damageInfo:GetDamage() == 0 then return end
	local isPlayerRagdoll = cwEntity:IsPlayerRagdoll(entity)
	local player = cwEntity:GetPlayer(entity)

	if player and (entity:IsPlayer() or isPlayerRagdoll) then
		if damageInfo:IsFallDamage() or cwConfig:Get("damage_view_punch"):Get() then
			player:ViewPunch(Angle(math.random(amount, amount), math.random(amount, amount), math.random(amount, amount)))
		end

		if not isPlayerRagdoll then
			if damageInfo:IsDamageType(DMG_CRUSH) and damageInfo:GetDamage() < 10 then
				damageInfo:SetDamage(0)
			else
				local lastHitGroup = player:LastHitGroup()
--				local killed = nil

				if player:InVehicle() and damageInfo:IsExplosionDamage() then
					if not damageInfo:GetDamage() or damageInfo:GetDamage() == 0 then
						damageInfo:SetDamage(player:GetMaxHealth())
					end
				end

				self:ScaleDamageByHitGroup(player, attacker, lastHitGroup, damageInfo, amount)

				if damageInfo:GetDamage() > 0 then
					cwKernel:CalculatePlayerDamage(player, lastHitGroup, damageInfo)

					if cwPlugin:Call("PlayerCanTakeKnockbackFromDamage", entity, damageInfo) then
						player:SetVelocity(cwKernel:ConvertForce(damageInfo:GetDamageForce() * 32, 200))
					end

					if player:Alive() and player:Health() == 1 then
						player:SetFakingDeath(true)
						hook.Call("DoPlayerDeath", self, player, attacker, damageInfo)
						hook.Call("PlayerDeath", self, player, inflictor, attacker, damageInfo)
						cwKernel:CreateBloodEffects(damageInfo:GetDamagePosition(), 1, player, damageInfo:GetDamageForce())
						player:SetFakingDeath(false, true)
					else
						local bNoMsg = cwPlugin:Call("PlayerTakeDamage", player, inflictor, attacker, lastHitGroup, damageInfo)
						local sound

						if (player.cwNextPainSound or 0) < CurTime() then
							sound = cwPlugin:Call("PlayerPlayPainSound", player, player:GetGender(), damageInfo, hitGroup)
							player.cwNextPainSound = CurTime() + 1
						end

						cwKernel:CreateBloodEffects(damageInfo:GetDamagePosition(), 1, player, damageInfo:GetDamageForce())

						if sound and not bNoMsg then
							player:EmitHitSound(sound)
						end

						if player:Armor() > 0 then
							armor = " and " .. player:Armor() .. " armor!"
						end

						if attacker:IsPlayer() then
							cwKernel:PrintLog(LOGTYPE_MAJOR, {"LogPlayerTakeDamageWith", player:Name(), tostring(math.ceil(damageInfo:GetDamage())), attacker:Name(), cwPly:GetWeaponClass(attacker, "UNKNOWN"), player:Health(), player:Armor()})
						else
							cwKernel:PrintLog(LOGTYPE_MAJOR, {"LogPlayerTakeDamage", player:Name(), tostring(math.ceil(damageInfo:GetDamage())), attacker:GetClass(), player:Health(), player:Armor()})
						end
					end
				end

				damageInfo:SetDamage(0)
				player.cwLastHitGroup = nil
			end
		else
			local hitGroup = cwKernel:GetRagdollHitGroup(entity, damageInfo:GetDamagePosition())
--			local curTime = CurTime()
--			local killed
			self:ScaleDamageByHitGroup(player, attacker, hitGroup, damageInfo, amount)

			if cwPlugin:Call("PlayerRagdollCanTakeDamage", player, entity, inflictor, attacker, hitGroup, damageInfo) and damageInfo:GetDamage() > 0 then
				if not attacker:IsPlayer() then
					if attacker:GetClass() == "prop_ragdoll" or cwEntity:IsDoor(attacker) or damageInfo:GetDamage() < 5 then return end
				end

				if damageInfo:GetDamage() >= 10 or damageInfo:IsBulletDamage() then
					cwKernel:CreateBloodEffects(damageInfo:GetDamagePosition(), 1, entity, damageInfo:GetDamageForce())
				end

				cwKernel:CalculatePlayerDamage(player, hitGroup, damageInfo)

				if player:Alive() and player:Health() == 1 then
					player:SetFakingDeath(true)
					player:GetRagdollTable().health = 0
					player:GetRagdollTable().armor = 0
					hook.Call("DoPlayerDeath", self, player, attacker, damageInfo)
					hook.Call("PlayerDeath", self, player, inflictor, attacker, damageInfo)
					player:SetFakingDeath(false, true)
				elseif player:Alive() then
					local bNoMsg = cwPlugin:Call("PlayerTakeDamage", player, inflictor, attacker, hitGroup, damageInfo)
					local sound

					if (player.cwNextPainSound or 0) < CurTime() then
						sound = cwPlugin:Call("PlayerPlayPainSound", player, player:GetGender(), damageInfo, hitGroup)
						player.cwNextPainSound = CurTime() + 1
					end

					if sound and not bNoMsg then
						entity:EmitHitSound(sound)
					end

					if player:Armor() > 0 then
						armor = " and " .. player:Armor() .. " armor!"
					end

					if attacker:IsPlayer() then
						cwKernel:PrintLog(LOGTYPE_MAJOR, {"LogPlayerTakeDamageWith", player:Name(), tostring(math.ceil(damageInfo:GetDamage())), attacker:Name(), cwPly:GetWeaponClass(attacker, "UNKNOWN"), player:Health(), player:Armor()})
					else
						cwKernel:PrintLog(LOGTYPE_MAJOR, {"LogPlayerTakeDamage", player:Name(), tostring(math.ceil(damageInfo:GetDamage())), attacker:GetClass(), player:Health(), player:Armor()})
					end
				end
			end

			damageInfo:SetDamage(0)
		end
	elseif entity:GetClass() == "prop_ragdoll" then
		if damageInfo:GetDamage() >= 20 or damageInfo:IsBulletDamage() then
			if not string.find(entity:GetModel(), "matt") and not string.find(entity:GetModel(), "gib") then
				local matType = util.QuickTrace(entity:GetPos(), entity:GetPos()).MatType

				if matType == MAT_FLESH or matType == MAT_BLOODYFLESH then
					cwKernel:CreateBloodEffects(damageInfo:GetDamagePosition(), 1, entity, damageInfo:GetDamageForce())
				end
			end
		end

		if inflictor:GetClass() == "prop_combine_ball" then
			if not entity.disintegrating then
				cwEntity:Disintegrate(entity, 3, damageInfo:GetDamageForce())
				entity.disintegrating = true
			end
		end
	elseif entity:IsNPC() then
		if attacker:IsPlayer() and IsValid(attacker:GetActiveWeapon()) and cwPly:GetWeaponClass(attacker) == "weapon_crowbar" then
			damageInfo:ScaleDamage(0.25)
		end
	end
end

--[[
	@codebase Server
	@details Called when the death sound for a player should be played.
	@returns {Unknown}
--]]
function Clockwork:PlayerDeathSound(player)
	return true
end

--[[
	@codebase Server
	@details Called when a player attempts to spawn a SWEP.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for class.
	@param {Unknown} Missing description for weapon.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawnSWEP(player, class, weapon)
	if not player:IsSuperAdmin() then
		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player is given a SWEP.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for class.
	@param {Unknown} Missing description for weapon.
	@returns {Unknown}
--]]
function Clockwork:PlayerGiveSWEP(player, class, weapon)
	if not player:IsSuperAdmin() then
		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when attempts to spawn a SENT.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for class.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawnSENT(player, class)
	if not player:IsSuperAdmin() then
		return false
	else
		return true
	end
end

--[[
	@codebase Server
	@details Called when a player presses a key.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for key.
	@returns {Unknown}
--]]
function Clockwork:KeyPress(player, key)
	if key == IN_USE then
		local trace = player:GetEyeTraceNoCursor()

		if IsValid(trace.Entity) and trace.HitPos:Distance(player:GetShootPos()) <= 192 then
			if cwPlugin:Call("PlayerUse", player, trace.Entity) then
				if cwEntity:IsDoor(trace.Entity) and not trace.Entity:HasSpawnFlags(256) and not trace.Entity:HasSpawnFlags(8192) and not trace.Entity:HasSpawnFlags(32768) then
					if cwPlugin:Call("PlayerCanUseDoor", player, trace.Entity) then
						cwPlugin:Call("PlayerUseDoor", player, trace.Entity)
						cwEntity:OpenDoor(trace.Entity, 0, nil, nil, player:GetPos())
					end
				elseif trace.Entity.UsableInVehicle then
					if player:InVehicle() then
						if trace.Entity.Use then
							trace.Entity:Use(player, player)
							player.cwNextExitVehicle = CurTime() + 1
						end
					end
				end
			end
		end
	elseif key == IN_WALK then
		local velocity = player:GetVelocity():Length()

		if velocity > 0 and not player:KeyDown(IN_SPEED) then
			if player:GetSharedVar("IsJogMode") or not cwConfig:Get("enable_jogging"):Get() then
				player:SetSharedVar("IsJogMode", false)
			else
				player:SetSharedVar("IsJogMode", true)
			end
		elseif velocity == 0 and player:KeyDown(IN_SPEED) then
			if player:Crouching() then
				player:RunCommand("-duck")
			else
				player:RunCommand("+duck")
			end
		end
	elseif key == IN_RELOAD then
		if cwPly:GetWeaponRaised(player, true) then
			player.cwReloadHoldTime = CurTime() + 0.75
		else
			player.cwReloadHoldTime = CurTime() + 0.25
		end
	end
end

--[[
	@codebase Server
	@details Called when a player presses a button down.
	@param {Player} The player that is pressing a button.
	@param {Enum} The button that was pressed.
--]]
function Clockwork:PlayerButtonDown(player, button)
	if button == KEY_B then
		local weapon = player:GetActiveWeapon()

		if cwConfig:Get("quick_raise_enabled"):GetBoolean() then
			local bQuickRaise = cwPlugin:Call("PlayerCanQuickRaise", player, weapon)

			if bQuickRaise then
				cwPly:ToggleWeaponRaised(player)
			end
		end
	else
		numpad.Activate(player, button)
	end
end

--[[
	@codebase Server
	@details Called to determine whether or not a player can quickly raise their weapon by pressing the x button.
	@param {Player} The player that is attempting to quickly raise their weapon.
	@param {Weapon} The player's current active weapon.
--]]
function Clockwork:PlayerCanQuickRaise(player, weapon)
	return true
end

--[[
	@codebase Server
	@details Called when a player releases a key.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for key.
	@returns {Unknown}
--]]
function Clockwork:KeyRelease(player, key)
	if key == IN_RELOAD and player.cwReloadHoldTime then
		player.cwReloadHoldTime = nil
	end
end

--[[
	@codebase Server
	@details A function to setup a player's visibility.
	@param {Unknown} Missing description for player.
	@returns {Unknown}
--]]
function Clockwork:SetupPlayerVisibility(player)
	local ragdollEntity = player:GetRagdollEntity()

	if ragdollEntity then
		AddOriginToPVS(ragdollEntity:GetPos())
	end
end

--[[
	@codebase Server
	@details Called after a player has spawned an NPC.
	@param {Unknown} Missing description for player.
	@param {Unknown} Missing description for npc.
	@returns {Unknown}
--]]
function Clockwork:PlayerSpawnedNPC(ply, npc)
	local faction
	local relation
	local uniqueID = ply:UniqueID()
	STORED_RELATIONS = STORED_RELATIONS or {}
	STORED_RELATIONS[uniqueID] = STORED_RELATIONS[uniqueID] or {}

	for k, v in pairs(player.GetAll()) do
		faction = cwFaction:FindByID(v:GetFaction())
		if not faction then continue end
		relation = faction.entRelationship
		if not istable(relation) then continue end

		for k2, v2 in pairs(relation) do
			if k2 ~= npc:GetClass() then continue end

			if string.lower(v2) == "like" then
				STORED_RELATIONS[uniqueID][k2] = STORED_RELATIONS[uniqueID][k2] or npc:Disposition(v)
				npc:AddEntityRelationship(v, D_LI, 1)
			elseif string.lower(v2) == "fear" then
				STORED_RELATIONS[uniqueID][k2] = STORED_RELATIONS[uniqueID][k2] or npc:Disposition(v)
				npc:AddEntityRelationship(v, D_FR, 1)
			elseif string.lower(v2) == "hate" then
				STORED_RELATIONS[uniqueID][k2] = STORED_RELATIONS[uniqueID][k2] or npc:Disposition(v)
				npc:AddEntityRelationship(v, D_HT, 1)
			else
				ErrorNoHalt("Attempting to add relationship using invalid relation '" .. v2 .. "' towards faction '" .. faction.name .. "'.\r\n")
			end
		end
	end
end

--[[
	@codebase Server
	@details Called when an attribute is progressed to edit the amount it is progressed by.
	@param {Player} The player that has progressed the attribute.
	@param {Table} The attribute table of the attribute being progressed.
	@param {Number} The amount that is being progressed for editing purposes.
--]]
function Clockwork:OnAttributeProgress(ply, attribute, amount)
	amount = amount * cwConfig:Get("scale_attribute_progress"):Get()
end

--[[
	@codebase Server
	@details Called to add ammo types to be checked for and saved.
	@param {Table} The table filled with the current ammo types.
--]]
function Clockwork:AdjustAmmoTypes(ammoTable)
	ammoTable["sniperpenetratedround"] = true
	ammoTable["striderminigun"] = true
	ammoTable["helicoptergun"] = true
	ammoTable["combinecannon"] = true
	ammoTable["smg1_grenade"] = true
	ammoTable["gaussenergy"] = true
	ammoTable["sniperround"] = true
	ammoTable["ar2altfire"] = true
	ammoTable["rpg_round"] = true
	ammoTable["xbowbolt"] = true
	ammoTable["buckshot"] = true
	ammoTable["alyxgun"] = true
	ammoTable["grenade"] = true
	ammoTable["thumper"] = true
	ammoTable["gravity"] = true
	ammoTable["battery"] = true
	ammoTable["pistol"] = true
	ammoTable["slam"] = true
	ammoTable["smg1"] = true
	ammoTable["357"] = true
	ammoTable["ar2"] = true
end

--[[
	@codebase Server
	@details Called after a player uses a command.
	@param {Player} The player that used the commmand.
	@param {Table} The table of the command that is being used.
	@param {Table} The arguments that have been given with the command, if any.
--]]
function Clockwork:PostCommandUsed(player, command, arguments)
end

-- GetTargetRecognises datastream callback.
cwDatastream:Hook("GetTargetRecognises", function(player, data)
	if IsValid(data) and data:IsPlayer() then
		player:SetSharedVar("TargetKnows", cwPly:DoesRecognise(data, player))
	end
end)

-- EntityMenuOption datastream callback.
cwDatastream:Hook("EntityMenuOption", function(player, data)
	local entity = data[1]
	local option = data[2]
	local shootPos = player:GetShootPos()
	local arguments = data[3]
	local curTime = CurTime()

	if IsValid(entity) and type(option) == "string" then
		if entity:NearestPoint(shootPos):Distance(shootPos) <= 80 then
			if cwPlugin:Call("PlayerUse", player, entity) then
				if not player.nextEntityHandle or player.nextEntityHandle <= curTime then
					cwPlugin:Call("EntityHandleMenuOption", player, entity, option, arguments)
					player.nextEntityHandle = curTime + cwConfig:Get("entity_handle_time"):Get()
				else
					cwPly:Notify(player, {"EntityOptionWaitTime"})
				end
			end
		end
	end
end)

-- MenuOption datastream callback.
cwDatastream:Hook("MenuOption", function(player, data)
	local item = data.item
	local option = data.option
	local entity = data.entity
	local shootPos = player:GetShootPos()
	data = data.data

	if type(data) ~= "table" then
		data = {data}
	end

	local itemTable = cwItem:FindInstance(item)

	if itemTable and itemTable:IsInstance() and type(option) == "string" then
		if itemTable.HandleOptions then
			if player:HasItemInstance(itemTable) then
				itemTable:HandleOptions(option, player, data)
			elseif IsValid(entity) and entity:GetClass() == "cw_item" and entity:GetItemTable() == itemTable and entity:NearestPoint(shootPos):Distance(shootPos) <= 80 then
				itemTable:HandleOptions(option, player, data, entity)
			end
		end
	end
end)

-- DataStreamInfoSent datastream callback.
cwDatastream:Hook("DataStreamInfoSent", function(player, data)
	if not player.cwDataStreamInfoSent then
		cwPlugin:Call("PlayerDataStreamInfoSent", player)

		timer.Simple(FrameTime() * 32, function()
			if IsValid(player) then
				cwDatastream:Start(player, "DataStreamed", true)
			end
		end)

		player.cwDataStreamInfoSent = true
	end
end)

-- LocalPlayerCreated datastream callback.
cwDatastream:Hook("LocalPlayerCreated", function(player, data)
	if IsValid(player) and not player:HasConfigInitialized() then
		cwKernel:CreateTimer("SendCfg" .. player:UniqueID(), FrameTime(), 1, function()
			if IsValid(player) then
				cwConfig:Send(player)
			end
		end)
	end
end)

-- InteractCharacter datastream callback.
cwDatastream:Hook("InteractCharacter", function(player, data)
	local characterID = data.characterID
	local action = data.action

	if characterID and action then
		local character = player:GetCharacters()[characterID]

		if character then
			local fault = cwPlugin:Call("PlayerCanInteractCharacter", player, action, character)

			if fault == false or type(fault) == "string" then
				return cwPly:SetCreateFault(fault or "You cannot interact with this character!")
			elseif action == "delete" then
				local wasSuccess, fault = cwPly:DeleteCharacter(player, characterID)

				if not wasSuccess then
					cwPly:SetCreateFault(player, fault)
				end
			elseif action == "use" then
				local wasSuccess, fault = cwPly:UseCharacter(player, characterID)

				if not wasSuccess then
					cwPly:SetCreateFault(player, fault)
				end
			else
				cwPlugin:Call("PlayerSelectCustomCharacterOption", player, action, character)
			end
		end
	end
end)

-- GetQuizStatus datastream callback.
cwDatastream:Hook("GetQuizStatus", function(player, data)
	if cwQuiz:GetCompleted(player) then
		cwDatastream:Start(player, "QuizCompleted", true)
	else
		cwDatastream:Start(player, "QuizCompleted", false)
	end
end)

-- DoorManagement datastream callback.
cwDatastream:Hook("DoorManagement", function(player, data)
	if IsValid(data[1]) and player:GetEyeTraceNoCursor().Entity == data[1] then
		if data[1]:GetPos():Distance(player:GetPos()) <= 192 then
			if data[2] == "Purchase" then
				if not cwEntity:GetOwner(data[1]) then
					if hook.Call("PlayerCanOwnDoor", Clockwork, player, data[1]) then
						local doors = cwPly:GetDoorCount(player)

						if doors == cwConfig:Get("max_doors"):Get() then
							cwPly:Notify(player, {"CannotPurchaseAnotherDoor"})
						else
							local doorCost = cwConfig:Get("door_cost"):Get()

							if doorCost == 0 or cwPly:CanAfford(player, doorCost) then
								local doorName = cwEntity:GetDoorName(data[1])

								if doorName == "false" or doorName == "hidden" or doorName == "" then
									doorName = "Door"
								end

								if doorCost > 0 then
									cwPly:GiveCash(player, -doorCost, doorName)
								end

								cwPly:GiveDoor(player, data[1])
							else
								local amount = doorCost - player:GetCash()
								player:NotifyMissingCash(amount)
							end
						end
					end
				end
			elseif data[2] == "Access" then
				if cwPly:HasDoorAccess(player, data[1], DOOR_ACCESS_COMPLETE) then
					if IsValid(data[3]) and data[3] ~= player and data[3] ~= cwEntity:GetOwner(data[1]) then
						if data[4] == DOOR_ACCESS_COMPLETE then
							if cwPly:HasDoorAccess(data[3], data[1], DOOR_ACCESS_COMPLETE) then
								cwPly:GiveDoorAccess(data[3], data[1], DOOR_ACCESS_BASIC)
							else
								cwPly:GiveDoorAccess(data[3], data[1], DOOR_ACCESS_COMPLETE)
							end
						elseif data[4] == DOOR_ACCESS_BASIC then
							if cwPly:HasDoorAccess(data[3], data[1], DOOR_ACCESS_BASIC) then
								cwPly:TakeDoorAccess(data[3], data[1])
							else
								cwPly:GiveDoorAccess(data[3], data[1], DOOR_ACCESS_BASIC)
							end
						end

						if cwPly:HasDoorAccess(data[3], data[1], DOOR_ACCESS_COMPLETE) then
							cwDatastream:Start(player, "DoorAccess", {data[3], DOOR_ACCESS_COMPLETE})
						elseif cwPly:HasDoorAccess(data[3], data[1], DOOR_ACCESS_BASIC) then
							cwDatastream:Start(player, "DoorAccess", {data[3], DOOR_ACCESS_BASIC})
						else
							cwDatastream:Start(player, "DoorAccess", {data[3]})
						end
					end
				end
			elseif data[2] == "Unshare" then
				if cwEntity:IsDoorParent(data[1]) then
					if data[3] == "Text" then
						cwDatastream:Start(player, "SetSharedText", false)
						data[1].cwDoorSharedTxt = nil
					else
						cwDatastream:Start(player, "SetSharedAccess", false)
						data[1].cwDoorSharedAxs = nil
					end
				end
			elseif data[2] == "Share" then
				if cwEntity:IsDoorParent(data[1]) then
					if data[3] == "Text" then
						cwDatastream:Start(player, "SetSharedText", true)
						data[1].cwDoorSharedTxt = true
					else
						cwDatastream:Start(player, "SetSharedAccess", true)
						data[1].cwDoorSharedAxs = true
					end
				end
			elseif data[2] == "Text" and data[3] ~= "" then
				if cwPly:HasDoorAccess(player, data[1], DOOR_ACCESS_COMPLETE) then
					if not string.find(string.gsub(string.lower(data[3]), "%s", ""), "thisdoorcanbepurchased") and string.find(data[3], "%w") then
						cwEntity:SetDoorText(data[1], string.utf8sub(data[3], 1, 32))
					end
				end
			elseif data[2] == "Sell" then
				if cwEntity:GetOwner(data[1]) == player then
					if not cwEntity:IsDoorUnsellable(data[1]) then
						cwPly:TakeDoor(player, data[1])
					end
				end
			end
		end
	end
end)

-- CreateCharacter datastream callback.
cwDatastream:Hook("CreateCharacter", function(player, data)
	cwPly:CreateCharacterFromData(player, data)
end)

-- RecogniseOption datastream callback.
cwDatastream:Hook("RecogniseOption", function(player, data)
	local recogniseData = data

	if cwConfig:Get("recognise_system"):Get() then
		if type(recogniseData) == "string" then
			local playSound = false

			if recogniseData == "look" then
				local target = player:GetEyeTraceNoCursor().Entity

				if IsValid(target) and target:HasInitialized() and not cwPly:IsNoClipping(target) and target ~= player then
					cwPly:SetRecognises(target, player, RECOGNISE_SAVE)
					playSound = true
				end
			else
				local position = player:GetPos()
				local plyTable = _player.GetAll()
				local talkRadius = cwConfig:Get("talk_radius"):Get()

				for k, v in pairs(plyTable) do
					if v:HasInitialized() and player ~= v then
						if not cwPly:IsNoClipping(v) then
							local distance = v:GetPos():Distance(position)
							local recognise = false

							if recogniseData == "whisper" then
								if distance <= math.min(talkRadius / 3, 80) then
									recognise = true
								end
							elseif recogniseData == "yell" then
								if distance <= talkRadius * 2 then
									recognise = true
								end
							elseif recogniseData == "talk" then
								if distance <= talkRadius then
									recognise = true
								end
							end

							if recognise then
								cwPly:SetRecognises(v, player, RECOGNISE_SAVE)

								if not playSound then
									playSound = true
								end
							end
						end
					end
				end
			end

			if playSound then
				cwPly:PlaySound(player, "buttons/button17.wav")
			end
		end
	end
end)

-- QuizCompleted datastream callback.
cwDatastream:Hook("QuizCompleted", function(player, data)
	if not cwQuiz:GetEnabled() then
		cwQuiz:SetCompleted(player, true)

		return
	end

	if player.cwQuizAnswers and not cwQuiz:GetCompleted(player) then
		local questionsAmount = cwQuiz:GetQuestionsAmount()
		local correctAnswers = 0
		local quizQuestions = cwQuiz:GetQuestions()

		for k, v in pairs(quizQuestions) do
			if player.cwQuizAnswers[k] then
				if cwQuiz:IsAnswerCorrect(k, player.cwQuizAnswers[k]) then
					correctAnswers = correctAnswers + 1
				end
			end
		end

		if correctAnswers < math.Round(questionsAmount * (cwQuiz:GetPercentage() / 100)) then
			cwQuiz:CallKickCallback(player, correctAnswers)
		else
			cwQuiz:SetCompleted(player, true)
		end
	end
end)

-- UnequipItem datastream callback.
cwDatastream:Hook("UnequipItem", function(player, data)
	local arguments = data[3]
	local uniqueID = data[1]
	local itemID = data[2]
	if not player:Alive() or player:IsRagdolled() then return end
	local itemTable = player:FindItemByID(uniqueID, itemID)

	if not itemTable then
		itemTable = player:FindWeaponItemByID(uniqueID, itemID)
	end

	if itemTable and itemTable.OnPlayerUnequipped and itemTable.HasPlayerEquipped then
		if itemTable:HasPlayerEquipped(player, arguments) then
			itemTable:OnPlayerUnequipped(player, arguments)
			player:RebuildInventory()
		end
	end
end)

-- QuizAnswer datastream callback.
cwDatastream:Hook("QuizAnswer", function(player, data)
	if not player.cwQuizAnswers then
		player.cwQuizAnswers = {}
	end

	local question = data[1]
	local answer = data[2]

	if cwQuiz:GetQuestion(question) then
		player.cwQuizAnswers[question] = answer
	end
end)

AddCSLuaFile("meta/cl_player.lua")
AddCSLuaFile("meta/cl_entity.lua")
AddCSLuaFile("meta/cl_weapon.lua")
Clockwork.kernel:IncludePrefixed("meta/sv_entity.lua")
Clockwork.kernel:IncludePrefixed("meta/sv_player.lua")
concommand.Add("gm_save", function(ply) end)

concommand.Add("cwStatus", function(ply, command, arguments)
	local plyTable = player.GetAll()

	if IsValid(ply) then
		if cwPly:IsAdmin(ply) then
			ply:PrintMessage(2, "# User ID | Name | Steam Name | Steam ID | IP Address")

			for k, v in pairs(plyTable) do
				if v:HasInitialized() then
					local status = cwPlugin:Call("PlayerCanSeeStatus", player, v)

					if status then
						ply:PrintMessage(2, status)
					end
				end
			end
		else
			ply:PrintMessage(2, "You do not have access to this command, " .. player:Name() .. ".")
		end
	else
		print("# User ID | Name | Steam Name | Steam ID | IP Address")

		for k, v in pairs(plyTable) do
			if v:HasInitialized() then
				print("# " .. v:UserID() .. " | " .. v:Name() .. " | " .. v:SteamName() .. " | " .. v:SteamID() .. " | " .. v:IPAddress())
			end
		end
	end
end)

concommand.Add("cwDeathCode", function(player, command, arguments)
	if player.cwDeathCodeIdx then
		if arguments and tonumber(arguments[1]) == player.cwDeathCodeIdx then
			player.cwDeathCodeAuth = true
		end
	end
end)

function Clockwork:PlayerSay(player, text, bPublic)
	if CLOCKWORK_PLAYERSAY_OVERRIDE then
		return text
	else
		return ""
	end
end

function ClockworkPlayerSay(player, text)
	CLOCKWORK_PLAYERSAY_OVERRIDE = true
	text = hook.Call("PlayerSay", Clockwork, player, text, true)
	CLOCKWORK_PLAYERSAY_OVERRIDE = nil
	if text == "" then return end
	local maxChatLength = Clockwork.config:Get("max_chat_length"):Get()
	local prefix = Clockwork.config:Get("command_prefix"):Get()
	local curTime = CurTime()

	if string.len(text) >= maxChatLength then
		text = string.sub(text, 0, maxChatLength)
	end

	if string.sub(text, 1, 2) == "//" then
		text = string.Trim(string.sub(text, 3))

		if text ~= "" then
			if Clockwork.plugin:Call("PlayerCanSayOOC", player, text) then
				if not player.cwNextTalkOOC or curTime > player.cwNextTalkOOC or player:IsAdmin() then
					Clockwork.kernel:ServerLog("[OOC] " .. player:Name() .. ": " .. text)
					Clockwork.chatBox:Add(nil, player, "ooc", text)
					player.cwNextTalkOOC = curTime + Clockwork.config:Get("ooc_interval"):Get()
				else
					Clockwork.player:Notify(player, "You cannot cannot talk out-of-character for another " .. math.ceil(player.cwNextTalkOOC - CurTime()) .. " second(s)!")

					return
				end
			end
		end
	elseif string.sub(text, 1, 3) == ".//" or string.sub(text, 1, 2) == "[[" then
		if string.sub(text, 1, 3) == ".//" then
			text = string.Trim(string.sub(text, 4))
		else
			text = string.Trim(string.sub(text, 3))
		end

		if text ~= "" then
			if Clockwork.plugin:Call("PlayerCanSayLOOC", player, text) then
				Clockwork.kernel:ServerLog("[LOOC] " .. player:Name() .. ": " .. text)
				Clockwork.chatBox:AddInRadius(player, "looc", text, player:GetPos(), Clockwork.config:Get("talk_radius"):Get())
			end
		end
	elseif string.sub(text, 1, 1) == prefix then
		local prefixLength = string.len(prefix)
		local arguments = Clockwork.kernel:ExplodeByTags(text, " ", "\"", "\"", true)
		local command = string.sub(arguments[1], prefixLength + 1)

		if Clockwork.command.stored[command] and Clockwork.command.stored[command].arguments < 2 and not Clockwork.command.stored[command].optionalArguments then
			text = string.sub(text, string.len(command) + prefixLength + 2)

			if text ~= "" then
				arguments = {command, text}
			else
				arguments = {command}
			end
		else
			arguments[1] = command
		end

		Clockwork.command:ConsoleCommand(player, "cwCmd", arguments)
	elseif Clockwork.plugin:Call("PlayerCanSayIC", player, text) then
		Clockwork.chatBox:AddInRadius(player, "ic", text, player:GetPos(), Clockwork.config:Get("talk_radius"):Get())

		if Clockwork.player:GetDeathCode(player, true) then
			Clockwork.player:UseDeathCode(player, nil, {text})
		end
	end

	if Clockwork.player:GetDeathCode(player) then
		Clockwork.player:TakeDeathCode(player)
	end
end

Clockwork.datastream:Hook("PlayerSay", function(player, data)
	if type(data) == "string" then
		ClockworkPlayerSay(player, data)
	end
end)

local playerMeta = FindMetaTable("Player")

-- Called when a player's character data has changed.
function Clockwork:PlayerCharacterDataChanged(player, key, oldValue, newValue)
	self.player:UpdateCharacterData(player, key, newValue)
end

-- Called when a player's data has changed.
function Clockwork:PlayerDataChanged(player, key, oldValue, newValue)
	self.player:UpdatePlayerData(player, key, newValue)
end

-- A function to set a player's character data.
function playerMeta:SetCharacterData(key, value, bFromBase)
	local character = self:GetCharacter()
	if not character then return end

	if bFromBase then
		key = Clockwork.kernel:SetCamelCase(key, true)

		if character[key] ~= nil then
			local oldValue = character[key]
			character[key] = value
			Clockwork.plugin:Call("PlayerCharacterDataChanged", self, key, oldValue, value)
		end
	else
		local oldValue = character.data[key]
		character.data[key] = value

		if value ~= oldValue then
			Clockwork.plugin:Call("PlayerCharacterDataChanged", self, key, oldValue, value)
		end
	end
end

-- A function to set a player's data.
function playerMeta:SetData(key, value)
	if self.cwData then
		local oldValue = self.cwData[key]
		self.cwData[key] = value

		if value ~= oldValue then
			Clockwork.plugin:Call("PlayerDataChanged", self, key, oldValue, value)
		end
	end
end
