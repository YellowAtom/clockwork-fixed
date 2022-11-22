local TOOL = Clockwork.tool:New()

TOOL.Name = "Static Add/Remove"
TOOL.UniqueID = "static"
TOOL.Category = "Clockwork"
TOOL.Desc = "Allows you to save entities permanently on the map."
TOOL.HelpText = "Primary: Static Entity | Secondary: Unstatic Entity"
TOOL.leftClickCMD = "StaticAdd"
TOOL.rightClickCMD = "StaticRemove"

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {
		Text = "Static Add/Remove",
		Description = "Allows you to save entities permanently on the map."
	})

	CPanel:AddControl("Header", {
		Text = "",
		Description = "Updated static plugin by NightAngel."
	})
end

TOOL:Register()
