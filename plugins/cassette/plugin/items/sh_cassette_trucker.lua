local ITEM = Clockwork.item:New()

ITEM.name = "Trucker Cassette"
ITEM.uniqueID = "trucker_cassette"
ITEM.cost = 150
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A poorly kept casette with a crude picture of a son in the drivers seat of a truck. The picture is covered with coffee stain."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Truck", {
	{
		name = "My Travel",
		length = 271,
		url = "https://dl.dropboxusercontent.com/s/985owtwj5u4rhy1/Kuusamo.mp3?dl=0"
	},
	{
		name = "My Heart",
		length = 240,
		url = "https://dl.dropboxusercontent.com/s/cxp6ffruz7ntaoq/My%20Heart.mp3?dl=0"
	},
	{
		name = "My Star",
		length = 280,
		url = "https://dl.dropboxusercontent.com/s/i9wyhdqayku8xtk/David%20Bowie%20-%20Starman%20%5BInstrumental%5D.mp3?dl=0"
	},
	{
		name = "My War",
		length = 347,
		url = "https://dl.dropboxusercontent.com/s/egfsuhjgyw34hqk/This%20War.mp3?dl=0"
	},
	{
		name = "My Group",
		length = 260,
		url = "https://dl.dropboxusercontent.com/s/xhxsdj51rgq0yf3/Gruppa.mp3?dl=0"
	},
	{
		name = "My World",
		length = 90,
		url = "https://dl.dropboxusercontent.com/s/h6qt16l5vubd0qu/Afghan.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
