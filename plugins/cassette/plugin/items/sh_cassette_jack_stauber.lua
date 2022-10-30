local ITEM = Clockwork.item:New()

ITEM.name = "Jack Stauber - Pop Food Cassette"
ITEM.uniqueID = "pop_food_cassette"
ITEM.cost = 98
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A cream coloured cassette. A male with a long beard is printed on it."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Jack Stauber - Pop Food", {
	{
		name = "Buttercup",
		length = 209,
		url = "https://dl.dropboxusercontent.com/s/x8mk7qrby233sa5/Buttercup.mp3?dl=0"
	},
	{
		name = "Oh Klahoma",
		length = 186,
		url = "https://dl.dropboxusercontent.com/s/z2343tnr0ai37t0/Oh%20Klahoma.mp3?dl=0"
	},
	{
		name = "I Love You Verne Troyer",
		length = 186,
		url = "https://dl.dropboxusercontent.com/s/vux42joa3zqcl5j/I%20Love%20You%20Verne%20Troyer.mp3?dl=0"
	},
	{
		name = "Koi Boy",
		length = 152,
		url = "https://dl.dropboxusercontent.com/s/qe6sw2i676y0pf1/Koi%20Boy.mp3?dl=0"
	},
	{
		name = "Dog Nightmare",
		length = 176,
		url = "https://dl.dropboxusercontent.com/s/su5vls9bpejnv97/Dog%20Nightmare.mp3?dl=0"
	},
	{
		name = "Bothersome",
		length = 237,
		url = "https://dl.dropboxusercontent.com/s/1ntjqvg2q15oh30/Bothersome.mp3?dl=0"
	},
	{
		name = "Safe Socks",
		length = 185,
		url = "https://dl.dropboxusercontent.com/s/xuytigl28y1rwhv/Safe%20Socks.mp3?dl=0"
	},
	{
		name = "My Plea",
		length = 176,
		url = "https://dl.dropboxusercontent.com/s/4t7x12v91mdzry8/My%20Plea.mp3?dl=0"
	},
	{
		name = "Lynn",
		length = 100,
		url = "https://dl.dropboxusercontent.com/s/kitssjyisrdp1jr/Lynn.mp3?dl=0"
	},
	{
		name = "I Understand",
		length = 321,
		url = "https://dl.dropboxusercontent.com/s/lp7vwi85ef3zo2t/I%20Understand.mp3?dl=0"
	},
	{
		name = "Candy Eyes",
		length = 252,
		url = "https://dl.dropboxusercontent.com/s/sy7lju7jl44v9n5/Candy%20Eyes.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
