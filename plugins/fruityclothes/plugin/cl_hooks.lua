local Clockwork = Clockwork;

local PLUGIN = PLUGIN;

function PLUGIN:GetTargetPlayerText(player, targetPlayerText)
	local bConcealed = player:GetSharedVar("isConcealed");

	if (bConcealed and !Clockwork.player:DoesRecognise(player, RECOGNISE_PARTIAL)) then
		targetPlayerText:Add("CONCEALED", "This person's identity is concealed.");
	end;
end;

function PLUGIN:DestroyTargetPlayerText(player, targetPlayerText)
	local bConcealed = player:GetSharedVar("isConcealed");

	if (bConcealed and !Clockwork.player:DoesRecognise(player, RECOGNISE_PARTIAL)) then
		targetPlayerText:Destroy("PHYSDESC");
	end;
end;

function PLUGIN:GetCharacterPanelWeaponModel(panel)
	local model = panel.characterModel:GetEntity();
	local bodygroups = Clockwork.character.stored[panel.customData.characterID].bodygroups;

	if (bodygroups) then
		bodygroups = bodygroups[model:GetModel()];

		if (bodygroups) then
			for id, value in pairs(bodygroups) do
				model:SetBodygroup(id, value);
			end;
		end;
	end;
end;

function PLUGIN:MenuItemsAdd()
	Clockwork.datastream:Start("RequestBodygroups");
end;

function PLUGIN:PlayerCharacterScreenCreated()
	Clockwork.datastream:Start("RequestBodygroups");
end;

Clockwork.datastream:Hook("RequestBodygroups", function(data)
	for k, v in pairs(Clockwork.character.stored) do
		Clockwork.character.stored[k].bodygroups = data and data[k] or nil;
	end;
end);