local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("charSetHunger");
COMMAND.tip = "Set a player's Hunger Level.";
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
			target:SetCharacterData( "hunger", amount )
			if ( player != target )	then
				Clockwork.player:Notify(target, player:Name().." has set your hunger to "..amount..".");
				Clockwork.player:Notify(player, "You have set "..target:Name().."'s hunger to "..amount..".");
			else
				Clockwork.player:Notify(player, "You have set your own Hunger to "..amount..".");
			end;
		else
			Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
		end;
end;

COMMAND:Register();