-- Called when the local player attempts to see a class.
function PLUGIN:PlayerCanSeeClass(class)
	if (class.index == CLASS_EMP and !Schema:IsPlayerCombineRank(Clockwork.Client, "OfC")) then
		return false;
	end;
end;