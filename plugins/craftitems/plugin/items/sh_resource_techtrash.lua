local ITEM = Clockwork.item:New();
ITEM.name = "Tech-Trash";
ITEM.cost = 120;
ITEM.skin = 0;
ITEM.model = "models/props/cs_office/computer_caseb_p7a.mdl";
ITEM.uniqueID = "techtrash";
ITEM.weight = 0.20;
ITEM.access = "V";
ITEM.spawnType = "crafting";
ITEM.spawnValue = 2;
ITEM.batch = 1;
ITEM.business = true;
ITEM.description = "A tech trash piece that can be used to repair electronic weapons and devices.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();