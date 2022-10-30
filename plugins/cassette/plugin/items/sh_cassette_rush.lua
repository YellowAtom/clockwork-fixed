local ITEM = Clockwork.item:New()

ITEM.name = "Rush Cassette"
ITEM.uniqueID = "cassette_rush"
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.category = "Music"
ITEM.cost = 25
ITEM.batch = 1
ITEM.access = "1"
ITEM.business = true
ITEM.description = "A classic Canadian rock band on cassette."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Rush", {
	{
		name = "Spirit of the Radio",
		length = 302,
		url = "https://dl.dropboxusercontent.com/s/kfhllcusi14odqz/Rush-%20Spirit%20Of%20The%20Radio.mp3"
	},
	{
		name = "Limelight",
		length = 259,
		url = "https://dl.dropboxusercontent.com/s/la0ujm6lsqo7kfv/Rush%20-%20Limelight%20%28HQ%29.mp3"
	},
	{
		name = "Tom Sawyer",
		length = 274,
		url = "https://dl.dropboxusercontent.com/s/0b11wcby00suibh/Rush%20-%20Tom%20Sawyer%20%28Official%20Music%20Video%29.mp3"
	},
	{
		name = "Closer to the Heart",
		length = 178,
		url = "https://dl.dropboxusercontent.com/s/s3z5wggzd1nfyau/Closer%20To%20The%20Heart%20-%20Rush.mp3"
	},
	{
		name = "Working Man",
		length = 430,
		url = "https://dl.dropboxusercontent.com/s/5lb3cazp7t05ggq/Rush%20-%20Working%20Man.mp3"
	},
	{
		name = "Subdivisions",
		length = 332,
		url = "https://dl.dropboxusercontent.com/s/2qsinlx2y3a17v0/Rush%20-%20Subdivisions%20-%20Lyrics%20-%20HQ%20720p.mp3"
	},
	{
		name = "The Trees",
		length = 283,
		url = "https://dl.dropboxusercontent.com/s/71me2z84q34kt5q/Rush-The%20Trees.mp3"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
