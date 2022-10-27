local PLUGIN = PLUGIN;

function PLUGIN:GetTargetPlayerText(player, targetPlayerText)
	local health = player:Health()
	local gender = "He";
	
	if (player:GetGender() == GENDER_FEMALE) then
		gender = "She";
	end;

	if (health >= 100) then
		targetPlayerText:Add("HEALTH", gender.." looks healthy.", Color(0, 255, 0, 255), 0.85);
	elseif (health >= 80) then
		targetPlayerText:Add("HEALTH", gender.." looks slightly hurt.", Color(150, 200, 0, 255), 0.85);
	elseif (health >= 60) then
		targetPlayerText:Add("HEALTH", gender.." looks hurt.", Color(255, 255, 0, 255), 0.85);
	elseif (health >= 10) then
		targetPlayerText:Add("HEALTH", gender.." looks badly wounded.", Color(225, 100, 0, 255), 0.85);
	elseif (health >= 1) then
		targetPlayerText:Add("HEALTH", gender.." is near death!", Color(255, 25, 0, 255), 0.85);
	elseif (health <= 0) then
		targetPlayerText:Add("HEALTH", " ", Color(255, 25, 0, 255), 0.85);
	end;

end;