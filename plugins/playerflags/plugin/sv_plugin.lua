function RemFlags(player, flags)
	local plyflags = player:GetData("PlayerFlags");
	local totflags;
	if(plyflags) then
		for x = 0, string.len(flags) do
			if(string.find(plyflags, string.sub(flags, x, x))) then
				totflags = string.gsub(plyflags, string.sub(flags, x, x), "");
			end;
		end;
		SetFlags(player, totflags);
	end
end;

function AddFlags(player, flags)
	local plyflags = player:GetData("PlayerFlags");
	if(plyflags) then
		for x = 0, string.len(plyflags) do
			if string.find(flags, string.sub(plyflags, x, x)) then
				flags = string.gsub(flags, string.sub(plyflags, x, x), "");
			end;
		end;
		SetFlags(player, plyflags..flags);
	end
end;

function SetFlags(player, flags)
	local exemptflags = player:GetCharacterData("ExemptFlags");
	player:SetData("PlayerFlags", flags);
	if(exemptflags and exemptflags != "") then
		for x = 0, string.len(exemptflags) do
			if(!string.find(flags, string.sub(exemptflags, x, x))) then
				flags = flags..string.sub(exemptflags, x, x);
			end;
		end;
	end;
	Clockwork.player:TakeFlags(player, allflags);
	Clockwork.player:GiveFlags(player, flags);
end;