
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local cwOption = Clockwork.option;

PLUGIN.modifyIconClassList = {"ooc", "looc", "priv", "cp_adminhelp", "cp_adminchat", "cp_warn_player", "cp_warn_admin", "chat"};
PLUGIN.noAnonClassList = {"pm", "ooc", "looc", "priv", "cp_adminhelp", "cp_adminchat", "cp_warn_player", "cp_warn_admin"};

function PLUGIN:ChatBoxAdjustInfo(info)
	if (self.modifyIconClassList[info.class]) then
		self:ModifyIcon(info);
	end;

	if (info.data.anon and self.noAnonClassList[info.class]) then
		info.data.anon = false;
	end;
end;

function PLUGIN:GetPlayerScoreboardOptions(player, options, menu)
	local approve = Clockwork.command:FindByID("Approve");
	local charForceFallover = Clockwork.command:FindByID("CharForceFallover");
	local charSetArmor = Clockwork.command:FindByID("CharSetArmor");
	local charSetHealth = Clockwork.command:FindByID("CharSetHealth");
	local plyAddNote = Clockwork.command:FindByID("PlyAddNote");
	local plyBring = Clockwork.command:FindByID("PlyBring");
	local plyTP = Clockwork.command:FindByID("PlyTP");
	local plySend = Clockwork.command:FindByID("PlySend");
	local plyForceChar = Clockwork.command:FindByID("PlyForceChar");
	local plyFreeze = Clockwork.command:FindByID("PlyFreeze");
	local plyFreezeBring = Clockwork.command:FindByID("PlyFreezeBring");
	local plyFreezeTP = Clockwork.command:FindByID("PlyFreezeTP");
	local plyGod = Clockwork.command:FindByID("PlyGod");
	local plyIgnite = Clockwork.command:FindByID("PlyIgnite");
	local plyReset = Clockwork.command:FindByID("PlyReset");
	local plyRespawn = Clockwork.command:FindByID("PlyRespawn");
	local plyRespawnBring = Clockwork.command:FindByID("PlyRespawnBring");
	local plyRespawnStay = Clockwork.command:FindByID("PlyRespawnStay");
	local plyRespawnTP = Clockwork.command:FindByID("PlyRespawnTP");
	local plySetIcon = Clockwork.command:FindByID("PlysetIcon");
	local plySlay = Clockwork.command:FindByID("PlySlay");
	local plyViewRecord = Clockwork.command:FindByID("PlyViewRecord");
	local warn = Clockwork.command:FindByID("Warn");
	
	if (approve and Clockwork.player:HasFlags(Clockwork.Client, approve.access)) then
		options["Approve"] = function()
			RunConsoleCommand("cwCmd", "Approve", player:Name());
		end;
	end;
	
	if (charForceFallover and Clockwork.player:HasFlags(Clockwork.Client, charForceFallover.access)) then
		options["Force Fallover"] = function()
			Derma_StringRequest(player:Name(), "How long do you want to force them to fallover?", nil, function(time)
				Clockwork.kernel:RunCommand("CharForceFallover", player:Name(), time);
			end);
		end;
	end;

	if (charSetArmor and Clockwork.player:HasFlags(Clockwork.Client, charSetArmor.access)) then
		options["Set Armor"] = {};
		options["Set Armor"]["Full"] = function()
			Clockwork.kernel:RunCommand("CharSetArmor", player:Name());
		end;
		options["Set Armor"]["Custom"] = function()
			Derma_StringRequest(player:Name(), "What do you want to set their armor to?", nil, function(armor)
				Clockwork.kernel:RunCommand("CharSetArmor", player:Name(), armor);
			end);
		end;
	end;

	if (charSetHealth and Clockwork.player:HasFlags(Clockwork.Client, charSetHealth.access)) then
		options["Set Health"] = {};
		options["Set Health"]["Full"] = function()
			Clockwork.kernel:RunCommand("CharSetHealth", player:Name());
		end;
		options["Set Health"]["Custom"] = function()
			Derma_StringRequest(player:Name(), "What do you want to set their health to?", nil, function(armor)
				Clockwork.kernel:RunCommand("CharSetHealth", player:Name(), armor);
			end);
		end;
	end;

	if (plyAddNote and Clockwork.player:HasFlags(Clockwork.Client, plyAddNote.access)) then
		options["Add Note"] = function()
			Derma_StringRequest(player:Name(), "What do you want to note on their player record?", nil, function(note)
				Clockwork.kernel:RunCommand("PlyAddNote", player:Name(), note);
			end);
		end;
	end;

	if (plyForceChar and Clockwork.player:HasFlags(Clockwork.Client, plyForceChar.access)) then
		options["Force Char"] = function()
			Derma_StringRequest(player:Name(), "Which character do you want to force them to?", nil, function(char)
				Clockwork.kernel:RunCommand("PlyForceChar", player:Name(), char);
			end);
		end;
	end;

	if ((plyBring and Clockwork.player:HasFlags(Clockwork.Client, plyBring.access))
		or (plyTP and Clockwork.player:HasFlags(Clockwork.Client, plyTP.access))
		or (plySend and Clockwork.player:HasFlags(Clockwork.Client, plySend.access))) then

		options["Teleport"] = {};

		if (plyBring and Clockwork.player:HasFlags(Clockwork.Client, plyBring.access)) then
			options["Teleport"]["Bring"] = function()
				Clockwork.kernel:RunCommand("PlyBring", player:Name());
			end;
		end;

		if (plyTP and Clockwork.player:HasFlags(Clockwork.Client, plyTP.access)) then
			options["Teleport"]["Teleport"] = function()
				Clockwork.kernel:RunCommand("PlyTP", player:Name());
			end;
		end;

		if (plySend and Clockwork.player:HasFlags(Clockwork.Client, plySend.access)) then
			options["Teleport"]["Send"] = function()
				Derma_StringRequest(player:Name(), "Who do you want to send them to?", nil, function(target)
					Clockwork.kernel:RunCommand("PlySend", player:Name(), target);
				end);
			end;
		end;
	end;

	if ((plyFreezeBring and Clockwork.player:HasFlags(Clockwork.Client, plyFreezeBring.access))
		or (plyFreezeTP and Clockwork.player:HasFlags(Clockwork.Client, plyFreezeTP.access))
		or (plyFreeze and Clockwork.player:HasFlags(Clockwork.Client, plyFreeze.access))) then

		options["Freeze"] = {};

		if (plyFreezeBring and Clockwork.player:HasFlags(Clockwork.Client, plyFreezeBring.access)) then
			options["Freeze"]["Bring"] = function()
				Clockwork.kernel:RunCommand("PlyFreezeBring", player:Name());
			end;
		end;

		if (plyFreezeTP and Clockwork.player:HasFlags(Clockwork.Client, plyFreezeTP.access)) then
			options["Freeze"]["Teleport"] = function()
				Clockwork.kernel:RunCommand("PlyFreezeTP", player:Name());
			end;
		end;

		if (plyFreeze and Clockwork.player:HasFlags(Clockwork.Client, plyFreeze.access)) then
			options["Freeze"]["Freeze"] = function()
				Clockwork.kernel:RunCommand("PlyFreeze", player:Name());
			end;
		end;
	end;

	if (plyGod and Clockwork.player:HasFlags(Clockwork.Client, plyGod.access)) then
		options["God"] = function()
			RunConsoleCommand("cwCmd", "PlyGod", player:Name());
		end;
	end;

	if (plyIgnite and Clockwork.player:HasFlags(Clockwork.Client, plyIgnite.access)) then
		options["Ignite"] = function()
			Derma_StringRequest(player:Name(), "How long do you want to ignite them? (0 = extinguish)", nil, function(time)
				Clockwork.kernel:RunCommand("PlyIgnite", player:Name(), time);
			end);
		end;
	end;

	if (plyReset and Clockwork.player:HasFlags(Clockwork.Client, plyReset.access)) then
		options["Reset"] = function()
			RunConsoleCommand("cwCmd", "PlyReset", player:Name());
		end;
	end;

	if ((plyRespawnBring and Clockwork.player:HasFlags(Clockwork.Client, plyRespawnBring.access))
		or (plyRespawnTP and Clockwork.player:HasFlags(Clockwork.Client, plyRespawnTP.access))
		or (plyRespawnStay and Clockwork.player:HasFlags(Clockwork.Client, plyRespawnStay.access))
		or (plyRespawn and Clockwork.player:HasFlags(Clockwork.Client, plyRespawn.access))) then

		options["Respawn"] = {};

		if (plyRespawnBring and Clockwork.player:HasFlags(Clockwork.Client, plyRespawnBring.access)) then
			options["Respawn"]["Respawn"] = function()
				Clockwork.kernel:RunCommand("PlyRespawn", player:Name());
			end;
		end;

		if (plyRespawnBring and Clockwork.player:HasFlags(Clockwork.Client, plyRespawnBring.access)) then
			options["Respawn"]["Bring"] = function()
				Clockwork.kernel:RunCommand("PlyRespawnBring", player:Name());
			end;
		end;

		if (plyRespawnTP and Clockwork.player:HasFlags(Clockwork.Client, plyRespawnTP.access)) then
			options["Respawn"]["Teleport"] = function()
				Clockwork.kernel:RunCommand("PlyRespawnTP", player:Name());
			end;
		end;

		if (plyRespawnStay and Clockwork.player:HasFlags(Clockwork.Client, plyRespawnStay.access)) then
			options["Respawn"]["Stay"] = function()
				Clockwork.kernel:RunCommand("PlyRespawnStay", player:Name());
			end;
		end;
	end;

	if (plySetIcon and Clockwork.player:HasFlags(Clockwork.Client, plySetIcon.access)) then
		options["Set Icon"] = function()
			Derma_StringRequest(player:Name(), "What do you want to set their icon to?", nil, function(icon)
				Clockwork.kernel:RunCommand("PlySetIcon", player:Name(), icon);
			end);
		end;
	end;
	
	if (plySlay and Clockwork.player:HasFlags(Clockwork.Client, plySlay.access)) then
		options["Slay"] = function()
			Clockwork.kernel:RunCommand("PlySlay", player:Name());
		end;
	end;

	if (plyViewRecord and Clockwork.player:HasFlags(Clockwork.Client, plyViewRecord.access)) then
		options["View Record"] = function()
			RunConsoleCommand("cwCmd", "PlyViewRecord", player:Name());
		end;
	end;

	if (warn and Clockwork.player:HasFlags(Clockwork.Client, warn.access)) then
		options["Warn"] = function()
			Derma_StringRequest(player:Name(), "Warning?", nil, function(warning)
				Clockwork.kernel:RunCommand("Warn", player:Name(), warning);
			end);
		end;
	end;
