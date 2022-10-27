
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

PLUGIN.recordEntryTypes = {};
PLUGIN.soundQueues = {};

local cwOption = Clockwork.option;
local cwConfig = Clockwork.config;

cwConfig:AddToSystem("[CP] Admin Help Interval", "admin_help_interval", "Sets the minimum time between admin help messages.", 0, 120, 0);
cwConfig:AddToSystem("[CP] Disable Player Punching", "disable_player_punching", "Prevents players from punching other players.", 0, 120, 0);
cwConfig:AddToSystem("[CP] Use Admin Approve", "use_admin_approve", "Use the Admin Approve system.", 0, 1, 0);
cwConfig:AddToSystem("[CP] Use CP Notify", "use_cp_notify", "Use Checkpoint's notifications with icons instead of default clockwork notifications.", 0, 1, 0);
cwConfig:AddToSystem("[CP] Use Death Notifications", "use_death_notifications", "Notify admins of a player's death.", 0, 1, 0);
cwConfig:AddToSystem("[CP] Allow Admin SWEP", "allow_admin_swep", "Allow admins to spawn SWEP's.", 0, 1, 0);
cwConfig:AddToSystem("[CP] Allow Admin SENT", "allow_admin_sent", "Allow admins to spawn SENT's.", 0, 1, 0);
cwConfig:AddToSystem("[CP] Allow Operator SWEP", "allow_operator_swep", "Allow operators to spawn SWEP's.", 0, 1, 0);
cwConfig:AddToSystem("[CP] Allow Operator SENT", "allow_operator_sent", "Allow operators to spawn SENT's.", 0, 1, 0);
cwConfig:AddToSystem("[CP] Global Echo", "global_echo", "Notifies everyone if a command is used.", 0, 1, 0);
cwConfig:AddToSystem("[CP] Always Override Chat Icon", "always_override_chat_icon", "Always override chat icons  (including C16 icons).", 0, 1, 0);

cwOption:SetColor("cp_color", Color(0, 114, 188, 255));

