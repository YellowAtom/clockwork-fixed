local COMMAND = Clockwork.command:New("EntDisableGrab");

COMMAND.tip = "Prevents the entity you're looking at from being grabbed with the physgun.";
COMMAND.arguments = 0;
COMMAND.access = "s";

function COMMAND:OnRun(player, arguments)
	local ent = player:GetEyeTraceNoCursor().Entity;
	
	if (ent) then
		NoGrabEnts[#NoGrabEnts + 1] = ent;
		Clockwork.player:Notify(player, "The entity is no longer grabbable with the physgun.");
	else
		Clockwork.player:Notify(player, "You need to look at an entity.");
	end;
end;

COMMAND:Register()