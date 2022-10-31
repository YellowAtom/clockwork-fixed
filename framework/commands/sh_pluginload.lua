local COMMAND = Clockwork.command:New("PluginLoad")

COMMAND.tip = "CmdPluginLoad"
COMMAND.text = "CmdPluginLoadDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "s"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local plugin = Clockwork.plugin:FindByID(arguments[1])

	if not plugin then
		Clockwork.player:Notify(player, {"PluginNotValid"})

		return
	end

	local unloadTable = Clockwork.command:FindByID("PluginLoad")
	local loadTable = Clockwork.command:FindByID("PluginLoad")

	if not Clockwork.plugin:IsDisabled(plugin.name) then
		local wasSuccess = Clockwork.plugin:SetUnloaded(plugin.name, false)
		local recipients = {}

		if wasSuccess then
			Clockwork.player:NotifyAll({"PlayerLoadedPlugin", player:Name(), plugin.name})

			for k, v in pairs(cwPlayer.GetAll()) do
				if v:HasInitialized() then
					if Clockwork.player:HasFlags(v, loadTable.access) or Clockwork.player:HasFlags(v, unloadTable.access) then
						recipients[#recipients + 1] = v
					end
				end
			end

			if #recipients > 0 then
				Clockwork.datastream:Start(recipients, "SystemPluginSet", {plugin.name, false})
			end
		else
			Clockwork.player:Notify(player, {"PluginCouldNotBeLoaded"})
		end
	else
		Clockwork.player:Notify(player, {"PluginDependsOnAnother"})
	end
end

COMMAND:Register()
