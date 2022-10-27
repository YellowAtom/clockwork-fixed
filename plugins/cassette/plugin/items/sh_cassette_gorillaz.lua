--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "The Gorillaz";
ITEM.uniqueID = "gorillaz_cassette";
ITEM.cost = 200;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A red cassette tape with the word 'Gorillaz' painted on with a black paint marker.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Gorillaz", {
		{
			name = "Feel Good Inc.",
			length = 221,
			url = "https://dl.dropboxusercontent.com/s/s1esu3v8vpa3lsf/Gorillaz%20-%20Feel%20Good%20Inc.%20Lyrics.mp3?dl=0"
		},
		{
			name = "Saturnz Barz",
			length = 181,
			url = "https://dl.dropboxusercontent.com/s/szezi1u29ri09ug/Saturnz%20Barz%20%28feat.%20Popcaan%29.mp3?dl=0"
		},
		{
			name = "Let Me Out",
			length = 175,
			url = "https://dl.dropboxusercontent.com/s/hr2ox1k6490aok5/Gorillaz%20-%20Let%20Me%20Out%20%28Official%20Audio%29.mp3?dl=0"
		},
		{
			name = "Clint Eastwood",
			length = 267,
			url = "https://dl.dropboxusercontent.com/s/qgne79pvisnboca/Gorillaz-Clint%20Eastwood%20%28Lyrics%29.mp3?dl=0"
		},
		{
			name = "Stylo",
			length = 271,
			url = "https://dl.dropboxusercontent.com/s/zlj40wgx4q10u90/Stylo%20-%20Gorillaz%20%28Highest%20Quality%29.mp3?dl=0"
		},
		{
			name = "Humility",
			length = 198,
			url = "https://dl.dropboxusercontent.com/s/zq2p547qz24ctmr/Humility%20%28feat.%20George%20Benson%29.mp3?dl=0"
		},
		{
			name = "Tomorrow Comes Today",
			length = 193,
			url = "https://dl.dropboxusercontent.com/s/dhj1aeknrls6aj5/Gorillaz-Tomorrow%20Comes%20Today.mp3?dl=0"
		},
		{
			name = "Andromeda",
			length = 197,
			url = "https://dl.dropboxusercontent.com/s/j1ymsl6sjyicq06/Gorillaz%20-%20Andromeda%20%28Official%20Audio%29.mp3?dl=0"
		},
		{
			name = "Melancholy Hill",
			length = 225,
			url = "https://dl.dropboxusercontent.com/s/i4nfu28yh6q55c5/Gorillaz%20-%20On%20Melancholy%20Hill%20%28lyrics%29.mp3?dl=0"
		},
		{
			name = "O Green World",
			length = 271,
			url = "https://dl.dropboxusercontent.com/s/kindz6f590u0kgt/Gorillaz-O%20Green%20World.mp3?dl=0"
		},
		{
			name = "Kids With Guns",
			length = 226,
			url = "https://dl.dropboxusercontent.com/s/4t6ritqqpws0695/Gorillaz%20-%20Kids%20With%20Guns%20%28Official%20Video%29.mp3?dl=0"
		}
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();