local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");

--[[ 
	Run the file now that the schema has 
	loaded and we can override the default
	menu.
--]]
function PLUGIN:ClockworkSchemaLoaded()
	Clockwork.kernel:IncludePrefixed(self:GetBaseDir().."/cl_character.lua");
end;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("requiresGlasses", true);
	playerVars:Number("wearingLenses", true);
end;