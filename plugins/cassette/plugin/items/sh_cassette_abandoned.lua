local ITEM = Clockwork.item:New()

ITEM.name = "Abandoned Cassette"
ITEM.uniqueID = "abandoned_cassette"
ITEM.cost = 100
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A black cassette tape with a simple drawing of a thin tree standing tall on a hill."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Abandoned", {
	{
		name = "Memory (Sugarcult Cover) - Abandoning Sunday",
		length = 235,
		url = "https://dl.dropboxusercontent.com//s/04xuf2iucbu26ew/Memory%20%28Sugarcult%20Cover%29%20-%20Abandoning%20Sunday.mp3?dl=0"
	},
	{
		name = "Words - Abandoning Sunday",
		length = 261,
		url = "https://dl.dropboxusercontent.com/s/unadc72mnr19dgq/Words%20-%20Abandoning%20Sunday.mp3?dl=0"
	},
	{
		name = "Battle Tapes - Graveyard Shift",
		length = 245,
		url = "https://dl.dropboxusercontent.com/s/wqzwakoikgjtnz9/Graveyard%20Shift.mp3?dl=0"
	},
	{
		name = "Patience - Abandoning Sunday",
		length = 260,
		url = "https://dl.dropboxusercontent.com/s/nhbdxo4mgq6s4ws/Patience%20-%20Abandoning%20Sunday.mp3?dl=0"
	},
	{
		name = "Just For Once - Abandoning Sunday",
		length = 311,
		url = "https://dl.dropboxusercontent.com/s/3ku38ei8tcjuvwi/Just%20For%20Once%20-%20Abandoning%20Sunday.mp3?dl=0"
	},
	{
		name = "Never Gonna Give You Up (Rick Astley Cover) - Abandoning Sunday",
		length = 219,
		url = "https://dl.dropboxusercontent.com/s/ckvfcoqyuij3j6d/Never%20Gonna%20Give%20You%20Up%20%28Rick%20Astley%20Cover%29%20-%20Abandoning%20Sunday.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