cwOption:SetKey("sound_alias", {
	["vort1"] = "vo/outland_01/intro/ol01_vortcall01.wav",
	["vort2"] = "vo/outland_01/intro/ol01_vortresp01.wav",
	["vort3"] = "vo/outland_01/intro/ol01_vortcall02c.wav",
	["vort4"] = "vo/outland_01/intro/ol01_vortresp04.wav",
	["alarm"] = "ambient/alarms/alarm_citizen_loop1.wav",
	["scream"] = "ambient/creatures/town_child_scream1.wav",
	["battle1"] = "ambient/explosions/battle_loop1.wav",
	["battle2"] = "ambient/explosions/battle_loop2.wav",
	["warning"] = "hl1/fvox/warning.wav",
	["evacuate"] = "hl1/fvox/evacuate_area.wav",
	["heat_damage"] = "hl1/fvox/heat_damage.wav",
	["shock_damage"] = "hl1/fvox/shock_damage.wav",
	["armor_gone"] = "hl1/fvox/armor_gone.wav",
	["bio_reading"] = "hl1/fvox/bio_reading.wav",
	["biohazard_detected"] = "hl1/fvox/biohazard_detected.wav",
	["chemical_detected"] = "hl1/fvox/chemical_detected.wav",
	["radiation_detected"] = "hl1/fvox/radiation_detected.wav",
	["targetting_system"] = "hl1/fvox/targetting_system.wav",
	["activated"] = "hl1/fvox/activated.wav",
	["deactivated"] = "hl1/fvox/deactivated.wav",
	["immediately"] = "hl1/fvox/immediately.wav",
	["power_is"] = "hl1/fvox/power_level_is.wav",
	["power_restored"] = "hl1/fvox/power_restored.wav",
	["onehundred"] = "hl1/fvox/onehundred.wav",
	["ninety"] = "hl1/fvox/ninety.wav",
	["eight"] = "hl1/fvox/eight.wav",
	["seventy"] = "hl1/fvox/seventy.wav",
	["sixty"] = "hl1/fvox/sixty.wav",
	["fifty"] = "hl1/fvox/fifty.wav",
	["fourty"] = "hl1/fvox/fourty.wav",
	["thirty"] = "hl1/fvox/thirty.wav",
	["twenty"] = "hl1/fvox/twenty.wav",
	["fifteen"] = "hl1/fvox/fifteen.wav",
	["ten"] = "hl1/fvox/ten.wav",
	["five"] = "hl1/fvox/five.wav",
	["percent"] = "hl1/fvox/percent.wav",
	["collaboration"] = {"vo/Breencast/br_collaboration01.wav",
		"vo/Breencast/br_collaboration02.wav",
		"vo/Breencast/br_collaboration03.wav",
		"vo/Breencast/br_collaboration04.wav",
		"vo/Breencast/br_collaboration05.wav",
		"vo/Breencast/br_collaboration06.wav",
		"vo/Breencast/br_collaboration07.wav",
		"vo/Breencast/br_collaboration08.wav",
		"vo/Breencast/br_collaboration09.wav",
		"vo/Breencast/br_collaboration10.wav",
		"vo/Breencast/br_collaboration11.wav"
	},
	["disruptor"] = {"vo/Breencast/br_disruptor01.wav",
		"vo/Breencast/br_disruptor02.wav",
		"vo/Breencast/br_disruptor03.wav",
		"vo/Breencast/br_disruptor04.wav",
		"vo/Breencast/br_disruptor05.wav",
		"vo/Breencast/br_disruptor06.wav",
		"vo/Breencast/br_disruptor07.wav",
		"vo/Breencast/br_disruptor08.wav"
	},
	["instinct"] = {"vo/Breencast/br_instinct01.wav",
		"vo/Breencast/br_instinct02.wav",
		"vo/Breencast/br_instinct03.wav",
		"vo/Breencast/br_instinct04.wav",
		"vo/Breencast/br_instinct05.wav",
		"vo/Breencast/br_instinct06.wav",
		"vo/Breencast/br_instinct07.wav",
		"vo/Breencast/br_instinct08.wav",
		"vo/Breencast/br_instinct09.wav",
		"vo/Breencast/br_instinct10.wav",
		"vo/Breencast/br_instinct11.wav",
		"vo/Breencast/br_instinct12.wav",
		"vo/Breencast/br_instinct13.wav",
		"vo/Breencast/br_instinct14.wav",
		"vo/Breencast/br_instinct15.wav",
		"vo/Breencast/br_instinct16.wav",
		"vo/Breencast/br_instinct17.wav",
		"vo/Breencast/br_instinct18.wav",
		"vo/Breencast/br_instinct19.wav",
		"vo/Breencast/br_instinct20.wav",
		"vo/Breencast/br_instinct21.wav",
		"vo/Breencast/br_instinct22.wav",
		"vo/Breencast/br_instinct23.wav",
		"vo/Breencast/br_instinct24.wav",
		"vo/Breencast/br_instinct25.wav"
	},
	["overwatch"] = {"vo/Breencast/br_overwatch01.wav",
		"vo/Breencast/br_overwatch02.wav",
		"vo/Breencast/br_overwatch03.wav",
		"vo/Breencast/br_overwatch04.wav",
		"vo/Breencast/br_overwatch05.wav",
		"vo/Breencast/br_overwatch06.wav",
		"vo/Breencast/br_overwatch07.wav",
		"vo/Breencast/br_overwatch08.wav",
		"vo/Breencast/br_overwatch09.wav"
	},
	["freeman"] = {"vo/Breencast/br_tofreeman01.wav",
		"vo/Breencast/br_tofreeman02.wav",
		"vo/Breencast/br_tofreeman03.wav",
		"vo/Breencast/br_tofreeman04.wav",
		"vo/Breencast/br_tofreeman05.wav",
		"vo/Breencast/br_tofreeman06.wav",
		"vo/Breencast/br_tofreeman07.wav",
		"vo/Breencast/br_tofreeman08.wav",
		"vo/Breencast/br_tofreeman09.wav",
		"vo/Breencast/br_tofreeman10.wav",
		"vo/Breencast/br_tofreeman11.wav",
		"vo/Breencast/br_tofreeman12.wav"
	},
	["welcome"] = {"vo/Breencast/br_welcome01.wav",
		"vo/Breencast/br_welcome02.wav",
		"vo/Breencast/br_welcome03.wav",
		"vo/Breencast/br_welcome04.wav",
		"vo/Breencast/br_welcome05.wav",
		"vo/Breencast/br_welcome06.wav",
		"vo/Breencast/br_welcome07.wav"
	},
	["allknowingvort"] = {"vo/npc/vortigaunt/vmono_03.wav",
		"vo/npc/vortigaunt/vmono_04.wav",
		"vo/npc/vortigaunt/vmono_05.wav",
		"vo/npc/vortigaunt/vmono_06.wav",
		"vo/npc/vortigaunt/vmono_07.wav",
		"vo/npc/vortigaunt/vmono_08.wav",
		"vo/npc/vortigaunt/vmono_09.wav",
		"vo/npc/vortigaunt/vmono_10.wav",
		"vo/npc/vortigaunt/vmono_11.wav",
		"vo/npc/vortigaunt/vmono_12.wav",
		"vo/npc/vortigaunt/vmono_13.wav",
		"vo/npc/vortigaunt/vmono_14.wav",
		"vo/npc/vortigaunt/vmono_15.wav",
		"vo/npc/vortigaunt/vmono_16.wav",
		"vo/npc/vortigaunt/vmono_17.wav",
		"vo/npc/vortigaunt/vmono_18.wav",
		"vo/npc/vortigaunt/vmono_19.wav",
		"vo/npc/vortigaunt/vmono_20.wav",
		"vo/npc/vortigaunt/vmono_21.wav",
		"vo/npc/vortigaunt/vmono_22.wav",
		"vo/npc/vortigaunt/vmono_23.wav",
		"vo/npc/vortigaunt/vmono_24.wav",
		"vo/npc/vortigaunt/vmono_25.wav",
		"vo/npc/vortigaunt/vmono_26.wav",
		"vo/npc/vortigaunt/vmono_27.wav",
		"vo/npc/vortigaunt/vmono_28.wav",
		"vo/npc/vortigaunt/vmono_29.wav",
		"vo/npc/vortigaunt/vmono_30.wav"
	}
});

