local ITEM = Clockwork.item:New();
ITEM.name = "Broken N.L.A.W Rocket Launcher";
ITEM.cost = 1000;
ITEM.skin = 0;
ITEM.model = "models/weapons/w_rocket_launcher.mdl";
ITEM.uniqueID = "broken_nlaw_craft";
ITEM.weight = 5.37;
ITEM.description = "A massively damaged N.L.A.W Rocket Launcher. It appears someone fired this too close, and the entire front part of the rocket launcher is just gone.";

function ITEM:OnDrop(player, position) end;
ITEM:Register();