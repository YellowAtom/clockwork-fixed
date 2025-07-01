local COMMAND = Clockwork.command:New("AnnounceLocal")

COMMAND.tip = "Make a local announcement to nearby players."
COMMAND.text = "<string Text>"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local text = table.concat(arguments, " ")
	local range = Clockwork.config:Get("talk_radius"):Get() * 4
	
	Clockwork.player:NotifyInRadius("(LOCAL) "..text, nil, player:GetPos(), range)
end

COMMAND:Register()
