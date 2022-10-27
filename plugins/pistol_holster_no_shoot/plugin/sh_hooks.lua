function PLUGIN:StartCommand(player, userCommand)
	local buttons = userCommand:GetButtons();

	if (bit.band(buttons, IN_ATTACK) == 0) then
		return;
	end;
	
	local activeWeapon = player:GetActiveWeapon();
	
	if (!IsValid(activeWeapon)) then
		return;
	end;
	
	if (activeWeapon:GetClass() != "weapon_pistol") then
		return;
	end;
	
	if (Clockwork.player:GetWeaponRaised(player)) then
		return;
	end;
	
	local notAttackMask = bit.bnot(IN_ATTACK);
	local newButtons = bit.band(buttons, notAttackMask);
	
	userCommand:SetButtons(newButtons);
end;
