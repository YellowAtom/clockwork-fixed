local ITEM = Clockwork.item:New()

ITEM.name = "2601: Classic Rock Vol. 1 Cassette"
ITEM.uniqueID = "classic_rock_cassette"
ITEM.cost = 42
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = false
ITEM.description = "Cassette with a Universal Logo and a serie number. Sketched by: Thomas Trent Approved by: Dr. Tulip Asterfield"
ITEM.isCassette = true

ITEM.key = t_cassette.Register("2601: Classic Rock Vol. 1", {
	{
		name = "Thunderstruck",
		length = 292,
		url = "https://dl.dropboxusercontent.com/s/yympmaynj0xb9m6/AC-DC%20-%20Thunderstruck%20%28Official%20Music%20Video%29.mp3?dl=0"
	},
	{
		name = "Back in Black",
		length = 247,
		url = "https://dl.dropboxusercontent.com/s/atthdw3whck55sa/ACDC%20Back%20in%20black%20lyrics.mp3?dl=0"
	},
	{
		name = "Sweet Child O' Mine",
		length = 303,
		url = "https://dl.dropboxusercontent.com/s/jhhle8t0h3jbat2/Guns%20N%27%20Roses%20-%20Sweet%20Child%20O%27%20Mine%20%28Official%20Music%20Video%29.mp3?dl=0"
	},
	{
		name = "Livin' On A Prayer",
		length = 249,
		url = "https://dl.dropboxusercontent.com/s/n326b423hol0voz/Bon%20Jovi%20-%20Livin%27%20On%20A%20Prayer.mp3?dl=0"
	},
	{
		name = "All Along The Watchtower",
		length = 242,
		url = "https://dl.dropboxusercontent.com/s/bfsms64s4mznq32/The%20Jimi%20Hendrix%20Experience%20-%20All%20Along%20The%20Watchtower%20%28Audio%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
