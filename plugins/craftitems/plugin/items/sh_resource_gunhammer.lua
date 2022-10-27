local ITEM = Clockwork.item:New();
ITEM.name = "Hammer (Gun Part)";
ITEM.cost = 30;
ITEM.skin = 0;
ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl";
ITEM.uniqueID = "hammer_weapon";
ITEM.weight = 0.12;
ITEM.spawnType = "crafting";
ITEM.spawnValue = 2;
	ITEM.access = "v";
ITEM.business = true;
ITEM.description = "A hammer for weapons, used to fire the bullets.";

function ITEM:OnDrop(player, position) end;

function ITEM:OnEntitySpawned(entity)
entity:SetMaterial("models/props_canal/canal_bridge_railing_01c");
end;

ITEM:Register();