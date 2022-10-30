PLUGIN:SetGlobalAlias("cwPersistDoors")

function cwPersistDoors:GetDoors()
	local doors = {}

	for k,v in pairs(ents.GetAll()) do
		if Clockwork.entity:IsDoor(v) then
			table.insert(doors, v)
		end
	end

	return doors
end

Clockwork.kernel:IncludePrefixed("cl_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_hooks.lua")