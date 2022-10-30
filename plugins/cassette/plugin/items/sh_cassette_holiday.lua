local ITEM = Clockwork.item:New()

ITEM.name = "Holiday Cassette"
ITEM.uniqueID = "holiday_cassette"
ITEM.cost = 50
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "This cassette has several bright symbols of diffrent holidays stickered onto it"
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Holiday Archives", {
	{
		name = "Tombstone - SSS",
		length = 230,
		url = "https://dl.dropboxusercontent.com/s/j8oe8fmc9lec3kp/Spooky%20Scary%20Skeletons%20%28Remix%29%20-%20Extended%20Mix.mp3?dl=0"
	},
	{
		name = "Micheal Myers Theme Remix",
		length = 222,
		url = "https://dl.dropboxusercontent.com/s/0a7xx585uwhfpn6/HALLOWEEN%20THEME%20%28Trap%20Remix%29%20%28Michael%20Myers%20Theme%29.mp3?dl=0"
	},
	{
		name = "Glee - Jingle Bell Rock",
		length = 152,
		url = "https://dl.dropboxusercontent.com/s/4s1mfjfolkg3ipc/Glee%20-%20Jingle%20Bell%20Rock%20%28Lyrics%29.mp3?dl=0"
	},
	{
		name = "Mariah Carey - All I want for Christmas",
		length = 235,
		url = "https://dl.dropboxusercontent.com/s/e9xe8xafv8qhr7e/Mariah%20Carey%20-%20All%20I%20Want%20For%20Christmas%20Is%20You.mp3?dl=0"
	},
	{
		name = "Europe - The Final Countdown",
		length = 311,
		url = "https://dl.dropboxusercontent.com/s/g5ek1vrighk82x9/The%20Final%20Countdown.mp3?dl=0"
	},
	{
		name = "Ahmed - Jingle Bombs",
		length = 153,
		url = "https://dl.dropboxusercontent.com/s/x7h0uypxq2qs0pa/Jingle%20Bombs%20%28Achmed%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
