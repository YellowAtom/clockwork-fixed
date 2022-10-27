local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("charSetThirst");
COMMAND.tip = "Set a player's Thirst Level.";
COMMAND.text = "<string Name> <number Amount>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID( arguments[1] )
	local amount = arguments[2];
	
	if (!amount) then
		amount = 100;
	end;
	
		if (target) then
			target:SetCharacterData( "thirst", amount )
			if ( player != target )	then
				Clockwork.player:Notify(target, player:Name().." has set your thirst to "..amount..".");
				Clockwork.player:Notify(player, "You have set "..target:Name().."'s thirst to "..amount..".");
			else
				Clockwork.player:Notify(player, "You have set your own thirst to "..amount..".");
			end;
		else
			Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
		end;
end;

COMMAND:Register();