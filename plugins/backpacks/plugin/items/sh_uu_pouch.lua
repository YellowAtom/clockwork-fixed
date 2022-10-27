
local ITEM = Clockwork.item:New("backpack_base");
ITEM.name = "UU Pouch";
ITEM.uniqueID = "uupouch";
ITEM.access = "1";
ITEM.batch = 1;
ITEM.type = "misc";
ITEM.value = 12;
ITEM.cost = 15;
ITEM.business = true;
ITEM.model = "models/weapons/w_eq_defuser.mdl";
ITEM.actualWeight = 0.4;
ITEM.invSpace = 1;
ITEM.slot = "pouch";
ITEM.slotSpace = 5;
ITEM.description = "A small pouch with a UU insignia on it, ideal for holding small things.";

ITEM.isAttachment = true;
ITEM.attachmentSlot = "Pelvis";
ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
ITEM.attachmentOffsetVector = Vector(-8, 3, 0);
ITEM.attachmentOffsetAngles = Angle(100, 180, 90);
ITEM.attachmentModelScale = Vector(1, 1, 1);

ITEM:AddData("AttachmentBone", "ValveBiped.Bip01_Pelvis", true);

ITEM:AddQueryProxy("attachmentBone", "AttachmentBone");

function ITEM:AdjustAttachmentOffsetInfo(player, itemEntity, info)
 	local model = string.lower(player:GetModel());

 	if (string.match(model, "human") or string.match(model, "citizens")) then
 		if (string.match(model, "female")) then
			info.offsetVector = Vector(4.3, 3, 0);
			info.offsetAngle = Angle(94.48, 178.01, 269.5);
		else
			info.offsetVector = Vector(5.5, 3, 0);
            info.offsetAngle = Angle(90, 180, 265);
		end;
	elseif (string.match(model, "vortigaunt")) then
		info.offsetVector = Vector(0, 4.95, 0);
		info.offsetAngle = Angle(267.51, 265.52, 181.99);
	elseif (string.match(model, "combine")) then
		info.offsetVector = Vector(5, 3, 0);
		info.offsetAngle = Angle(100, 178, 269);
	end;
end;  

function ITEM:GetAttachmentModelScale(player, itemEntity)
	local model = string.lower(player:GetModel());
	local scale;

	if (string.match(model, "vortigaunt")) then
		scale = Vector(0.88, 0.8, 1);
	elseif (string.match(model, "police")) then
		scale = Vector(1, 0.9, 1);
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

	if (string.match(model, "vortigaunt")) then
		self:SetData("AttachmentBone", "ValveBiped.spine1");
	else
		self:SetData("AttachmentBone", "ValveBiped.Bip01_Pelvis");
	end;

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
ITEM:Register();