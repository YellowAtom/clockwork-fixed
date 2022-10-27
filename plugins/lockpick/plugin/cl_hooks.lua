local PLUGIN = PLUGIN;

function PLUGIN:GetProgressBarInfo()
	local action, percentage = Clockwork.player:GetAction(Clockwork.Client, true);

	if (!Clockwork.Client:IsRagdolled()) then
		if (action == "lockpick") then
			return {text = "Picking Lock..", percentage = percentage, flash = percentage < 10};
		end;
	end;
end;