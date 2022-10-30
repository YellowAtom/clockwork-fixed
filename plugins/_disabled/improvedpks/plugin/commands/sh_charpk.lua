--[[
	Plugin made by Ghost for Undetermined Gaming
	CharPK Command
--]]

local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("CharPK");
COMMAND.tip = "Permanently kill a character.";
COMMAND.text = "<string Name>";
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID( arguments[1] )
	
	if (target) then
		if (!target:GetCharacterData("permakilled")) then
			PLUGIN:PKPlayer(target, target:GetRagdollEntity());
		else
			Clockwork.player:Notify(player, "This character is already permanently killed!");
			return;
		end;
		
		Clockwork.player:NotifyAll(player:Name().." permanently killed the character '"..target:Name().."'.");
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;

COMMAND:Register();