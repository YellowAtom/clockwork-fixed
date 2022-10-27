
STYLE_HANDLEBAR = 1;
STYLE_COPSTASH = 2;
STYLE_DALLAS = 3;
STYLE_IMPERIAL = 4;
STYLE_SMALLGOATEE = 5;
STYLE_GOATEE = 6;

local PLUGIN = PLUGIN;

Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");

if (SERVER) then
	Clockwork.config:Add("beard_grow_time", 7200);
else
	Clockwork.config:AddToSystem("Beard Grow Time", "beard_grow_time", "The time it takes for each beard stage advancement, in seconds.");
end;

Clockwork.config:ShareKey("beard_grow_time");
