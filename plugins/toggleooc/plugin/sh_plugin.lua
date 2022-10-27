local Clockwork = Clockwork;
local PLUGIN = PLUGIN;
if (SERVER) then
	Clockwork.config:Add("ooc_enabled", true);
	
	function PLUGIN:PlayerCanSayOOC(player, text)
		local ooc = Clockwork.config:Get("ooc_enabled"):Get();

		if (!ooc and !player:IsAdmin()) then
			player:Notify("OOC is currently disabled.");
			return false;
		end;
	end;
else
	Clockwork.config:AddToSystem("OOC enabled", "ooc_enabled", "Whether or not OOC chat is enabled.");
end;