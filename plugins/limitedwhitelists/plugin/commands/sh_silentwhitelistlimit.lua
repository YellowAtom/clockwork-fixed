local COMMAND = Clockwork.command:New("SilentWhitelistLimit");
COMMAND.tip = "Allows you to alter a player's character limit for a specific faction silently.";
COMMAND.text = "<string Name> <string Faction> <number Limit>";
COMMAND.access = "s";
COMMAND.arguments = 3;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])
	
	if (target) then
		local factionTable = Clockwork.faction:FindByID(arguments[2]);
		
		if (factionTable) then
			local limit = tonumber(arguments[3]);

			if (limit) then
				local whitelistLimits = target:GetData("WhitelistLimits");
				whitelistLimits[factionTable.name] = limit;

				target:SetData("WhitelistLimits", whitelistLimits);
				Clockwork.datastream:Start(target, "WhitelistLimits", whitelistLimits);

				Clockwork.player:Notify(player, "You have silently adjusted "..target:Name().."'s '"..factionTable.name.."' character limit to "..limit..".");
			else
				Clockwork.player:Notify(player, arguments[3].." is an invalid number/amount!");
			end;
		else
			Clockwork.player:Notify(player, arguments[2].." is not a valid faction!");
		end;
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
	end;
end;

COMMAND:Register();