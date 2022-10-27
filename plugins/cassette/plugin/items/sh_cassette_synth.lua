--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Synthwave Techno";
ITEM.uniqueID = "synth_cassette";
ITEM.cost = 150;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A black cassette with a cool looking 80s retro grid pattern on it.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Synth", {
		{
			name = "Systematic",
			length = 319,
			url = "https://dl.dropboxusercontent.com/s/bmqi9yxsjsfu7uv/Garth%20Knight%20-%20Systematic.mp3?dl=0"
		},
		{
			name = "Dance in Space",
			length = 358,
			url = "https://dl.dropboxusercontent.com/s/np6rej13yotzj18/Abelard%20-%20Dance%20In%20Space.mp3?dl=0"
		},
		{
			name = "Cheap Talk",
			length = 392,
			url = "https://dl.dropboxusercontent.com/s/k1qan6xz6u8qqm7/Abelard%20-%20Cheap%20Talk.mp3?dl=0"
		},
		{
			name = "Death March",
			length = 241,
			url = "https://dl.dropboxusercontent.com/s/qst7zzjdss2t9t8/OBNX%20-%20March%20Of%20Death.mp3?dl=0"
		},
		{
			name = "Resonance",
			length = 213,
			url = "https://dl.dropboxusercontent.com/s/xkuczqgoyrcplct/HOME%20-%20Resonance.mp3?dl=0"
		},
		{
			name = "Death to Trators",
			length = 531,
			url = "https://dl.dropboxusercontent.com/s/6zdv38ikf2eijpn/Death%20to%20Traitors.mp3?dl=0"
		},
		{
			name = "Blizzard",
			length = 192,
			url = "https://dl.dropboxusercontent.com/s/z3sgusk4984zn7b/Hotline%20Miami%202%20Wrong%20Number%20Soundtrack%20-%20Blizzard.mp3?dl=0"
		},
		{
			name = "Burning Coals",
			length = 241,
			url = "https://dl.dropboxusercontent.com/s/qst7zzjdss2t9t8/OBNX%20-%20March%20Of%20Death.mp3?dl=0"
		},
		{
			name = "Dust",
			length = 302,
			url = "https://dl.dropboxusercontent.com/s/zyid9l2wsh61lys/M.O.O.N%20-%20Dust.mp3?dl=0"
		}
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();