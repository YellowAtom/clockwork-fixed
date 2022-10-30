local ITEM = Clockwork.item:New()

ITEM.name = "Koethe Cassette"
ITEM.uniqueID = "cassette_koethe"
ITEM.cost = 40
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A slightly broken casette. On the front is a drawing of a man holding a guitar, and 'Koethe' in a handwriting font. On the back, the songs are listed."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Koethe", {
	{
		name = "Price",
		length = 253,
		url = "https://dl.dropboxusercontent.com/s/e4tuv78lr199oie/videoplayback%20%281%29.mp4?dl=0"
	},
	{
		name = "Memory",
		length = 273,
		url = "https://dl.dropboxusercontent.com/s/9yj822fg291lrgt/videoplayback%20%282%29.mp4?dl=0"
	},
	{
		name = "Amber",
		length = 300,
		url = "https://dl.dropboxusercontent.com/s/hsf99sk1rm7m75n/videoplayback%20%283%29.mp4?dl=0"
	},
	{
		name = "Take it all back",
		length = 205,
		url = "https://dl.dropboxusercontent.com/s/1mkoza5y2rmxce3/videoplayback%20%284%29.mp4?dl=0"
	},
	{
		name = "Storm",
		length = 205,
		url = "https://dl.dropboxusercontent.com/s/yrw497l8o0s6j2h/videoplayback%20%285%29.mp4?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
