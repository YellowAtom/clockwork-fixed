--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local PLUGIN = PLUGIN;

Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");

-- Called when the Clockwork shared variables are added.
function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Bool("isConcealed");
end;

function PLUGIN:Initialize()
	if (cwAnimatedLegs and !Clockwork.plugin:IsDisabled(cwAnimatedLegs.name) and
		!Clockwork.plugin:IsUnloaded(cwAnimatedLegs.name)) then

		if (CLIENT) then
			Clockwork.datastream:Hook("UpdateAnimatedLegs", function(data)
				local model = cwAnimatedLegs.LegsEntity;
				local bodygroups = data[model:GetModel()];
				local delay = 0;

				if (!data.noReset) then
					delay = 0.1;

					for i = 0, (model:GetNumBodyGroups() - 1) do
						model:SetBodygroup(i, 0);
					end;
				end;

				timer.Simple(delay, function()
					for id, value in pairs(bodygroups) do
						model:SetBodygroup(id, value);
					end;
				end);
			end);
		else
			PLUGIN.animatedLegsEnabled = true;
		end;	
	end;
end;