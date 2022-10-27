local BLUEPRINT = Clockwork.crafting:New("learnable_base");

BLUEPRINT.name = "Camera";
BLUEPRINT.uniqueID = "camera";
BLUEPRINT.model = "models/maxofs2d/camera.mdl";
BLUEPRINT.category = "Other";
BLUEPRINT.description = "A plastic camera that looks a little beaten up and is only capable of taking pictures.";
BLUEPRINT.itemRequirements = {
	smashed_camera = 1,
	glass_piece = 1
};
BLUEPRINT.giveCash = 0;
BLUEPRINT.takeCash = 0;
BLUEPRINT.takeItems = {
	smashed_camera = 1,
	glass_piece = 1
};
BLUEPRINT.giveItems = {
	gmod_camera = 1
};

function BLUEPRINT:HasObjectAccess(player)
	local knownBlueprints;
	local hasAccess;

	if (SERVER) then
		knownBlueprints = player:GetCharacterData("KnownBlueprints");
	else
		knownBlueprints = Clockwork.KnownBlueprints;
	end;

	if (!knownBlueprints) then return; end;

	for k, v in pairs(knownBlueprints) do
		if (v:match(self("uniqueID"))) then
			hasAccess = true;
			break;
		end;
	end;

	return hasAccess;
end;


Clockwork.crafting:Register(BLUEPRINT);