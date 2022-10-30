local ITEM = Clockwork.item:New()

ITEM.name = "Desert Tunes Cassette"
ITEM.uniqueID = "desert_tunes"
ITEM.cost = 50
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A somewhat dusty casette, of unknown origin, with some arabic letters on its front."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Desert Tunes", {
	{
		name = "Strong Spice",
		length = 260,
		url = "https://dl.dropboxusercontent.com/s/n8hofuoeynq0v3m/A%20Strong%20Spice.mp3?dl=0"
	},
	{
		name = "Dar Meshq",
		length = 141,
		url = "https://dl.dropboxusercontent.com/s/a5dkotu4dslm7ss/Dar%20Meshq.mp3?dl=0"
	},
	{
		name = "Sandal Maker",
		length = 376,
		url = "https://dl.dropboxusercontent.com/s/bmc2zbzdvn4zvnn/Sandal%20Maker.mp3?dl=0"
	},
	{
		name = "The Last Drop",
		length = 177,
		url = "https://dl.dropboxusercontent.com/s/yuhredkn9npn48s/The%20Last%20Drop.mp3?dl=0"
	},
	{
		name = "Caravan",
		length = 118,
		url = "https://dl.dropboxusercontent.com/s/9a22rfi3omvobuy/Caravan%20Ambient.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
