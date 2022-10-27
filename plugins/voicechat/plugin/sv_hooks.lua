local PLUGIN = PLUGIN

function PLUGIN:PlayerCanHearPlayersVoice(listener, talker)
  if (!Clockwork.player:HasFlags(talker, "S")) then return false end;
end
