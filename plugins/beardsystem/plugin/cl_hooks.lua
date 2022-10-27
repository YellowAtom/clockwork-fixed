
local function ShaveBeard(bTarget, bStyle)
	local target;

	if (bTarget) then
		target = Clockwork.Client:GetEyeTraceNoCursor().Entity;

		if (!IsValid(target) or !target:IsPlayer()) then
			Clockwork.chatBox:Decode(nil, nil, "Target is invalid!", {}, "notify");
		 	return;
		end;

		if (target:GetShootPos():DistToSqr(Clockwork.Client:GetShootPos()) <= (192*192)) then
			if (target:GetAimVector():Dot(Clockwork.Client:GetAimVector()) > 0) then
				Clockwork.chatBox:Decode(nil, nil, "You need to be facing a player to shave their beard!", {}, "notify");
				return;
			end;
		else
			Clockwork.chatBox:Decode(nil, nil, "Target is too far away!", {}, "notify");
			return;
		end;
	else
		target = Clockwork.Client;
	end;

	if (target:CanGrowBeard()) then
		if (target:GetBodygroup(12) != 5 and target:GetBodygroup(12) != 8) then
			Clockwork.chatBox:Decode(nil, nil, target:Name().." doesn't have enough facial hair!", {}, "notify");
			return;
		end;
	else
		Clockwork.chatBox:Decode(nil, nil, target:Name().." has no facial hair!", {}, "notify");
		return;
	end;

	if (bStyle) then
		local menuPanel = Clockwork.menu:GetPanel();
		beardTarget = target;

		if (menuPanel) then
			menuPanel:SetOpen(false);
		end;

		vgui.Create("cwBeardMenu");

		return;
	end;

	Clockwork.datastream:Start("ShaveBeard", {target = target});
end;

function PLUGIN:PlayerAdjustItemMenu(itemTable, itemMenu)
	if (itemTable("uniqueID") == "beard_razor") then
		local subMenuShave = itemMenu:AddSubMenu("Shave");
		local subMenuStyle = itemMenu:AddSubMenu("Style");

		subMenuShave:AddOption("Self", function() ShaveBeard() end);
		subMenuShave:AddOption("Other", function() ShaveBeard(true) end);
		subMenuStyle:AddOption("Self", function() ShaveBeard(nil, true) end);
		subMenuStyle:AddOption("Other", function() ShaveBeard(true, true) end);
	end;
end;
