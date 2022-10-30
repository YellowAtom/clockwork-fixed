local ITEM = Clockwork.item:New()

ITEM.name = "80s Cassette"
ITEM.uniqueID = "cassette_80s"
ITEM.cost = 28
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A cassette tape that has the first 5 songs of Now! 'Now That's what I call the 80s!'."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Now That's what I call the 80's!", {
	{
		name = "1. Billie Jean - Michael Jackson",
		length = 300,
		url = "https://dl.dropboxusercontent.com/s/tke9je7d0oa9825/%5BMP3FY%5D%20Michael%20Jackson%20-%20Billie%20Jean%20%28Official%20Video%29.mp4?dl=0"
	},
	{
		name = "2. M by Pop Muzik",
		length = 193,
		url = "https://dl.dropboxusercontent.com/s/wal8mnricu1q79v/%5BMP3FY%5D%20M%20-%20Pop%20Muzik%20%28Official%20Video%29.mp4?dl=0"
	},
	{
		name = "3. Escape (The Piña Colada Song) by Rupert Holmes",
		length = 227,
		url = "https://dl.dropboxusercontent.com/s/nb20ff09voksuik/%5BMP3FY%5D%2010.%20Rupert%20Holmes%20-%20Escape%20%28The%20Pi%C3%B1a%20Colada%20Song%29.mp4?dl=0"
	},
	{
		name = "Video Killed The Radio Star by The Buggles",
		length = 215,
		url = "https://dl.dropboxusercontent.com/s/ixy2ypn5vwa1sq2/%5BMP3FY%5D%20The%20Buggles%20-%20Video%20Killed%20The%20Radio%20Star.mp4?dl=0"
	},
	{
		name = "Call Me by Blondie",
		length = 212,
		url = "https://dl.dropboxusercontent.com/s/pt6rwt7jwey7fj9/%5BMP3FY%5D%20Blondie-%20Call%20me.mp4?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
