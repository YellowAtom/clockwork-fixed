--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Wild West Cassette";
ITEM.uniqueID = "wild_west_cassette";
ITEM.cost = 97;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A blue cassette with the words 'Wild West Hits' written on it in yellow marker.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Wild West", {
		{
			name = "No Expectations",
			length = 200,
			url = "https://dl.dropboxusercontent.com/s/3lvhb24n4b45xlx/Red%20Dead%20Redemption%202%20Official%20Soundtrack%20-%20No%20Expectations%20_%20HD%20%28With%20Visualizer%29.mp3?dl=0"
		},
		{
			name = "Come Live By My Side",
			length = 176,
			url = "https://dl.dropboxusercontent.com/s/13dc6fuxliltgaz/Red%20Dead%20Redemption%202%20Official%20Soundtrack%20-%20Come%20Live%20By%20My%20Side%20_%20HD%20%28With%20Visualizer%29.mp3?dl=0"
		},
		{
			name = "Big Bad John - Jimmy Dean",
			length = 180,
			url = "https://dl.dropboxusercontent.com/s/xbztfkxbf6qlgzx/BIG%20BAD%20JOHN%20_%20Jimmy%20Dean%20%20%281961%29.mp3?dl=0"
		},
		{
			name = "Sixteen Tons - Ernie Ford",
			length = 155,
			url = "https://dl.dropboxusercontent.com/s/mhssalr38q93ghf/SIXTEEN%20TONS%20-%20Tennesse%20Ernie%20Ford%20w-%20Lyrics.mp3?dl=0"
		},
		{
			name = "That's The Way It Is",
			length = 191,
			url = "https://dl.dropboxusercontent.com/s/vkn0b5ximigm0ip/Red%20Dead%20Redemption%202%20Official%20Soundtrack%20-%20That%27s%20The%20Way%20It%20Is%20_%20HD%20%28With%20Visualizer%29.mp3?dl=0"
		},
		{
			name = "Cruel, Cruel World",
			length = 214,
			url = "https://dl.dropboxusercontent.com/s/inbvhp0wotqrnxk/Red%20Dead%20Redemption%202%20Official%20Soundtrack%20-%20Cruel%2C%20Cruel%20World%20%28ending%20music%29%20_%20HD%20%28With%20Visualizer%29.mp3?dl=0"	
		}
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();