local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("Sleep");
COMMAND.tip = "Shhh! Sasha is sleeping.";
COMMAND.text = "<none>";
COMMAND.flags = CMD_DEFAULT;


-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (tonumber(player:GetCharacterData("sleep")) >= 60) then
		Clockwork.player:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, 60);
		player:SetCharacterData( "sleep", math.Clamp(player:GetCharacterData("sleep") - 50, 0, 100) )
	else
		Clockwork.player:Notify(player, "You do not need to sleep yet.");
	end;
end;

COMMAND:Register();