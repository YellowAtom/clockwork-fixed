local ITEM = Clockwork.item:New()

ITEM.name = "Katana - Zero Cassette"
ITEM.uniqueID = "katana_cassete"
ITEM.cost = 70
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "v"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A Bright Neon cassete that looks to be fairly new and clean. Has the words Katana Zero written on the back of it in the same Bright Colorful Neon."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Katana - Zero", {
	{
		name = "Overdose",
		length = 254,
		url = "https://dl.dropboxusercontent.com/s/p4ll9832n9k58an/Overdose%20%28Bunker%201%29%20-%20Katana%20ZERO%20%28Gamerip%29.mp3?dl=0"
	},
	{
		name = "LudoWic",
		length = 254,
		url = "https://dl.dropboxusercontent.com/s/ani7nhpjw04w632/Katana%20Zero%20-%20Katana%20ZERO%20%28Gamerip%29.mp3?dl=0"
	},
	{
		name = "Third District",
		length = 264,
		url = "https://dl.dropboxusercontent.com/s/0x03t6gq9i2lxi4/Third%20District%20-%20Katana%20ZERO%20%28Gamerip%29.mp3?dl=0"
	},
	{
		name = "Snow",
		length = 130,
		url = "https://dl.dropboxusercontent.com/s/57tl85bpvdhhtn0/Snow%20-%20Katana%20ZERO%20%28Gamerip%29.mp3?dl=0"
	},
	{
		name = "The End",
		length = 084,
		url = "https://dl.dropboxusercontent.com/s/5whibofh8ii6uiq/Ending%20-%20Katana%20ZERO%20%28Gamerip%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
