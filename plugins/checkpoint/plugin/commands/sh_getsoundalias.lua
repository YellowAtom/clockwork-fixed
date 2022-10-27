
local COMMAND = Clockwork.command:New("GetSoundAliasList");
COMMAND.tip = "Prints all sound alias list in your console.";
COMMAND.access = "a";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.player:Notify(player, "A list of all sound aliases has been printed in your console.");
	Clockwork.datastream:Start(player, "cp_sound_alias_list", {true});
end;

if (CLIENT) then
	Clockwork.datastream:Hook("cp_sound_alias_list", function(data)
		local color = Clockwork.option:GetKey("cp_color");
		MsgC(color, "Sound alias list: ", "\n");

		local list = Clockwork.option:GetKey("sound_alias");
		for alias, sound in SortedPairs(list) do
			MsgC(color, alias, "\n");

			if (type(sound) == "table") then
				print("    "..table.concat(sound, "; "));
			else
				print("    "..sound);
			end;
		end;
	end);
end;

COMMAND:Register();