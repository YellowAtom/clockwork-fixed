local ITEM = Clockwork.item:New();
ITEM.name = "Jar of Roofies";
ITEM.cost = 80;
ITEM.model = "models/props_lab/jar01a.mdl";
ITEM.weight = 0.2;
ITEM.batch = 1;
ITEM.access = "q";
ITEM.useText = "Spike a drink";
ITEM.category = "Drugs";
ITEM.business = true;
ITEM.description = "A small jar of Flunitrazepam pills (Roofies).";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)				
	if (player:FindItemByID("beer")) then
		local itemTable = player:FindItemByID("beer");
		player:ProgressAttribute(ATB_DEXTERITY, 15, true);
		player:GiveItem(Clockwork.item:CreateInstance("roofie_b"));
		Clockwork.player:Notify(player, "You have spiked a beer!");
		player:TakeItem(itemTable);
		player:TakeItem(self);
	elseif (player:FindItemByID("whiskey")) then
		local itemTable = player:FindItemByID("whiskey");
		player:ProgressAttribute(ATB_DEXTERITY, 15, true);
		player:GiveItem(Clockwork.item:CreateInstance("roofie_w"));
		Clockwork.player:Notify(player, "You have spiked a whiskey!");
		player:TakeItem(itemTable);
		player:TakeItem(self);
	elseif (player:FindItemByID("breens_water")) then
		local itemTable = player:FindItemByID("breens_water");
		player:ProgressAttribute(ATB_DEXTERITY, 15, true);
		player:GiveItem(Clockwork.item:CreateInstance("roofie_bw"));
		Clockwork.player:Notify(player, "You have spiked a breen's water!");
		player:TakeItem(itemTable);
		player:TakeItem(self);
	else
		Clockwork.player:Notify(player, "You don't have a drink to spike!");
		return false
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();