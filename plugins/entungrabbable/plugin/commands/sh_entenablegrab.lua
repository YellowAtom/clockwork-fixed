local COMMAND = Clockwork.command:New("EntReinstateGrab");

COMMAND.tip = "Reinstates allowance for grabbing the entity you're looking at with a physgun.";
COMMAND.arguments = 0;
COMMAND.access = "s";

function COMMAND:OnRun(player, arguments)
	local ent = player:GetEyeTraceNoCursor().Entity;
	
	if (ent) then
		for k, v in pairs(NoGrabEnts) do
			if (v == ent) then
				NoGrabEnts[k] = nil;
				Clockwork.player:Notify(player, "You have reinstated the grabbing of this entity with the physgun.");
				break;
			end;
		end;
	else
		Clockwork.player:Notify(player, "You need to look at an entity.");
	end;
end;

COMMAND:Register();