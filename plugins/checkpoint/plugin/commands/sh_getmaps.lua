
local COMMAND = Clockwork.command:New("GetMaps");
COMMAND.tip = "Prints all maps on the server in console.";
COMMAND.access = "o";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.player:Notify(player, "A list of all maps has been printed in your console.");
	
	local maps = file.Find("maps/*.bsp", "GAME");
	Clockwork.datastream:Start(player, "cp_map_list", maps);
end;

if (CLIENT) then
	Clockwork.datastream:Hook("cp_map_list", function(data)
		MsgC(Clockwork.option:GetKey("cp_color"), "Map list: ", "\n");

		table.sort(data);
		for _, v in ipairs(data) do
			print("    "..v:lower());
		end;
	end);
end;

COMMAND:Register();