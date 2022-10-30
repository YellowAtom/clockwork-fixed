local ITEM = Clockwork.item:New()

ITEM.name = "Blues Cassette"
ITEM.uniqueID = "blues_cassette"
ITEM.cost = 28
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A battered cassette on is that says 'The Blues' in black sharpie. "
ITEM.isCassette = true

ITEM.key = t_cassette.Register("The Blues", {
	{
		name = "Hoochie Coochie Man - Muddy Waters",
		length = 164,
		url = "https://dl.dropboxusercontent.com/s/awlao8k9t0jwbmm/Muddy%20Waters%20-%20Hoochie%20Coochie%20Man%20%28320%20kbps%29.mp3?dl=0"
	},
	{
		name = "Bad To The Bone",
		length = 295,
		url = "https://dl.dropboxusercontent.com/s/so6awz8pyc1waq8/Bad%20To%20The%20Bone%20%28320%20kbps%29%281%29.mp3?dl=0"
	},
	{
		name = "Black Stone Cherry - Me and the Devil Blues",
		length = 278,
		url = "https://dl.dropboxusercontent.com/s/ihy8601en8dls5f/Black%20Stone%20Cherry%20-%20Me%20and%20the%20Devil%20Blues%20%28Official%20Music%20Video%29%20%28320%20kbps%29.mp3?dl=0"
	},
	{
		name = "ZZ Top -  La Grange",
		length = 216,
		url = "https://dl.dropboxusercontent.com/s/ccy9m0fc9d4a11l/ZZ%20Top%20-%20La%20Grange%20%28Easy%20Rider%29%20%28320%20kbps%29.mp3?dl=0"
	},
	{
		name = "The Blues Brothers - Sweet Home Chicago",
		length = 469,
		url = "https://dl.dropboxusercontent.com/s/jz9fh2n5061m15c/The%20Blues%20Brothers%20-%20Sweet%20Home%20Chicago%20%28Official%20Audio%29%20%28320%20kbps%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
