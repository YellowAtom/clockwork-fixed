--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Unknown Cassette";
ITEM.uniqueID = "unknown_cassette";
ITEM.cost = 32;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = false;
ITEM.description = "A cursed cassette from a land far away...";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Unknown", {
		{
			name = "Meow Meow Billi Karti",
			length = 123,
			url = "https://dl.dropboxusercontent.com/s/e7fvy9hf2xuxclv/Meow%20Meow%20Billi%20_%20Hindi%20Nursery%20Rhymes%20_%20Hindi%20Song%20For%20Kids%20_%20%E0%A4%AE%E0%A5%8D%E0%A4%AF%E0%A4%BE%E0%A4%8A%E0%A4%81%20%E0%A4%AE%E0%A5%8D%E0%A4%AF%E0%A4%BE%E0%A4%8A%E0%A4%81%20_%20Hindi%20Balgeet%20Songs.mp3?dl=0"
		},
		{
			name = "Long Gone",
			length = 141,
			url = "https://dl.dropboxusercontent.com/s/5ucabl53htfrpm0/Fietsopa%20Song%20-%20long%20gone.mp3?dl=0"
		},
		{
			name = "Spoiday",
			length = 229,
			url = "https://dl.dropboxusercontent.com/s/sc42361by3nevm8/Spoiday%20-%20Spoidorovich%20Candekattsen%20ft.%20Grav1ty%20C%40.mp3?dl=0"
		},
		{
			name = "Line 32",
			length = 119,
			url = "https://dl.dropboxusercontent.com/s/om6prfafxfxjhlo/clexolamp_music.ogg?dl=0"
		},
		{
			name = "Baba Mama",
			length = 120,
			url = "https://dl.dropboxusercontent.com/s/35yovs1fa99rtja/Baba%20Mama%20Baba%20Mama%20song%20from%20the%20Youtube%20Ad.mp3?dl=0"
		}	
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();