local COMMAND = Clockwork.command:New("StaticAdd")

COMMAND.tip = "Add a static entity at your target position."
COMMAND.access = "o"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = player:GetEyeTraceNoCursor().Entity

	if IsValid(target) then
		if Clockwork.plugin:Call("CanEntityStatic", target) then
			for k, v in pairs(cwStaticEnts.staticEnts) do
				if target == v then
					Clockwork.player:Notify(player, "This entity is already static!")

					return
				end
			end

			cwStaticEnts:SaveEntity(target)
			Clockwork.player:Notify(player, "You have added a static entity.")
		else
			Clockwork.player:Notify(player, "You cannot static this entity!")
		end
	else
		Clockwork.player:Notify(player, "You must look at a valid entity!")
	end
end

COMMAND:Register()
