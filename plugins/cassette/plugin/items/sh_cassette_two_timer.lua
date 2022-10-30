local ITEM = Clockwork.item:New()

ITEM.name = "Two Timer By Fredrick Brown Cassette"
ITEM.uniqueID = "two_timer"
ITEM.cost = 32
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A dark grey cassette with a pale, bald male drawn crudely on it."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Two Timer By Fredrick Brown", {
	{
		name = "Two Timer",
		length = 329,
		url = "https://dl.dropboxusercontent.com/s/kmx8ypq6mnrgpv7/Fredrick%20Brown%20%20%20Two%20Timer%20%20%20%20Science%20Fiction%20Novel.wav?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
