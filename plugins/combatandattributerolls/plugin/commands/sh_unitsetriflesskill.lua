local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("UnitSetRiflesSkill");
COMMAND.tip = "Set a unit's rifles skill.";
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
		if (Schema:IsPlayerCombineRank( player, {"CpC", "SeC"}, true ) or player:GetFaction() == FACTION_OTA) then
			if (target) then
				if amount <= 16 then
				Clockwork.player:Notify(target, player:Name().." has set your rifles skill to "..amount..".");
				Clockwork.player:Notify(player, "You have set "..target:Name().."'s rifles skill to "..amount..".");
				target:SetCharacterData( "riflesskill", amount )
				else

				Clockwork.player:Notify(player, "You can only set a rifles skill of 16 or lower with this command");
				end;
			else
				Clockwork.player:Notify(player, "You have set your own rifles skill to "..amount..".");
			end;
		else
		Clockwork.player:Notify(player, "You need to be an SeC or higher to use this command.");
		end;
	else
		Clockwork.player:Notify(player, "You are not the Combine!");	
	end;
end;

COMMAND:Register();
