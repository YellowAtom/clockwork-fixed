
local function SaveSpawn(player)
	if Clockwork.config:Get("spawn_where_left"):Get() and player:Alive() then
		local position = player:GetPos()

		local posTable = {
			map = game.GetMap(),
			x = position.x,
			y = position.y,
			z = position.z
		}

		player:SetCharacterData("SpawnPoint", posTable)
	end
end

function cwSpawnSaver:PlayerSaveData(player)
	SaveSpawn(player)
end

-- Called when a player's character has unloaded.
function cwSpawnSaver:PlayerCharacterUnloaded(player)
	SaveSpawn(player)
end

function cwSpawnSaver:PlayerDeath(player)
	player:SetCharacterData("SpawnPoint", nil)
end

-- Called just after a player spawns.
function cwSpawnSaver:PostPlayerSpawn(player, bLightSpawn, bChangeClass, bFirstSpawn)
	if not bLightSpawn then
		local spawnPos = player:GetCharacterData("SpawnPoint")

		if spawnPos and Clockwork.config:Get("spawn_where_left"):Get() then
			if spawnPos.map == game.GetMap() then
				player:SetPos(Vector(spawnPos.x, spawnPos.y, spawnPos.z))
				player:SetCharacterData("SpawnPoint", nil)
			end
		end
	end
end
