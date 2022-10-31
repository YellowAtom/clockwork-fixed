local COMMAND = Clockwork.command:New("CraftBlueprint")

COMMAND.tip = "CmdCraftBlueprint"
COMMAND.text = "CmdCraftBlueprintDesc"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local blueprintTable = Clockwork.crafting:FindByID(arguments[1])
	if not blueprintTable then return false end
	Clockwork.crafting:Craft(player, blueprintTable)
end

COMMAND:Register()
