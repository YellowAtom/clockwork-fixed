local Clockwork = Clockwork;

Clockwork.config:ShareKey("menuitem_hide_plugincenter");
Clockwork.config:ShareKey("menuitem_hide_community");

Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");