local ITEM = Clockwork.item:New()

ITEM.name = "60's & 70's Cassette"
ITEM.uniqueID = "60s70s_cassette"
ITEM.cost = 30
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "An ordinary cassette with a label saying '60's & 70's'. The cassette has the Rolling Stones sticker on it."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("60's & 70's", {
	{
		name = "The Rolling Stones - (I Can't Get No) Satisfaction",
		length = 234,
		url = "https://dl.dropboxusercontent.com/s/6tr8dand31zs83u/The%20Rolling%20Stones%20-%20%28I%20Can%27t%20Get%20No%29%20Satisfaction.mp3?dl=0"
	},
	{
		name = "The Rolling Stones - Jumpin' Jack Flash",
		length = 218,
		url = "https://dl.dropboxusercontent.com/s/ywlk5jnz60msiy9/The%20Rolling%20Stones%20-%20Jumpin%27%20Jack%20Flash.mp3?dl=0"
	},
	{
		name = "The Rolling Stones - Mercy Mercy",
		length = 164,
		url = "https://dl.dropboxusercontent.com/s/iai2a3nd75ktn3w/The%20Rolling%20Stones%20-%20Mercy%20Mercy.mp3?dl=0"
	},
	{
		name = "The Kinks - You Really Got Me",
		length = 134,
		url = "https://dl.dropboxusercontent.com/s/zv4kr0ziwov1rdx/The%20Kinks%20-%20You%20Really%20Got%20Me.mp3?dl=0"
	},
	{
		name = "George Harrison - Awaiting On You All",
		length = 168,
		url = "https://dl.dropboxusercontent.com/s/adbk6ok4ig8uno5/George%20Harrison%20-%20Awaiting%20On%20You%20All.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
