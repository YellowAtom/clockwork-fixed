local ITEM = Clockwork.item:New()

ITEM.name = "Experimental Cassette Vol. 2 Cassette"
ITEM.uniqueID = "exp_cassette2"
ITEM.cost = 52
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A matte black cassette with an orange stripe. It has a label on it, saying 'Experimental Vol. 2' as well as the small Universal Union insignia on it. It sounds oddly familiar and nostalgic."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Experimental Cassette Vol. 2", {
	{
		name = "Aphex Twin - Tha",
		length = 547,
		url = "https://dl.dropboxusercontent.com/s/ea402x2jmk8to89/Aphex%20Twin-Tha%20%281992%29%20HD.mp3?dl=0"
	},
	{
		name = "Aphex Twin - Actium",
		length = 455,
		url = "https://dl.dropboxusercontent.com/s/ihs0jx9xm0oqw0x/Actium.mp3?dl=0"
	},
	{
		name = "Aphex Twin - #2",
		length = 394,
		url = "https://dl.dropboxusercontent.com/s/ltn1p87esxs48a7/%232.mp3?dl=0"
	},
	{
		name = "Aphex Twin - Polynomial-C",
		length = 286,
		url = "https://dl.dropboxusercontent.com/s/rbsitqf6mk6fwnk/Polynomial-C.mp3?dl=0"
	},
	{
		name = "Fatboy Slim - Right Here, Right Now",
		length = 347,
		url = "https://dl.dropboxusercontent.com/s/nf7xweh9wirjoin/Fatboy%20Slim%20-%20Right%20Here%2C%20Right%20Now.mp3?dl=0"
	},
	{
		name = "Amon Tobin - People Like Frank",
		length = 364,
		url = "https://dl.dropboxusercontent.com/s/zrme02xzsi9xw6z/Amon%20Tobin%20-%20People%20Like%20Frank%20%5BHD%5D.mp3?dl=0"
	},
	{
		name = "Amon Tobin - Nova",
		length = 282,
		url = "https://dl.dropboxusercontent.com/s/4ndaudeatax8h82/Nova.mp3?dl=0"
	},
	{
		name = "Palmbomen - Stock",
		length = 183,
		url = "https://dl.dropboxusercontent.com/s/h1esvwtjohjzjil/Palmbomen%20-%20Stock.mp3?dl=0"
	},
	{
		name = "Daft Punk - One More Time",
		length = 320,
		url = "https://dl.dropboxusercontent.com/s/8iym6j0w8zjmsdw/Daft%20Punk%20-%20One%20More%20Time%20%5BHQ%5D.mp3?dl=0"
	},
	{
		name = "Daft Punk - Around The World",
		length = 429,
		url = "https://dl.dropboxusercontent.com/s/zky52k35ghucxd8/Daft%20Punk%20-%20Around%20the%20world%20%28Official%20Audio%29.mp3?dl=0"
	},
	{
		name = "Daft Punk - Aerodynamic",
		length = 212,
		url = "https://dl.dropboxusercontent.com/s/7ypi592qrn0w2iz/Daft%20Punk%20-%20Aerodynamic%20%28Official%20audio%29.mp3?dl=0"
	},
	{
		name = "Daft Punk - Human After All",
		length = 319,
		url = "https://dl.dropboxusercontent.com/s/u0u8eokmvmjvs9q/Daft%20Punk%20-%20Human%20After%20All%20%28Official%20audio%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
