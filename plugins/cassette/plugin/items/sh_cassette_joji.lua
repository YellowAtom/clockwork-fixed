local ITEM = Clockwork.item:New()

ITEM.name = "Joji Cassette"
ITEM.uniqueID = "joji_cassette"
ITEM.cost = 35
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "v"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A pink cassette which looks like it has been dropped in some kind of liquid."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Joji", {
	{
		name = "Misery",
		length = 144,
		url = "https://dl.dropboxusercontent.com/s/980i42mize2ec70/Misery%2020Joji%20%28Chorus%20Loop%20EditNo%20Pink%20Guy%20Noises%29.mp3?dl=0"
	},
	{
		name = "You suck charlie",
		length = 102,
		url = "https://dl.dropboxusercontent.com/s/l8czu6ahniylk7q/joji%20-%20you%20suck%20charlie.mp3?dl=0"
	},
	{
		name = "Waste",
		length = 154,
		url = "https://dl.dropboxusercontent.com/s/pa9l6lnup3pp0pk/WASTE.mp3?dl=0"
	},
	{
		name = "Praise the lord",
		length = 153,
		url = "https://dl.dropboxusercontent.com/s/zyyp4aa1oaaw801/Praise%20the%20Lord%20and%20Pass%20the%20Ammunition%20w%20Lyrics.mp3?dl=0"
	},
	{
		name = "Claire De Lune",
		length = 302,
		url = "https://dl.dropboxusercontent.com/s/k21oavu9vomdt5r/CLAUDE%20DEBUSSY%20%20CLAIR%20DE%20LUNE.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