end;

local init = false; -- Ensure everything is setup, even after a lua refresh
function PLUGIN:Think()
	if (!init) then
		Clockwork.plugin:Call("PreCheckpointInit", self);

		-- Flag to receive death notifications
		Clockwork.flag:Add(cwOption:GetKey("death_note_flag"), "Death Notification", "Get Death Notifications when someone dies.");


		-- Adjust the commands
		Clockwork.plugin:Call("AdjustCommands", Clockwork.command.stored);


		-- Change class list to have the classes as keys.
		local tempTable = {};
		for k, v in pairs(self.modifyIconClassList) do
			tempTable[v] = true;
		end;
		self.modifyIconClassList = tempTable;
		-- Adjust the class list.
		Clockwork.plugin:Call("AdjustModifyIconClassList", self.modifyIconClassList);



		-- Change no anon class list to have the classes as keys.
		tempTable = {};
		for k, v in pairs(self.noAnonClassList) do
			tempTable[v] = true;
		end;
		self.noAnonClassList = tempTable;
		-- Adjust the class list
		Clockwork.plugin:Call("AdjustNoAnonClassList", self.noAnonClassList);


		-- Get owner's steam ID
		Clockwork.datastream:Start("owner_steamid", {true});


		-- Post Checkpoint Init
		Clockwork.plugin:Call("PostCheckpointInit", self);


		-- Save CP's color.
		self.color = cwOption:GetColor("cp_color");
		MsgC(cwOption:GetKey("cp_color"), "[CP] Checkpoint "..self.CPVersion.." initialized.\n");
		
		init = true;
	end;
