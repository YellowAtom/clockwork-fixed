local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

Clockwork.config:Add("menuitem_hide_plugincenter", false, true, true);
Clockwork.config:Add("menuitem_hide_community", false, true, true);
Clockwork.config:Add("skip_clockwork_intro", true, true, true);

function PLUGIN:ClockworkInitialized()
	if (Clockwork.config:Get("skip_clockwork_intro"):Get()) then
		local DatastreamStart = Clockwork.datastream.Start;

		function Clockwork.datastream:Start(player, name, data)

			if (name != "WebIntroduction" or name == "WebIntroduction" and !player:GetData("ClockworkIntro")) then
				return DatastreamStart(self, player, name, data);
			end;
		end;
	end;
end