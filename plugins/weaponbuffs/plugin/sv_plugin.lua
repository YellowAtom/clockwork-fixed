function PLUGIN:EntityTakeDamage(entity, damageInfo)
	local attacker = damageInfo:GetAttacker();

	if (attacker:IsPlayer()) then
		local weapon = Clockwork.player:GetWeaponClass(attacker);

		if (weapon == "weapon_ar2") then
			damageInfo:ScaleDamage(3);
		elseif (weapon == "hunter_flechette") then
			damageInfo:ScaleDamage(3);
		elseif (weapon == "rcs_usp") then
			damageInfo:ScaleDamage(0.5);
		elseif (weapon == "rcs_p228") then
			damageInfo:ScaleDamage(0.5);
		elseif (weapon == "rcs_57") then
			damageInfo:ScaleDamage(0.6);
		elseif (weapon == "rcs_glock") then
			damageInfo:ScaleDamage(0.5);
		elseif (weapon == "rcs_mp5") then
			damageInfo:ScaleDamage(0.5);
		elseif (weapon == "rcs_ump") then
			damageInfo:ScaleDamage(0.6);
		elseif (weapon == "rcs_tmp") then
			damageInfo:ScaleDamage(0.5);
		elseif (weapon == "rcs_m4a1") then
			damageInfo:ScaleDamage(0.72);
		elseif (weapon == "rcs_mac10") then
			damageInfo:ScaleDamage(0.75);
		elseif (weapon == "rcs_m3") then
			damageInfo:ScaleDamage(0.42);
		elseif (weapon == "rcs_p90") then
			damageInfo:ScaleDamage(0.6);
		elseif (weapon == "weapon_smg1") then
			damageInfo:ScaleDamage(1.2);
		elseif (weapon == "rcs_g3sg1") then
			damageInfo:ScaleDamage(0.2);
		elseif (weapon == "cw_smgnolaunch") then
			damageInfo:ScaleDamage(3.5);
		elseif (weapon == "rcs_m249") then
			damageInfo:ScaleDamage(0.65);
		elseif (weapon == "weapon_hl2brokenbottle") then
			damageInfo:ScaleDamage(0.3);
		end;
	end;
end;