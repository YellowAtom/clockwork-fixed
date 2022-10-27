
local COMMAND = Clockwork.command:New("FreezeProps");
COMMAND.tip = "Freezes all props.";
COMMAND.access = "o";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local props = ents.FindByClass("prop_physics");
	local counter = 0;

	for k, prop in pairs(props) do
		local physicsObject = prop:GetPhysicsObject();
		if (physicsObject and physicsObject:IsMotionEnabled()) then
			physicsObject:EnableMotion(false);
			counter = counter + 1;
		end;
	end;

	player:CPNotify("You have frozen "..counter.." props.", "lock");
end;

COMMAND:Register();