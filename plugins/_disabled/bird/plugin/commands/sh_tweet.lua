local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("Tweet");
COMMAND.tip = "Tweet tweet!";
COMMAND.text = "<string Text>";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE);
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local talkRadius = Clockwork.config:Get("talk_radius"):Get();
	local players = _player.GetAll();
	local text = table.concat(arguments, " ")
	if player:GetFaction() == FACTION_BIRD then
		for k, v in pairs(players) do
			if (v:GetFaction() == FACTION_BIRD and v:GetPos():Distance(player:GetPos())<=talkRadius*2) then
				Clockwork.chatBox:Add(v, player, "it", player:GetName() .. " chirps in bird \"" .. text .. "\"");
			else
				if (v:GetPos():Distance(player:GetPos())<=talkRadius*2) then
					local s = string.rep("Chirp ", math.random(1, 4));
					Clockwork.chatBox:Add(v, player, "it", player:GetName() .. " chirps, \"" .. string.sub(s, 0, string.len(s)-1) .. "\"")
				end
			end
		end
	else
		Clockwork.player:Notify(player, "Have some respect.")
	end
end;

COMMAND:Register();