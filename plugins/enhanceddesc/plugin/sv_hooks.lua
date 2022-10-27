
local Clockwork = Clockwork;
local PLUGIN = PLUGIN;

Clockwork.datastream:Hook("descSend", function(player, data)
	if (player) then
		if (data.desc != "") then
			player:SetCharacterData("DetailDesc", data.desc);
		else
			player:SetCharacterData("DetailDesc", nil);
		end;
		if (data.sendlink != "") then
			player:SetCharacterData("PictureDesc", data.sendlink);
		else
			player:SetCharacterData("PictureDesc", nil);
		end;
	end;
end);

function PLUGIN:KeyPress(player, char)
	local scannerList = Schema.scanners;
	if (char == IN_USE and !scannerList[player]) then
		local trace = player:GetEyeTraceNoCursor();
		local target = Clockwork.entity:GetPlayer(trace.Entity);
		
		if (target and !target:IsRagdolled() and !scannerList[target]) then
			self:SendDetailedDesc(player, target);
		end;
	end;
end;