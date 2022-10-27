
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

--Called to edit the detailed description.
Clockwork.datastream:Hook("EditDetDesc", function(data)
	if (IsValid( data[1] )) then
		if (PLUGIN.editdescPanel and PLUGIN.editdescPanel:IsValid()) then
			PLUGIN.editdescPanel:Close();
			PLUGIN.editdescPanel:Remove();
		end;
		
		PLUGIN.editdescPanel = vgui.Create("cwDetDesc");
		PLUGIN.editdescPanel:Populate(data[1], data[2], data[3]);
		PLUGIN.editdescPanel:MakePopup();
		
		gui.EnableScreenClicker(true);
	end;
end);

--Called to view the detailed description.
Clockwork.datastream:Hook("ViewDetDesc", function(data)
	if (IsValid(data[1])) then
		if (IsValid(PLUGIN.viewdescPanel)) then
			PLUGIN.viewdescPanel:Close();
			PLUGIN.viewdescPanel:Remove();
		end;

		PLUGIN.viewdescPanel = vgui.Create("cwViewDetDesc");
		PLUGIN.viewdescPanel:Populate(data[1], data[2], data[3]);
		PLUGIN.viewdescPanel:MakePopup();
		
		gui.EnableScreenClicker(true);
	end;
end);