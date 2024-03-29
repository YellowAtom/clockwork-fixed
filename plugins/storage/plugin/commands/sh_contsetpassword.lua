local COMMAND = Clockwork.command:New("ContSetPassword")

COMMAND.tip = "Set a container's password."
COMMAND.text = "<string Pass>"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local trace = player:GetEyeTraceNoCursor()

	if IsValid(trace.Entity) then
		if Clockwork.entity:IsPhysicsEntity(trace.Entity) then
			local model = string.lower(trace.Entity:GetModel())

			if cwStorage.containerList[model] then
				if not trace.Entity.inventory then
					cwStorage.storage[trace.Entity] = trace.Entity
					trace.Entity.inventory = {}
				end

				trace.Entity.cwPassword = table.concat(arguments, " ")
				Clockwork.player:Notify(player, "This container's password has been set to '" .. trace.Entity.cwPassword .. "'.")
			else
				Clockwork.player:Notify(player, "This is not a valid container!")
			end
		else
			Clockwork.player:Notify(player, "This is not a valid container!")
		end
	else
		Clockwork.player:Notify(player, "This is not a valid container!")
	end
end

COMMAND:Register()
