Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

local PLUGIN = PLUGIN;

PLUGIN:SetGlobalAlias( "cassetteplugin" )

t_cassette = {
	cassettes = {}
}
	
function t_cassette.Register(name, playlist)
	for key, tbl in pairs(playlist) do
		tbl.key = key
	end
	local tbl = {name = name, playlist = playlist}
	tbl.key = table.insert(t_cassette.cassettes, tbl)
	return tbl.key
end