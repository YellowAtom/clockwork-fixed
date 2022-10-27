local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("UnitSetSubmachinegunsSkill");
COMMAND.tip = "Set a unit's submachine guns skill.";
COMMAND.text = "<string Name> <number Amount>";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])
	local initialamount = arguments[2];
	local amount = tonumber( initialamount )

	if (!amount) then
		amount = 0;
	end;

	if (Schema:PlayerIsCombine(player)) then
		if (Schema:IsPlayerCombineRank( player, {"SCN", "OfC", "EpU", "DvL", "CmD", "CpC", "SeC", "RL", "RnL"}, true ) or player:GetFaction() == FACTION_OTA) then
			if (target) then
				if amount <= 16 then
				Clockwork.player:Notify(target, player:Name().." has set your submachine guns skill to "..amount..".");
				Clockwork.player:Notify(player, "You have set "..target:Name().."'s submachine guns skill to "..amount..".");
				target:SetCharacterData( "ballisticsskill", amount )
				else

				Clockwork.player:Notify(player, "You can only set a submachine guns skill of 16 or lower with this command");
				end;
			else
				Clockwork.player:Notify(player, "You have set your own submachine guns skill to "..amount..".");
			end;
		else
		Clockwork.player:Notify(player, "You need to be a Rank Leader or higher to use this command.");
		end;
	else
		Clockwork.player:Notify(player, "You are not the Combine!");	
	end;
end;

COMMAND:Register();
