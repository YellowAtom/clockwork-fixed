
local ITEM = Clockwork.item:New("backpack_base");
ITEM.name = "Blue UU Backpack";
ITEM.uniqueID = "blueuubackpack";
ITEM.business = true;
ITEM.batch = 1;
ITEM.model = "models/pack/civil/backpack1.mdl";
ITEM.access = "1";
ITEM.cost = 80;
ITEM.actualWeight = 2;
ITEM.invSpace = 6;
ITEM.slot = "back";
ITEM.slotSpace = 6;
ITEM.description = "A rough looking blue UU backpack with some strange patterns on it.";

ITEM.isAttachment = true;
ITEM.attachmentSlot = "Pelvis";
ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
ITEM.attachmentOffsetVector = Vector(4.24, 1.41, 0);
ITEM.attachmentOffsetAngles = Angle(273.48, 178.01, 180);
ITEM.attachmentModelScale = Vector(1.1, 1.1, 1);

ITEM:AddData("AttachmentBone", "ValveBiped.Bip01_Spine2", true);

ITEM:AddQueryProxy("attachmentBone", "AttachmentBone");

function ITEM:AdjustAttachmentOffsetInfo(player, itemEntity, info)
 	local model = string.lower(player:GetModel());

 	if (string.match(model, "human") or string.match(model, "citizens")) then
 		if (string.match(model, "female")) then
			info.offsetVector = Vector(2.12, 0, -1.41);
			info.offsetAngle = Angle(72.6, 0, 0);
		else
			info.offsetVector = Vector(4.24, 1.41, 0);
            info.offsetAngle = Angle(273.48, 178.01, 180);
		end;
	elseif (string.match(model, "combine")) then
		info.offsetVector = Vector(-5.73, -9.9, 2.83);
		info.offsetAngle = Angle(0, 183.98, 88.51);
	end;
end;  

function ITEM:GetAttachmentModelScale(player, itemEntity)
	local model = string.lower(player:GetModel());
	local scale;

	if (string.match(model, "police")) then
		scale = Vector(1.1, 1.1, 1);
	elseif (string.match(model, "vortigaunt")) then
        scale = Vector(0.01, 0.01, 0,01);
	end;

	return scale;
end;

-- Called when a player has unequipped the item.
function ITEM:OnUnequip(player, extraData)		
	Clockwork.player:RemoveGear(player, self("attachmentSlot"));
end;

-- Called when a player wears the accessory.
function ITEM:OnEquip(player)
	local model = string.lower(player:GetModel());

	Clockwork.player:CreateGear(player, self("attachmentSlot"), self);

	timer.Simple(0.1, function()
		player:RebuildInventory();
	end);
end;

-- Called to get whether a player has the item equipped.
function ITEM:HasPlayerEquipped(player, bIsValidWeapon)
	return self:GetData("Equipped");
end;

ITEM:Register();