-- Admin help
Clockwork.chatBox:RegisterClass("cp_adminhelp", nil, function(info)
	local color = _team.GetColor(info.speaker:Team());
	Clockwork.chatBox:Add(info.filtered, info.icon, PLUGIN.color, "[CP] ", "@AHelp ", color, info.name, " (", color, info.speaker:SteamName(), "): ", info.text);
end);

-- Admin chat
Clockwork.chatBox:RegisterClass("cp_adminchat", nil, function(info)
	Clockwork.chatBox:Add(info.filtered, info.icon, PLUGIN.color, "[CP] ", "@", _team.GetColor(info.speaker:Team()), info.name, ": ", info.text);
end);

Clockwork.chatBox:RegisterClass("cp_announce", nil, function(info)
	Clockwork.chatBox:Add(info.filtered, "icon16/information.png", PLUGIN.color, "[CP] ", info.text);
end);

-- Warning
Clockwork.chatBox:RegisterClass("cp_warn_player", nil, function(info)
	Clockwork.chatBox:Add(info.filtered, info.icon, PLUGIN.color, "[CP] ", "@WARNING ", "from ", PLUGIN.color, info.speaker:SteamName(), ": ", info.text);
end);
Clockwork.chatBox:RegisterClass("cp_warn_admin", nil, function(info)
	Clockwork.chatBox:Add(info.filtered, info.icon, PLUGIN.color, "[CP] ", _team.GetColor(info.speaker:Team()), info.speaker:SteamName(), " has warned ",
		info.data.targetColor, info.data.targetName, ": ", info.text);
end);

-- Death notifications
Clockwork.chatBox:RegisterClass("cp_deathnotification", nil, function(info)
	Clockwork.chatBox:Add(info.filtered, "icon16/exclamation.png", PLUGIN.color, "[CP] ", info.data.attackerColor, info.data.attackerName, " has killed ", info.data.playerColor, info.data.playerName, "!");
end);

-- Admin Approve message
Clockwork.chatBox:RegisterClass("cp_unapprovedplayer", nil, function(info)
	Clockwork.chatBox:Add(info.filtered, "icon16/new.png", PLUGIN.color, "[CP] ", info.data.color, info.text, " (OOC: ", info.data.ooc, ") has spawned and isn't approved yet.");
end);

-- Updated connect message
Clockwork.chatBox:RegisterClass("cp_connect", nil, function(info)
	local filtered = (CW_CONVAR_SHOWAURA:GetInt() == 0) or info.filtered;
	local icon = info.data.icon or "user_add";

	Clockwork.chatBox:Add(filtered, "icon16/"..icon..".png", Color(150, 150, 200, 255), info.text.." has connected to the server.");
end);

-- CP Notify
Clockwork.chatBox:RegisterClass("cp_notify", nil, function(info)
	local filtered = (CW_CONVAR_SHOWAURA:GetInt() == 0) or info.filtered;
	
	local icon = info.data.icon or "comment";
	if (string.sub(info.text, -1) == "!") then
		icon = info.data.icon or "error";
	end;

		local color = Color(255, 255, 255, 255);

	Clockwork.chatBox:Add(filtered, "icon16/"..icon..".png", PLUGIN.color, "[CP] ", color, info.text);
end);

-- Updated admin chat
Clockwork.chatBox:RegisterClass("priv", nil, function(info)
	Clockwork.chatBox:Add(info.filtered, info.icon, PLUGIN.color, "[CP] ", "@"..info.data.userGroup, _team.GetColor(info.speaker:Team()), info.name, ": ", info.text);
end);

-- Updated LOOC
Clockwork.chatBox:RegisterClass("looc", nil, function(info)
	Clockwork.chatBox:Add(info.filtered, info.icon, Color(225, 50, 50, 255), "[LOOC] ", Color(255, 255, 150, 255), info.name..": "..info.text);
end);

