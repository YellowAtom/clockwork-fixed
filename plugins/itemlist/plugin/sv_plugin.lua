local PLUGIN = PLUGIN;

function PLUGIN:OnPlayerUserGroupSet(player, userGroup)
	if (!player.createdItemsCategory and userGroup == "superadmin") then
		player.createdItemsCategory = true;
		Clockwork.datastream:Start(player, "CreateItemsCategory");
	end;
end;

function PLUGIN:PlayerSpawn(player)
	if (!player.createdItemsCategory and player:GetUserGroup() == "superadmin") then
		player.createdItemsCategory = true;
		Clockwork.datastream:Start(player, "CreateItemsCategory");
	end;
end;

Clockwork.datastream:Hook("MenuItemSpawn", function(player, uniqueID)
	if (!IsValid(player)) then return; end;
	if (!Clockwork.player:HasFlags(player, "s")) then return; end;

	local itemTable = Clockwork.item:CreateInstance(uniqueID);

	if (itemTable) then
		local pos = player:GetEyeTraceNoCursor().HitPos;
		local normal = player:GetEyeTraceNoCursor().HitNormal;
		local item = Clockwork.entity:CreateItem(nil, itemTable, pos);

		Clockwork.entity:MakeFlushToGround(item, pos, normal);
		Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " spawned a " .. itemTable("name") .. " (" ..itemTable("uniqueID") .. ") " .. itemTable("itemID") .. ".");

		undo.Create("Spawned Item");
			undo.AddEntity(item);
			undo.SetPlayer(player);
			undo.SetCustomUndoText("Undone Item");
		undo.Finish();
	end;
end);

Clockwork.datastream:Hook("MenuItemGive", function(player, uniqueID)
	if (!IsValid(player)) then return; end;
	if (!Clockwork.player:HasFlags(player, "s")) then return; end;

	local itemTable = Clockwork.item:CreateInstance(uniqueID);

	if (itemTable) then
		player:GiveItem(itemTable, true);

		Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name() .. " gave him/herself a " .. itemTable("name") .. " (" ..itemTable("uniqueID") .. ") " .. itemTable("itemID") .. ".");
	end;
end);