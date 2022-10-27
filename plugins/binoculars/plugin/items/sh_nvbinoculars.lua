local ITEM = Clockwork.item:New("weapon_base");
ITEM.name = "Night Vision Binoculars";
ITEM.cost = 500;
ITEM.model = "models/weapons/w_nvbinoculars.mdl";
ITEM.uniqueID = "weapon_rpw_binoculars_nvg";
ITEM.category = "Tools"
ITEM.access = "v"
ITEM.isMeleeWeapon = true;
ITEM.batch = 1;
ITEM.weight = 0.8;
ITEM.business = true;
ITEM.description = "A pair of night vision binoculars. It has a small little wheel on the side you can use to adjust the zoom.";
	ITEM.isAttachment = true;
	ITEM.loweredOrigin = Vector(3, 0, -4);
	ITEM.loweredAngles = Angle(0, 45, 0);
	ITEM.attachmentBone = "ValveBiped.Bip01_Spine1";
	ITEM.attachmentOffsetAngles = Angle(275.47, 257.57, 360);
	ITEM.attachmentOffsetVector = Vector(-6.36, 4.95, -8.49);
ITEM:Register();

function ITEM:OnDrop(player, position) end;
ITEM:Register();