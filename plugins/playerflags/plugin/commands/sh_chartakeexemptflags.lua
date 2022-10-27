local COMMAND = Clockwork.command:New("CharTakeExemptFlags");
COMMAND.tip = "Takes exempt flags from a character.";
COMMAND.text = "<string Name> <string Flag(s)>";
COMMAND.access = "s";
COMMAND.arguments = 2;
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	if (target) then
		local exemptflags = target:GetCharacterData("ExemptFlags");
		if (string.find(arguments[2], "a") or string.find(arguments[2], "s")
		or string.find(arguments[2], "o")) then
			Clockwork.player:Notify(player, "You cannot take 'o', 'a' or 's' flags!");
			return;
		end;
		if(exemptflags and exemptflags != "") then
			for x = 0, string.len(arguments[2]) do
				if(string.find(exemptflags, string.sub(arguments[2], x, x))) then
					exemptflags = string.gsub(exemptflags, string.sub(arguments[2], x, x), "");
				end
			end
			target:SetCharacterData("ExemptFlags", exemptflags);
		end
		Clockwork.player:TakeFlags(target, arguments[2]);
		Clockwork.player:NotifyAll(player:Name().." took '"..arguments[2].."' flags from "..target:Name()..".");
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;
COMMAND:Register();