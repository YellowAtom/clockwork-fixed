
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

function PLUGIN:DrawTargetPlayerStatus(target, alpha, x, y)
	if (target:Alive() and target:GetSharedVar("IsAFK")) then
		local informationColor = Clockwork.option:GetColor("information");
		local gender = "He";
		local action = Clockwork.player:GetAction(target);
		
		if (target:GetGender() == GENDER_FEMALE) then
			gender = "She";
		end;

		local mainStatus = gender.." is away from keyboard";

		y = Clockwork.kernel:DrawInfo(Clockwork.kernel:ParseData(mainStatus), x, y, informationColor, alpha);
		
		return y;
	end;
end;

function PLUGIN:GetScreenTextInfo()
	if (Clockwork.Client:GetSharedVar("IsAFK")) then
		return {
			alpha = 255 - Clockwork.kernel:GetBlackFadeAlpha(),
			title = "YOU ARE AWAY FROM KEYBOARD"
		};
	end;
end;