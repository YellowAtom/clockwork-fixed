-----------------------------------------------------

local ITEM = Clockwork.item:New();
ITEM.name = "Mystery Locked Chest";
ITEM.model = "models/Items/item_item_crate.mdl";
ITEM.weight = 5;
ITEM.uniqueID = "chest1";
ITEM.useText = "Lockpick";
ITEM.category = "Other";
ITEM.description = "A crate.\n-Can be lockpicked, you need a screwdriver to lockpick.";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	if (player:HasItemByID("screw_driver")) then
		Clockwork.player:SetAction(player, "lockpicking", 16, 1, function()
			local rand = math.random(1,50)
			local atb = Clockwork.attributes:Get(player, ATB_LOCKPICK)

			if atb == 75 then
				rand = 1;
			end;

			if rand == 1 or rand == 3 then
				Clockwork.player:Notify(player, "You have crocheted the chest successfully!");
				player:GiveItem(Clockwork.item:CreateInstance("chest2"));
			end;
			--player:ProgressAttribute(ATB_LOCKPICK, 150, true);
		end)
	else 
		Clockwork.player:Notify(player, "Find a screwdriver first.");
			return false;
	end;
end;


-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;


ITEM:Register(ITEM);