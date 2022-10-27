local COMMAND = Clockwork.command:New("PianoAdd");
COMMAND.tip = "Add a piano at your target position.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "a";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local trace = player:GetEyeTraceNoCursor();
	local entity = ents.Create("gmt_instrument_piano");
	
	entity:SetPos(trace.HitPos + Vector(0, 0, 20));
	entity:Spawn();
	
	if ( IsValid(entity) ) then
		entity:SetAngles(Angle(0, player:EyeAngles().yaw + 180, 0));
		
		Clockwork.player:Notify(player, "You have added a piano!");
	end;
end;

COMMAND:Register();