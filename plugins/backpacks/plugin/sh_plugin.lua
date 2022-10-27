
local Clockwork = Clockwork;

Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");

function PLUGIN:PlayerCharacterUnloaded(player)
	for _, items in pairs(player:GetInventory()) do
		for _, item in pairs(items) do
			if (item:IsBasedFrom("backpack_base") and item:GetData("equipped")) then
				Clockwork.player:RemoveGear(player, item("attachmentSlot"));
			end;
		end;
	end;
end;

function PLUGIN:PlayerCharacterLoaded(player)
	for _, items in pairs(player:GetInventory()) do
		for _, item in pairs(items) do
			if (item:IsBasedFrom("backpack_base") and item:GetData("equipped")) then
				Clockwork.player:CreateGear(player, item("attachmentSlot"), item);
			end;
		end;
	end;
end;