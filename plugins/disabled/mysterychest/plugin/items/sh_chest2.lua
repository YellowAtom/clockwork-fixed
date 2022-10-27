-----------------------------------------------------

local ITEM = Clockwork.item:New();
ITEM.name = "Mystery Unlocked Chest";
ITEM.model = "models/Items/item_item_crate.mdl";
ITEM.weight = 5;
ITEM.uniqueID = "chest2";
ITEM.useText = "Open the Chest";
ITEM.category = "Other";
ITEM.description = "A mystery chest, it seems to be opened.\n-Contains a lots of object.";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	local rand = math.random(3,9)
	local rand2 = math.random(3,9)

	Clockwork.player:Notify(player, "You open the chest.");
	--if rand == 1 or rand2 == 2 or rand == 2 or rand2 == 1 or rand == 10 or rand2 == 10 then
	--	Clockwork.player:Notify(player, "You did not find anything in the chest.");
	-end;
	if rand == 3 or rand2 == 3 then
		Clockwork.player:Notify(player, "You found a beanie.");
		player:GiveItem(Clockwork.item:CreateInstance("beanie"));
	end;
	if rand == 4 or rand2 == 4 then
		local rand3 = math.random(100, 220);
		Clockwork.player:GiveCash(player, rand3);
		Clockwork.player:Notify(player, "You found "..rand3.." tokens in the chest.");
	end;
	if rand == 5 or rand2 == 5 then
		Clockwork.player:Notify(player, "You found a radio in the chest.");
		player:GiveItem(Clockwork.item:CreateInstance("handheld_radio"));
	end;
	if rand == 6 or rand2 == 6 then
		Clockwork.player:Notify(player, "You found some UU consumables in the chest.");
		player:GiveItem(Clockwork.item:CreateInstance("breens_water"));
		player:GiveItem(Clockwork.item:CreateInstance("breens_water"));
		player:GiveItem(Clockwork.item:CreateInstance("uu_potato"));
	end;
	if rand == 7 or rand2 == 7 then
		Clockwork.player:Notify(player, "You found health kits in the chest.");
		player:GiveItem(Clockwork.item:CreateInstance("health_kit"));
		player:GiveItem(Clockwork.item:CreateInstance("health_kit"));
		player:GiveItem(Clockwork.item:CreateInstance("health_vial"));
		player:GiveItem(Clockwork.item:CreateInstance("health_kit"));
	end;
	if rand == 8 or rand2 == 8 then
		Clockwork.player:Notify(player, "You found steroids in the chest.");
		player:GiveItem(Clockwork.item:CreateInstance("steroids"));
		player:GiveItem(Clockwork.item:CreateInstance("steroids"));
	end;
	if rand == 9 or rand2 == 9 then
		Clockwork.player:Notify(player, "You found a crowbar!");
		player:GiveItem(Clockwork.item:CreateInstance("weapon_crowbar"));
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;


ITEM:Register(ITEM);