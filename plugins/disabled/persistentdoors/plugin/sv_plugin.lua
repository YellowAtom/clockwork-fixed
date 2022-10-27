Clockwork.config:Add("perma_door_owners", false, true, nil, nil, nil, true)
Clockwork.config:Add("keep_doors_on_death", false, true)

function cwPersistDoors:InitPostEntity()
	self:LoadDoorInfo()
end

function cwPersistDoors:PostSaveData()
	self:SaveDoorInfo()
end

function cwPersistDoors:LoadDoorInfo()
	local door_info = Clockwork.kernel:RestoreSchemaData("plugins/door_info/"..game.GetMap())

	for k,v in pairs(self:GetDoors()) do
		local index = v:EntIndex()
		v.sub_text = door_info[index].text

		if door_info[index].owner_id ~= "N/A" and door_info[index].owner_name ~= "N/A" then
			v.owner_id = door_info[index].owner_id
			v.owner_name = door_info[index].owner_name

			if Clockwork.config:Get("perma_door_owners"):Get() then
				Clockwork.entity:SetDoorText(v, door_info[index].text)
				Clockwork.entity:SetDoorUnownable(v, true)
				v:Fire("lock", "", 1)
			end
		end
	end
end

function cwPersistDoors:SaveDoorInfo()
	local door_info = {}

	for k,v in pairs(self:GetDoors()) do
		local owner = Clockwork.entity:GetOwner(v)
		local owner_id = "N/A"
		local owner_name = "N/A"
		if IsValid(owner) and type(owner) == "Player" then
			owner_id = owner:SteamID()
			owner_name = owner:Name()
		elseif v.owner_id and v.owner_name then
			owner_id = v.owner_id
			owner_name = v.owner_name
		end

		door_info[v:EntIndex()] = {
			owner_id = owner_id,
			owner_name = owner_name,
			text = Clockwork.entity:GetDoorText(v)
		}
	end

	Clockwork.kernel:SaveSchemaData("plugins/door_info/"..game.GetMap(), door_info)
end