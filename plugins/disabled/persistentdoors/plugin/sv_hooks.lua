function cwPersistDoors:PlayerCharacterLoaded(player)
	for k,v in pairs(self:GetDoors()) do
		if v.owner_id and v.owner_name then
			if player:SteamID() == v.owner_id and player:Name() == v.owner_name then
				if Clockwork.config:Get("perma_door_owners"):Get() then
					Clockwork.entity:SetDoorUnownable(v, false)
					Clockwork.player:GiveDoor(player, v)
					Clockwork.entity:SetDoorText(v, v.sub_text)
					v:Fire("lock", "", 1)
				else
					if not IsValid(Clockwork.entity:GetOwner(v)) then
						Clockwork.player:GiveDoor(player, v)
						Clockwork.entity:SetDoorText(v, v.sub_text)
					end
				end
			end
		end
	end
end

function cwPersistDoors:PlayerCharacterUnloaded(player)
	for k,v in pairs(self:GetDoors()) do
		if v.owner_id and v.owner_name then
			if player:SteamID() == v.owner_id and player:Name() == v.owner_name then
				if Clockwork.config:Get("perma_door_owners"):Get() then
					Clockwork.entity:SetDoorUnownable(v, true)
					Clockwork.entity:SetDoorText(v, v.sub_text)
					v:Fire("lock", "", 1)
				end
			end
		end
	end
end

function cwPersistDoors:PlayerDeath(player)
	if not Clockwork.config:Get("keep_doors_on_death"):Get() then
		for k,v in pairs(self:GetDoors()) do
			if Clockwork.entity:GetOwner(v) == player then
				Clockwork.player:TakeDoor(player, v)
			end
		end
	end
end