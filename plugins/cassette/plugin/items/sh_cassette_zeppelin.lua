--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Led Zeppelin";
ITEM.uniqueID = "zeppelin_cassette";
ITEM.cost = 80;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A black cassette tape with 'Led-Zeppelin' written in white on the back.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Zeppelin", {
		{
			name = "Immigrant Song",
			length = 146,
			url = "https://dl.dropboxusercontent.com/s/81v1ee8k6hx8kcy/Immigrant%20Song.mp3?dl=0"
		},
		{
			name = "Black Dog",
			length = 295,
			url = "https://dl.dropboxusercontent.com/s/vyjtznncdmuhj79/Black%20Dog%20%282007%20Remaster%29.mp3?dl=0"
		},
		{
			name = "Levee Breaks",
			length = 430,
			url = "https://dl.dropboxusercontent.com/s/5wnz0hasc4gzokt/When%20the%20Levee%20Breaks%20%282007%20Remaster%29.mp3?dl=0"
		},
		{
			name = "Dazed & Confused",
			length = 391,
			url = "https://dl.dropboxusercontent.com/s/9crz8wwb4msx18v/Led%20Zeppelin-%20Dazed%20and%20Confused.mp3?dl=0"
		},
		{
			name = "Stairway To Heaven",
			length = 482,
			url = "https://dl.dropboxusercontent.com/s/4o4qzcg21iiqg19/Led%20Zeppelin%20-%20Stairway%20To%20Heaven%20%28Official%20Audio%29.mp3?dl=0"
		},
		{
			name = "Kashmir",
			length = 517,
			url = "https://dl.dropboxusercontent.com/s/if65xwyfk763jlk/Kashmir%20%282007%20Remaster%29.mp3?dl=0"
		}
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();