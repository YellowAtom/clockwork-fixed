local ITEM = Clockwork.item:New()

ITEM.name = "Vladivostok Cassette"
ITEM.uniqueID = "cassette_vladivostok"
ITEM.cost = 50
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "v"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "An old cassette covered in Cyrillic characters."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Vladivostok Best Hits", {
	{
		name = "Wild Dances",
		length = 178,
		url = "https://dl.dropboxusercontent.com/s/1xoinb4ych3uh34/wild%20dances.mp3?dl=0"
	},
	{
		name = "Schweine",
		length = 265,
		url = "https://dl.dropboxusercontent.com/s/i310g6iivqsbcoq/schweine.mp3?dl=0"
	},
	{
		name = "Gruppa Krovi",
		length = 205,
		url = "https://dl.dropboxusercontent.com/s/7pnp1mrm5dimchw/gruppa%20krovi.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
