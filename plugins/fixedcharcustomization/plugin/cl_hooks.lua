local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

-- Called when the character panel weapon model is needed.
function PLUGIN:GetCharacterPanelSequence(entity, character) 
	for k, v in pairs(Clockwork.kernel:Deserialize(character.customizationOptions or "")) do
		if (k == "Skin") then
			entity:SetSkin(v);
		end;
	end;
end;

Clockwork.datastream:Hook("CustomizationOptions", function(data)
	Clockwork.Client.customizationOptions = data;
end);

Clockwork.datastream:Hook("GlassesOptions", function(data)
	Clockwork.Client.glassesButton = data;
end);

-- Called when blurry screen space effects should be rendered.
function PLUGIN:RenderScreenspaceEffects()
	local needsGlasses = LocalPlayer():GetSharedVar("requiresGlasses");
	local contactLenses = LocalPlayer():GetSharedVar("wearingLenses");
	local playerNoclip = LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP;
	if !playerNoclip then
		if needsGlasses == 1 and (Clockwork.Client:GetBodygroup(6) == 0 and contactLenses == 0) then
			DrawToyTown(28,ScrH())
		end;
	end;
end;