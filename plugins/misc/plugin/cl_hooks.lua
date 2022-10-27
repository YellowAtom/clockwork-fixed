
function PLUGIN:Initialize()
	local _, index = Clockwork.directory:GetCategory("Plugins");
	local panel = Clockwork.directory:GetPanel();

	Clockwork.directory.stored[index] = nil;

	if (panel) then
		panel:Rebuild();
	end;
end;

function PLUGIN:GetCharacterPanelLabels(_, customData)
	local clothes = Clockwork.character.stored[customData.characterID].clothes;

	if (clothes) then
		customData.model = clothes;
	end;
end;

function PLUGIN:MenuItemsAdd()
	Clockwork.datastream:Start("RequestClothes");
end;

function PLUGIN:PlayerCharacterScreenCreated()
	Clockwork.datastream:Start("RequestClothes");
end;

Clockwork.datastream:Hook("RequestClothes", function(data)
	for k, v in pairs(Clockwork.character.stored) do
		Clockwork.character.stored[k].clothes = data and data[tostring(k)] or nil;
	end;
end);
