--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Pop Cassette";
ITEM.uniqueID = "pop_cassette";
ITEM.cost = 85;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A trashy looking pink casette with the word 'Pop' written in orange marker.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Pop", {
		{
			name = "Blush - Undivided Ft. Snoop Dogg",
			length = 247,
			url = "https://dl.dropboxusercontent.com/s/hkk560uq807mcae/Blush%20-%20Undivided%20featuring%20Snoop%20Dogg%20%20%5BOfficial%20Music%20Video%5D.mp3?dl=0"
		},
		{
			name = "Lay a Little Sunshine on Me",
			length = 190,
			url = "https://dl.dropboxusercontent.com/s/hio2hkll0zz3lin/Lay%20a%20Little%20Sunshine%20on%20Me.mp3?dl=0"
		},
		{
			name = "Europe - The Final Countdown",
			length = 310,
			url = "https://dl.dropboxusercontent.com/s/8qovss242ajiurb/Europe%20-%20The%20Final%20Countdown%28with%20lyrics%29.mp3?dl=0"
		},
		{
			name = "Timbaland - The Way I Are",
			length = 213,
			url = "https://dl.dropboxusercontent.com/s/d2zdxdrg7vvjikq/Timbaland%20-%20The%20Way%20I%20Are%20ft.%20Keri%20Hilson%20D.O.E.%20Sebastian.mp3?dl=0"
		},
		{
			name = "Ellie Goulding - Love Me Like You Do",
			length = 249,
			url = "https://dl.dropboxusercontent.com/s/ngiszfaj12jm6dx/Ellie%20Goulding%20-%20Love%20Me%20Like%20You%20Do%20%28Official%20Video%29.mp3?dl=0"
		},
		{
			name = "The Weeknd - Earned It",
			length = 251,
			url = "https://dl.dropboxusercontent.com/s/g661vpax72heyb5/The%20Weeknd%20-%20Earned%20It%20%28Fifty%20Shades%20Of%20Grey%29%20%28Lyric%20Video%29.mp3?dl=0"
		},
		{
			name = "Fat Albert - Party Theme",
			length = 206,
			url = "https://dl.dropboxusercontent.com/s/whw041u4pe9xkdm/Fat%20Albert%20Party%20Theme%20%28From%20the%20Movie%29.mp3?dl=0"
		},
		{
			name = "Lady Gaga - Applause",
			length = 213,
			url = "https://dl.dropboxusercontent.com/s/pjq8hxf0lqed863/Lady%20Gaga%20-%20Applause%20LYRICS.mp3?dl=0"
		},
		{
			name = "Lady Gaga - Bad Romance",
			length = 304,
			url = "https://dl.dropboxusercontent.com/s/3mvx0f62p7scv2z/lady%20gaga%20-%20Bad%20Romance%20-%20Lyrics%20on%20screen.mp3?dl=0"
		},
		{
			name = "Cassie - Me And You",
			length = 201,
			url = "https://dl.dropboxusercontent.com/s/ax8tyf9gu5arqpp/cassie%20Me%20And%20You%20Lyrics..mp3?dl=0"
		},
		{
			name = "I Gotta Feeling - The Black Eyed Peas",
			length = 240,
			url = "https://dl.dropboxusercontent.com/s/efmikvk5f22pqyv/I%20Gotta%20Feeling%20-%20The%20Black%20Eyed%20Peas%20%28with%20lyrics%29.mp3?dl=0"
		}	
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();