function PLUGIN:PlaySoundQueue(soundQueue, index)
	if (index) then
		if (!self.soundQueues[index]) then
			return;
		end;
	else
		index = table.insert(self.soundQueues, soundQueue);
	end;

	local soundAlias = Clockwork.option:GetKey("sound_alias");
	local sound = soundQueue[1];
	if (!sound) then
		return;
	else
		table.remove(soundQueue, 1);
	end;
	
	if (soundAlias[string.lower(sound)]) then
		sound = soundAlias[string.lower(sound)];

		if (type(sound) == "table") then
			for i = #sound, 2, -1 do
				table.insert(soundQueue, 1, sound[i]);
			end;

			sound = sound[1];
		end;
	end;

	surface.PlaySound(sound);

	if (soundQueue[1] and self.soundQueues[index]) then
		timer.Create("sound_queue_"..index, SoundDuration(sound), 1, function()
			self:PlaySoundQueue(soundQueue, index);
		end);
	else
		self.soundQueues[index] = nil;
	end;
end;

local defaultIcons = {
	["icon16/shield.png"] = true,
	["icon16/star.png"] = true,
	["icon16/emoticon_smile.png"] = true,
	["icon16/add.png"] = true,
	["icon16/user.png"] = true
}

-- Modify the chat icon
function PLUGIN:ModifyIcon(info)
	local player = info.speaker;
	if (player) then
		local icon = self:GetPlayerIcon(player);
		if (Clockwork.config:Get("always_override_chat_icon"):Get(false) or
			icon != cwOption:GetKey("default_chat_icon") or
			(icon == cwOption:GetKey("default_chat_icon") and defaultIcons[info.icon])) then

			info.icon = "icon16/"..icon..".png";
		end;
	else
	    if (info.name == "Console") then
	    	info.icon = "icon16/monitor.png";
	    end;
	end;
end;

function PLUGIN:RegisterEntryType(entryType, callback)
	self.recordEntryTypes[entryType] = callback;
end;

function PLUGIN:FormatRecordEntry(k, tbl)
	local entryType = tbl.logType;
	if (!entryType) then
		return "";
	end;
	
	local entryText = k..".  "..self:GetDatePrefix(tbl.time, true).." ";
	if (self.recordEntryTypes[entryType]) then
		entryText = entryText..self.recordEntryTypes[entryType](k, tbl);
	elseif (entryType == "ban") then
		entryText = entryText.."BAN\n    "..tbl.player.." ";
		if (tbl.addedBy) then
			entryText = entryText.."by "..tbl.addedBy.." ";
		end;
		if (tbl.duration == 0) then
			entryText = entryText.."indefinitely ";
		else
			entryText = entryText.."for "..math.Round(tbl.duration / 60).." minutes ";
		end;
		entryText = entryText.."with reason: "..tbl.text;
	elseif (entryType == "unban") then
		entryText = entryText.."UNBAN\n    ";
		if (tbl.addedBy) then
			entryText = entryText.."by "..tbl.addedBy;
		end;
	elseif (entryType == "warn") then
		entryText = entryText.."WARNING\n    "..tbl.player.." ";
		if (tbl.addedBy) then
			entryText = entryText.."by "..tbl.addedBy.." ";
		end;
		entryText = entryText.."for: "..tbl.text;
	elseif (entryType == "kick") then
		entryText = entryText.."KICK\n    "..tbl.player.." ";
		if (tbl.addedBy) then
			entryText = entryText.."by "..tbl.addedBy.." ";
		end;
		entryText = entryText.."for: "..tbl.text;
	elseif (entryType == "note") then
		entryText = entryText.."NOTE\n    "..tbl.player.." ";
		if (tbl.addedBy) then
			entryText = entryText.."by "..tbl.addedBy.." ";
		end;
		entryText = entryText..": "..tbl.text;
	elseif (entryType == "approve") then
		entryText = entryText.."APPROVE\n    "..tbl.player.." by "..tbl.addedBy;
	elseif (entryType == "firstJoin") then
		entryText = entryText.."FIRST JOIN";
	else
		return nil;
	end;

	return entryText;
end;

function PLUGIN:GetDatePrefix(date, includeTime)
	-- Get date table
	local dataTable = os.date("*t", date);
	-- Ensure everything is two characters long
	if (dataTable.month < 10) then dataTable.month = "0"..dataTable.month; end;
	if (dataTable.day < 10) then dataTable.day = "0"..dataTable.day; end;
	local text = dataTable.year.."-"..dataTable.month.."-"..dataTable.day.."";

	if (includeTime) then
		if (dataTable.hour < 10) then dataTable.hour = "0"..dataTable.hour; end;
		if (dataTable.min < 10) then dataTable.min = "0"..dataTable.min; end;
		if (dataTable.sec < 10) then dataTable.sec = "0"..dataTable.sec; end;
		-- Return prefix
		return text.." "..dataTable.hour..":"..dataTable.min..":"..dataTable.sec.."";
	else
		return text;
	end;
end;