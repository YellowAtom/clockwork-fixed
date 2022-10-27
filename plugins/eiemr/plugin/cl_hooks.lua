local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

function PLUGIN:MenuItemsDestroy(menuItems)
	if (Clockwork.config:Get("menuitem_hide_plugincenter"):Get()) then
		menuItems:Destroy("Plugin Center");
	end;
	if (Clockwork.config:Get("menuitem_hide_community"):Get()) then
		menuItems:Destroy("Community");
	end;
end;