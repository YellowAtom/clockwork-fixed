local ITEM = Clockwork.item:New()

ITEM.name = "2101: Classics Cassette"
ITEM.uniqueID = "2101"
ITEM.cost = 42
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = false
ITEM.description = "Cassette with a Universal Logo and a serie number. Sketched by: Elijah Wilson. Approved by: Dr. Tulip Asterfield."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("2101", {
	{
		name = "Dancing in the moonlight",
		length = 172,
		url = "https://dl.dropboxusercontent.com/s/3dv5tjsxhlkgfrg/Dancing%20In%20the%20Moonlight.mp3?dl=0"
	},
	{
		name = "Just the two of us",
		length = 236,
		url = "https://dl.dropboxusercontent.com/s/fhe24opybc5xlue/Grover%20Washington%20Jr%20-%20Just%20the%20two%20of%20us.mp3?dl=0"
	},
	{
		name = "Brandy",
		length = 188,
		url = "https://dl.dropboxusercontent.com/s/veq4d652z3w62f0/Looking%20Glass%20-%20Brandy%20%28You%27re%20a%20Fine%20Girl%29%20%28Official%20Audio%29.mp3?dl=0"
	},
	{
		name = "December",
		length = 204,
		url = "https://dl.dropboxusercontent.com/s/wcnve972wcuxvey/The%20Four%20Seasons%20-%20December%2C%201963%20%28Oh%2C%20What%20a%20Night%29%20%5Bwith%20lyrics%5D.mp3?dl=0"
	},
	{
		name = "Brown Eyed Girl",
		length = 184,
		url = "https://dl.dropboxusercontent.com/s/5uteqfreyct4lvi/Van%20Morrison%20-%20Brown%20Eyed%20Girl%20%28Audio%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
