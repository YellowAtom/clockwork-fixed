local Clockwork = Clockwork;
local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("CharDetDesc");
COMMAND.tip = "Change your character's detailed description.";
COMMAND.text = "[No Text]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.datastream:Start( player, "EditDetDesc", { player, player:GetCharacterData("DetailDesc") or "", player:GetCharacterData("PictureDesc") or ""} );
end;

COMMAND:Register();

if (CLIENT) then
	Clockwork.quickmenu:AddCallback("Detailed Description", nil, function()
		local commandTable = Clockwork.command:FindByID("CharDetDesc");
		
		if (commandTable) then
			return {
				toolTip = commandTable.tip,
				Callback = function(option)
					Clockwork.kernel:RunCommand("CharDetDesc");
				end
			};
		else
			return false;
		end;
	end);
end;