end;

Clockwork.datastream:Hook("owner_steamid", function(data)
	PLUGIN.ownerSteamID = data[1];
end);

Clockwork.datastream:Hook("play_sound", function(data)
	PLUGIN:PlaySoundQueue(data);
end);

Clockwork.datastream:Hook("stop_queue", function(data)
	for k, v in pairs(PLUGIN.soundQueues) do
		timer.Destroy("sound_queue_"..k);
		PLUGIN.soundQueues[k] = nil;
	end;
end);

Clockwork.datastream:Hook("view_player_record", function(data)
	local scrW = ScrW();
	local scrH = ScrH();

	local DermaPanel = vgui.Create("DFrame");
	DermaPanel:SetSize(512, 512);
	DermaPanel:SetPos((scrW / 2) - (DermaPanel:GetWide() / 2), (scrH / 2) - (DermaPanel:GetTall() / 2));
	if (data[3]) then
		DermaPanel:SetTitle("[CP] "..data[3].." ("..data[1]..")");
	else
		DermaPanel:SetTitle("[CP] "..data[1]);
	end;
	DermaPanel:SetVisible(true);
	DermaPanel:SetDraggable(true);
	DermaPanel:ShowCloseButton(true);

	local DTextEntry = vgui.Create("DTextEntry", DermaPanel);
	DTextEntry:SetPos(5, 28);
	DTextEntry:SetSize(DTextEntry:GetParent():GetWide() - 10, DTextEntry:GetParent():GetTall() - 33);

	local textTable = {};
	local rtrn = nil;
	local data2 = data[2];
	for k, v in ipairs(data2) do
		rtrn = PLUGIN:FormatRecordEntry(k, v);
		if (rtrn) then
			textTable[#textTable + 1] = rtrn;
		end;
	end;
	DTextEntry:SetText(table.concat(textTable, "\n"));
	
	DTextEntry:SizeToContents();
	DTextEntry:SetEditable(false);
	DTextEntry:SetMultiline(true);

	DermaPanel:MakePopup();
end);