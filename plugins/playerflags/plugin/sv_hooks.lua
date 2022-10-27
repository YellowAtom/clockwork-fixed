function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	local plyflags = player:GetData("PlayerFlags");
	if(plyflags) then
		local exemptflags = player:GetData("ExemptFlags");
		if(exemptflags and exemptflags != "") then
			for x = 0, string.len(exemptflags) do
				if(!string.find(plyflags, string.sub(exemptflags, x, x)))then
					plyflags = plyflags..string.sub(exemptflags, x, x);
				end;
			end;
		end;
		SetFlags(player, plyflags);
	end;
end;