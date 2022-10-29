local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local beardGroupID = 12;
local stages = {
	[BEARD_NONE] = 0,
	[BEARD_HALF] = 8,
	[BEARD_FULL] = 5
};

local function CreateBeardTimer(player)
	local delay = Clockwork.config:Get("beard_grow_time"):Get() - math.max(player:GetCharacterData("BeardTimeGrowing") or 0, 0 );

	player.onLoadTime = CurTime();

	timer.Create("Beard_" .. player:SteamID64(), delay, 1, function()
		if (!IsValid(player)) then return end;

		local beardStage = player:GetCharacterData("BeardStage");

		player.onLoadTime = 0;
		player:SetCharacterData("BeardTimeGrowing", 0);
		player:SetCharacterData("BeardStage", beardStage + 1);
		Clockwork.player:Notify(player, "My beard has grown a " .. (beardStage == BEARD_NONE and "bit" or "lot") .. " lately..");

		if (player:GetCharacterData("BeardStage") <= 1) then
			CreateBeardTimer(player);
		end;

		if (beardGroupID < player:GetNumBodyGroups()) then
			local model = player:GetModel();
			local bodygroups = player:GetCharacterData("bodygroups") or {};
			bodygroups[model] = bodygroups[model] or {};

			bodygroups[model][beardGroupID] = stages[beardStage + 1];
			player:SetCharacterData("bodygroups", bodygroups);
			player:SetBodygroup(beardGroupID, stages[beardStage + 1]);
		end;
	end);
end;

function PLUGIN:PlayerAdjustCharacterCreationInfo(player, info)
	if (player:CanGrowBeard(info.gender, info.faction)) then
		info.data.BeardStage = BEARD_NONE;
		info.data.BeardTimeGrowing = 0;
	end;
end;

function PLUGIN:PlayerCharacterLoaded(player)
	player.onLoadTime = nil;

	if (player:CanGrowBeard() and player:GetCharacterData("BeardStage") <= 1) then
		CreateBeardTimer(player);
	end;
end;

function PLUGIN:PlayerCharacterUnloaded(player)
	if (player:CanGrowBeard()) then
		if (timer.Exists( "Beard_" .. player:SteamID64() )) then
			timer.Remove("Beard_" .. player:SteamID64());
		end;

		if (player:GetCharacterData("BeardStage") <= 1) then
			player:SetCharacterData("BeardTimeGrowing", CurTime() - player.onLoadTime);
		end;
	end;
end;

function PLUGIN:PlayerSaveData(player)
	if (player:CanGrowBeard() and player:GetCharacterData("BeardStage") <= 1) then
		player:SetCharacterData("BeardTimeGrowing", CurTime() - player.onLoadTime);
	end;
end;

Clockwork.datastream:Hook("ShaveBeard", function(player, data)
	local target = data.target;

	if (IsValid(target) and target:IsPlayer()) then
		if (player:HasItemByID("beard_razor")) then
			if (target != player) then
				local entity = player:GetEyeTraceNoCursor().Entity;

				if (IsValid(entity) and entity != target) then
					Clockwork.player:Notify(player, "You must be looking at a player!");
					return;
				end;

				if (target:GetAimVector():Dot(player:GetAimVector()) > 0) then
					Clockwork.player:Notify(player, "You need to be facing a player to shave their beard!");
					return;
				end;

				if (target:GetShootPos():DistToSqr(player:GetShootPos()) >= 192 * 192) then
					Clockwork.player:Notify(player, "Target is too far away!");
					return;
				end;
			end;

			if (target:CanGrowBeard()) then
				if (target:GetCharacterData("BeardStage") > 0) then
					local bodygroups = target:GetCharacterData("bodygroups") or {};
					local model = target:GetModel();

					bodygroups[model] = bodygroups[model] or {};
					bodygroups[model][beardGroupID] = data.style;

					target:SetBodygroup(beardGroupID, data.style or 0);
					target:SetCharacterData("BeardStage", BEARD_NONE);
					target:SetCharacterData("BeardTimeGrowing", 0);
					target:SetCharacterData("bodygroups", bodygroups);

					if (timer.Exists("Beard_" .. target:SteamID64())) then
						timer.Remove("Beard_" .. target:SteamID64());
					end;

					if (target:GetCharacterData("BeardStage") <= 1) then
						CreateBeardTimer(target);
					end;

					Clockwork.player:Notify(target, "Your beard has been " .. (data.style and "styled." or "shaved off."));

					if (target != player) then
						Clockwork.player:Notify(player, "You have " .. (data.style and "styled " or "shaved off ") .. target:Name() .. "'s beard.");
					end;
				else
					Clockwork.player:Notify(player, target:Name() .. " does not have enough facial hair!");
				end;
			else
				Clockwork.player:Notify(player, target:Name() .. " has no facial hair!");
			end;
		else
			Clockwork.player:Notify(player, "You do not own a razor!");
		end;
	else
		Clockwork.player:Notify(player, "Target is invalid!");
	end;
end);
