local COMMAND = Clockwork.command:New("SetNPCHealth");
COMMAND.tip = "Set the health of the NPC you are looking at.";
COMMAND.text = "<number Health>";
COMMAND.access = "s";
COMMAND.arguments = 1;

function COMMAND:OnRun(player, arguments)
	if (tonumber(arguments[1])) then
		local entity = player:GetEyeTraceNoCursor().Entity;
		local health = math.Clamp(arguments[1], 0, 99999);

		if (entity and IsValid(entity) and entity:IsNPC()) then
			entity:SetHealth(health);
			Clockwork.player:Notify(player, "You have set this NPC's health to "..health..".");
		else
			Clockwork.player:Notify(player, "Invalid target!");
		end;
	else
		Clockwork.player:Notify(player, "You must enter a valid number!");
	end;
end;

COMMAND:Register();
