
Clockwork.datastream:Hook("RequestClothes", function(player)
	local clothes = {};

	for k, v in pairs(player:GetCharacters()) do
		if (v.data.Clothes and v.data.Clothes.uniqueID) then
			local itemTable = Clockwork.item:FindByID(v.data.Clothes.uniqueID);

			if (itemTable("replacement")) then
				clothes[tostring(k)] = itemTable("replacement");
			elseif (itemTable("group")) then
				clothes[tostring(k)] = "models/humans/"..itemTable("group").."/"..string.gsub(string.lower(v.model), "^.-/.-/.-/", "");
			end;
		end;
	end;

	Clockwork.datastream:Start(player, "RequestClothes", clothes);
end);
