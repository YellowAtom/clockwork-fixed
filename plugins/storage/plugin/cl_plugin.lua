
Clockwork.datastream:Hook("StorageMessage", function(data)
	local entity = data.entity
	local message = data.message

	if IsValid(entity) then
		entity.cwMessage = message
	end
end)

Clockwork.datastream:Hook("ContainerPassword", function(data)
	local entity = data

	Derma_StringRequest("Password", "What is the password for this container?", nil, function(text)
		Clockwork.datastream:Start("ContainerPassword", {text, entity})
	end)
end)
