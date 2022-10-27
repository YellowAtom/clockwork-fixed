
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

function PLUGIN:SendDetailedDesc(player, target)
	if (target:GetSharedVar("tied") != 0 or !player:Alive() or !player:HasInitialized() or !target:HasInitialized()) then
		return;
	end;

	if (target:GetPos():DistToSqr(player:GetPos()) > 160000) then
		return;
	end;

	local physDesc = target:GetCharacterData("PhysDesc");
	local detDesc = target:GetCharacterData("DetailDesc", physDesc);
	if (detDesc == "") then
		detDesc = physDesc;
	end;

	Clockwork.datastream:Start(player, "ViewDetDesc", {target, detDesc, target:GetCharacterData("PictureDesc")});
end;