local ITEM = Clockwork.item:New()

ITEM.name = "24's Memories Cassette"
ITEM.uniqueID = "24's Memories"
ITEM.cost = 21
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A scratched looking card with a small Union Sticker on the back."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("24's Memories", {
	{
		name = "A Town",
		length = 223,
		url = "https://dl.dropboxusercontent.com/s/1hp0z7bf0c920aa/a_town.mp3?dl=0"
	},
	{
		name = "Anything Goes",
		length = 191,
		url = "https://dl.dropboxusercontent.com/s/t5q4cjr0s4j6tak/anything_goes.mp3?dl=0"
	},
	{
		name = "Blue Moon",
		length = 171,
		url = "https://dl.dropboxusercontent.com/s/lhnj74r0mld41u6/blue_moon.mp3?dl=0"
	},
	{
		name = "The Blue Wrath",
		length = 147,
		url = "https://dl.dropboxusercontent.com/s/whjojqk0h4rc696/blue_wrath.mp3?dl=0"
	},
	{
		name = "Brotherswing",
		length = 222,
		url = "https://dl.dropboxusercontent.com/s/7s896rrrgtj5teu/brotherswing.mp3?dl=0"
	},
	{
		name = "Exile",
		length = 285,
		url = "https://dl.dropboxusercontent.com/s/i2ylm61nbct86lv/exile.mp3?dl=0"
	},
	{
		name = "Goodbye Sun",
		length = 252,
		url = "https://dl.dropboxusercontent.com/s/1p83v47rffb3917/goodbye_sun.mp3?dl=0"
	},
	{
		name = "The Passenger",
		length = 284,
		url = "https://dl.dropboxusercontent.com/s/e7e6o3brejb2c7y/passenger.mp3?dl=0"
	},
	{
		name = "Rags To Riches",
		length = 170,
		url = "https://dl.dropboxusercontent.com/s/igjo26mgy6i1nyh/rags_to_riches.mp3?dl=0"
	},
	{
		name = "Summersong",
		length = 213,
		url = "https://dl.dropboxusercontent.com/s/i67pefv58719sq6/summersong.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
