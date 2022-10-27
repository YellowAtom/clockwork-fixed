local ITEM = Clockwork.item:New();
ITEM.name = "Trashed CID";
ITEM.cost = 3;
ITEM.model = "models/cmz/citizenid.mdl";
ITEM.uniqueID = "trashed_cid";
ITEM.category = "ID Cards";
ITEM.weight = 0.2;
ITEM.description = "A scratched up CID, you cannot make out any information on the owner.";

function ITEM:OnEntitySpawned(entity)
entity:SetMaterial("phoenix_storms/concrete0");
end;

function ITEM:OnDrop(player, position) end;
ITEM:Register();