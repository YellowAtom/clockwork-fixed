local ITEM = Clockwork.item:New("backpack_base");

ITEM.name = "Doctor's Bag";
ITEM.uniqueID = "cmudocbag";
ITEM.value = 6;
ITEM.type = "misc";
ITEM.business = true;
ITEM.access = "1";
ITEM.cost = 30;
ITEM.batch = 1;
ITEM.actualWeight = 2;
ITEM.invSpace = 4;
ITEM.slot = "hand";
ITEM.slotSpace = 3;
ITEM.description = "A leather bag with a red CMU cross on it.";
ITEM.model = "models/props_c17/briefcase001a.mdl";
ITEM.isAttachment = true;
ITEM.attachmentSlot = "R_Hand";
ITEM.attachmentBone = "ValveBiped.Bip01_R_Hand";
ITEM.attachmentOffsetVector = Vector(-2.83, 2.12, 9.9);
ITEM.attachmentOffsetAngles = Angle(335.14, 68.62, 148.18);
ITEM.attachmentModelScale = Vector(0.9, 0.9, 0.9);

function ITEM:AdjustAttachmentOffsetInfo(player, itemEntity, info)
 	local model = string.lower(player:GetModel());
 	local gender = player:GetGender();

 	if (string.match(model, "human") or string.match(model, "citizen")) then
 		if (string.match(model, "female")) then
 			info.offsetVector = Vector(0, 1.41, 12.02);
			info.offsetAngle = Angle(331.16, 90.5, 148.18);
		else
			info.offsetVector = Vector(0, 2.12, 12.02);
			info.offsetAngle = Angle(331.16, 90.5, 148.18);
		end;
	end;
end;

-- Called when a player has unequipped the item.
function ITEM:OnUnequip(player, extraData)		
	Clockwork.player:RemoveGear(player, self("attachmentSlot"));
end;

function ITEM:CanEquip(player)
	local model = string.lower(player:GetModel());

	if (string.match(model, "vortigaunt")) then
		Clockwork.player:Notify(player, "You struggle to properly grasp the bag's handles!");
		return false;
	end;

	return true;
end;

-- Called when a player wears the accessory.
function ITEM:OnEquip(player)
	Clockwork.player:CreateGear(player, self("attachmentSlot"), self);

	timer.Simple(0.1, function()
		player:RebuildInventory();
	end);
end;

-- Called to get whether a player has the item equipped.
function ITEM:HasPlayerEquipped(player, bIsValidWeapon)
	return self:GetData("Equipped");
end;

Clockwork.item:Register(ITEM);