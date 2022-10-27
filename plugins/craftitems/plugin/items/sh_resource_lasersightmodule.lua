local ITEM = Clockwork.item:New();
ITEM.name = "N.L.A.W Laser Module";
ITEM.cost = 9;
ITEM.skin = 0;
ITEM.model = "models/props/cs_office/computer_caseb_p3a.mdl";
ITEM.uniqueID = "nlaw_lasermodule";
ITEM.weight = 0.15;
ITEM.business = false;
ITEM.description = "A component required to repair the N.L.A.W Laser Guidance System.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();