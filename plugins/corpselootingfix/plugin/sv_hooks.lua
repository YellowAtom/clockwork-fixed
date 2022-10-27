local PLUGIN = PLUGIN;

function PLUGIN:EntityHandleMenuOption(player, entity, option, arguments)
	if (arguments == "cw_corpseLoot") then
		return false 
	end;
end