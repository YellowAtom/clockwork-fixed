local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("charSetVortessenceMastery");
COMMAND.tip = "Set a player's Vortessence Mastery.";
COMMAND.text = "<string Name> <number Amount>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID( arguments[1] )
	local amount = arguments[2];
	
	if (!amount) then
		amount = 0;
	end;
	
		if (target) then
			target:SetCharacterData( "vortessencemastery", amount )
			if ( player != target )	then
				if amount <= 20 then
				Clockwork.player:Notify(target, player:Name().." has set your vortessence mastery to "..amount..".");
				Clockwork.player:Notify(player, "You have set "..target:Name().."'s vortessence mastery to "..amount..".");
				else
					Clockwork.player:Notify(player, "The maximum skill is 20!");	
				end;
			else
				Clockwork.player:Notify(player, "You have set your own vortessence mastery to "..amount..".");
			end;
		else
			Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
		end;
end;

COMMAND:Register();