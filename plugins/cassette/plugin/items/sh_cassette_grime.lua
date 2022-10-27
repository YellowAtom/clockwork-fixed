--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Grime Cassette";
ITEM.uniqueID = "grime_cassette";
ITEM.cost = 90;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05
ITEM.batch = 1;
ITEM.access = "v";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "This cassette literally has a brown stain on it, who would do this? The brown stain is covering most of what appears to be the word 'Grime' written on it in black marker.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Grime", {
		{
			name = "Headie One - Both",
			length = 213,
			url = "https://dl.dropboxusercontent.com/s/v6quhre31yba32g/Headie%20One%20-%20Both.mp3?dl=0"
		},
		{
			name = "Headie One - 18HUNNA",
			length = 191,
			url = "https://dl.dropboxusercontent.com/s/sr48jetplquh3yc/Headie%20One%20-%2018HUNNA%20%28ft.%20Dave%29.mp3?dl=0"
		},
		{
			name = "Man Don't Care - JME ft. Giggs",
			length = 209,
			url = "https://dl.dropboxusercontent.com/s/w9s5f5i7lj4unmo/Man%20Don%27t%20Care%20-%20Jme%20ft%20Giggs.mp3?dl=0"
		},
		{
			name = "That's not me - Skepta ft. JME",
			length = 189,
			url = "https://dl.dropboxusercontent.com/s/h6wabrqicjcvsc3/Skepta%20ft.%20JME%20-%20That%27s%20Not%20Me%20%28Official%20Video%29.mp3?dl=0"
		},
		{
			name = "Rain - Aitch x AJ Tracey ft. Tay Keith",
			length = 185,
			url = "https://dl.dropboxusercontent.com/s/sstxospl4we5r2t/Aitch%20x%20AJ%20Tracey%20-%20Rain%20Feat.%20Tay%20Keith%20%28Official%20Video%29.mp3?dl=0"
		},
		{
			name = "Ei8ht Mile - Digdat x Aitch",
			length = 192,
			url = "https://dl.dropboxusercontent.com/s/40xwp7fxkxntpca/DigDat%20x%20Aitch%20-%20Ei8ht%20Mile%20_Music%20Video_%20_%20GRM%20Daily.mp3?dl=0"
		},
		{
			name = "I dunno - Tion Wayne x Dutchavelli x Stormzy",
			length = 177,
			url = "https://dl.dropboxusercontent.com/s/urnml1y0oukqkbu/Tion%20Wayne%20x%20Dutchavelli%20x%20Stormzy%20-%20I%20Dunno%20_Music%20Video_%20_%20GRM%20Daily.mp3?dl=0"
		},
		{
			name = "Mr Sheen - Digga D x Russ",
			length = 231,
			url = "https://dl.dropboxusercontent.com/s/wrhqkr4ah275488/Digga%20D%20x%20Russ%20%28MB%29%20%20-%20Mr%20Sheeen%20%28Music%20Video%29%20_%20%40MixtapeMadness.mp3?dl=0"
		},
		{
			name = "Bis X Blanco X Active X MizOrMac - Kennington Where It Started",
			length = 237,
			url = "https://dl.dropboxusercontent.com/s/2sehjvn0goactfz/Bis%20X%20Blanco%20X%20Active%20X%20MizOrMac%20-%20Kennington%20Where%20It%20Started%20%23HarlemSpartans%20%40Spartansharlem.mp3?dl=0"
		},
		{
			name = "Skengdo & AM - Mad About Bars w/ Kenny",
			length = 372,
			url = "https://dl.dropboxusercontent.com/s/stjev22tynf7bj7/Skengdo%20%26%20AM%20-%20Mad%20About%20Bars%20w-%20Kenny%20%5BS2.E37%5D%20_%20%40MixtapeMadness%20%284K%29.mp3?dl=0"
		},
		{
			name = "Unknown T - Homerton B",
			length = 191,
			url = "https://dl.dropboxusercontent.com/s/2pgjmoyicwpcnsh/Unknown%20T%20-%20Homerton%20B%20%5BMusic%20Video%5D%20_%20GRM%20Daily.mp3?dl=0"
		}
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();