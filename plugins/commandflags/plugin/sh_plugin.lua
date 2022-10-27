local PLUGIN = PLUGIN;

Clockwork.flag:Add("L", "Player Event Usage", "Allows players access to the /event command, and /eventlocal command.")
Clockwork.flag:Add("T", "Player Observer Usage", "Allows players access to the observer command.")
Clockwork.flag:Add("M", "Player Model Setting", "Allows players the ability to set models.")
Clockwork.flag:Add("E", "Player Name Setting", "Allows players the ability to set names.")

function PLUGIN:ClockworkInitialized()
	local COMMAND = Clockwork.command:FindByID("Event");
	COMMAND.access = "b";

	function COMMAND:OnRun(player, arguments)
		if (Clockwork.player:IsAdmin(player) or Clockwork.player:HasFlags(player,"L")) then
			Clockwork.chatBox:Add(nil, player, "event",  table.concat(arguments, " "));
		else
			Clockwork.player:Notify(player, "You do not have access to this command, "..player:Name()..".");
		end;
	end;

	local COMMAND = Clockwork.command:FindByID("Observer");
	COMMAND.access = "b";

	function COMMAND:OnRun(player, arguments)
		if (Clockwork.player:IsAdmin(player) or Clockwork.player:HasFlags(player, "T")) then
			if (player:Alive() and !player:IsRagdolled() and !player.cwObserverReset) then
				if (player:GetMoveType(player) == MOVETYPE_NOCLIP) then
					cwObserverMode:MakePlayerExitObserverMode(player);
				else
					cwObserverMode:MakePlayerEnterObserverMode(player);
				end;
			end;
		else
			Clockwork.player:Notify(player, "You do not have access to this command, "..player:Name()..".")
		end;	
	end;
	
	local COMMAND = Clockwork.command:FindByID("EventLocal");
	COMMAND.access = "b";

	function COMMAND:OnRun(player, arguments)
		if (Clockwork.player:IsAdmin(player) or Clockwork.player:HasFlags(player, "L")) then
			Clockwork.chatBox:AddInRadius(player, "localevent",  table.concat(arguments, " "), player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 4);
		end;
	end;

	local COMMAND = Clockwork.command:FindByID("CharSetModel")
	COMMAND.access = "b"

	function COMMAND:OnRun(player, arguments)
		if (Clockwork.player:IsAdmin(player) or Clockwork.player:HasFlags(player, "M")) then
			local target = Clockwork.player:FindByID(arguments[1])
		
			if (target) then
				local model = table.concat(arguments, " ", 2);
				
				target:SetCharacterData("Model", model, true);
				target:SetModel(model);
				
				Clockwork.player:NotifyAll(player:Name().." set "..target:Name().."'s model to "..model..".");
			else
				Clockwork.player:Notify(player, L(player, "NotValidCharacter", arguments[1]));
			end;
		end;
	end;

	local COMMAND = Clockwork.command:FindByID("CharSetName")
	COMMAND.access = "b"

	function COMMAND:OnRun(player, arguments)
		if (Clockwork.player:IsAdmin(player) or Clockwork.player:HasFlags(player, "E")) then
			local target = Clockwork.player:FindByID(arguments[1])
			if (target) then
				local name = table.concat(arguments, " ", 2);

				Clockwork.player:NotifyAll(player:Name().." set "..target:Name().."'s name to "..name..".");

				Clockwork.player:SetName(target, name);
			else
				Clockwork.player:Notify(player, L(player, "NotValidCharacter", arguments[1]));
			end;
		end;
	end;
end;