local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Five Seven";
	ITEM.cost = 350;
	ITEM.model = "models/weapons/w_pist_fiveseven.mdl";
	ITEM.weight = 1;
	ITEM.access = "V";
	ITEM.uniqueID = "rcs_57";
	ITEM.business = true;
	ITEM.batch = 1;
	ITEM.description = "The FN Five-seven, trademarked as the Five-seveN, is a semi-automatic pistol designed and manufactured by FN Herstal in Belgium.";
	ITEM.isAttachment = true;
	ITEM.hasFlashlight = false;
	ITEM.loweredOrigin = Vector(3, 0, -4);
	ITEM.loweredAngles = Angle(0, 45, 0);
	ITEM.attachmentBone = "ValveBiped.Bip01_L_Thigh";
	ITEM.attachmentOffsetAngles = Angle(108.4, 0, 0);
	ITEM.attachmentOffsetVector = Vector(4.95, -4.24, 3.03);
ITEM:Register();