local ITEM = Clockwork.item:New("backpack_base");
ITEM.name = "Military Backpack";
ITEM.uniqueID = "military_backpack";
ITEM.model = "models/dpfilms/metropolice/props/metrold_backpack.mdl";
ITEM.actualWeight = 4;
ITEM.invSpace = 18;
ITEM.slot = "back";
ITEM.slotSpace = 10;
ITEM.description = "A large and strong pre-war milspec backpack capable of carrying a large quantity of equipment.";

ITEM.isAttachment = true;
ITEM.attachmentSlot = "Spine2";
ITEM.attachmentBone = "ValveBiped.Bip01_Spine2";
ITEM.attachmentOffsetVector = Vector(2, 0.7, -53.75);
ITEM.attachmentOffsetAngles = Angle(245.64, 275.47, 205.86);
ITEM.attachmentModelScale = Vector(1.1, 1.1, 1);

ITEM:AddData("AttachmentBone", "ValveBiped.Bip01_Spine2", true);
 
ITEM:AddQueryProxy("attachmentBone", "AttachmentBone");
 
function ITEM:AdjustAttachmentOffsetInfo(player, itemEntity, info)
    local model = string.lower(player:GetModel());
 
    if (string.match(model, "human") or string.match(model, "citizens")) then
        if (string.match(model, "female")) then
            info.offsetVector = Vector(2, 0, -53.75);
            info.offsetAngle = Angle(245.64, 275.47, 205.86);
        else
            info.offsetVector = Vector(2, -0.71, -53.75);
            info.offsetAngle = Angle(245.64, 275.47, 205.86);
        end;
    elseif (string.match(model, "combine")) then
        info.offsetVector = Vector(2, 0.7, -53.75);
        info.offsetAngle = Angle(245.64, 275.47, 205.86);
    end;
end;  
 
function ITEM:GetAttachmentModelScale(player, itemEntity)
    local model = string.lower(player:GetModel());
    local scale;

    if (string.match(model, "vortigaunt")) then
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