local ITEM = Clockwork.item:New(nil, true);

ITEM.name = "Diagram Base";
ITEM.useText = "Study";
ITEM.category = "Diagrams";

function ITEM:OnUse(player)
	local knownBlueprints = player:GetCharacterData("KnownBlueprints");
	local blueprintName = Clockwork.crafting:FindByID(self("blueprintID"))("name");

	if (!table.HasValue(knownBlueprints, self("blueprintID"))) then
		table.insert(knownBlueprints, self("blueprintID"));

		player:SetCharacterData("KnownBlueprints", knownBlueprints);
		player:NetworkBlueprints();

		Clockwork.player:Notify(player, "You have learned how to craft a "..blueprintName..".");
	else
		Clockwork.player:Notify(player, "You already know how to craft a "..blueprintName.."!");
		return false;
	end;
end;

Clockwork.item:Register(ITEM);