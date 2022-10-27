
local COMMAND = Clockwork.command:New("ClearNPCs");
COMMAND.tip = "Clears all NPC's of the given class (or all classes if none is given). Supports wildcard usage.";
COMMAND.text = "[str Class]";
COMMAND.access = "a";
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local class = arguments[1];

	if (!class) then
		local ents = ents.GetAll();
		local counter = 0;

		for k, ent in pairs(ents) do
			if (ent.IsNPC and ent:IsNPC()) then
				ent:Remove();
				counter = counter + 1;
			end;
		end;

		player:CPNotify("You have removed all "..counter.." NPC's.", "bin");
	else
		local npcs = ents.FindByClass(class);
		local counter = 0;

		for k, npc in pairs(npcs) do
			npc:Remove();
			counter = counter + 1;
		end;

		player:CPNotify("You ahve removed all "..counter.." "..class..".", "bin");
	end;
end;

COMMAND:Register();