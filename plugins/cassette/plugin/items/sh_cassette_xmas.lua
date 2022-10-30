local ITEM = Clockwork.item:New()

ITEM.name = "Christmas Cassette"
ITEM.uniqueID = "christmas_cassette"
ITEM.cost = 50
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A red and white cassette with snowflakes and sugarcanes. It says 'Christmas' on it."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("UU Christmas Collection", {
	{
		name = "Jingle Bell Rock",
		length = 130,
		url = "https://dl.dropboxusercontent.com/s/sosujrmbppirkbf/Jingle%20Bell%20Rock.mp3?dl=0"
	},
	{
		name = "Bing Crosby - Silent Night",
		length = 161,
		url = "https://dl.dropboxusercontent.com/s/5ge59cx17glukd0/Bing%20Crosby%20%20-%20Silent%20Night.mp3?dl=0"
	},
	{
		name = "Frank Sinatra - Let It Snow",
		length = 157,
		url = "https://dl.dropboxusercontent.com/s/sr5p0fd0ziwlce6/Frank%20sinatra%20-%20Let%20it%20snow.mp3?dl=0"
	},
	{
		name = "Wham! - Last Christmas",
		length = 287,
		url = "https://dl.dropboxusercontent.com/s/ukzpu5fpog5kzqx/Wham%21%20-%20Last%20Christmas%20%28Official%20Video%29.mp3?dl=0"
	},
	{
		name = "Michael Buble - Santa Claus Is Coming To Town",
		length = 171,
		url = "https://dl.dropboxusercontent.com/s/hst79ofvq1rpbki/Michael%20Bubl%C3%A9%20-%20Santa%20Claus%20Is%20Coming%20To%20Town%20%5BOfficial%20HD%5D.mp3?dl=0"
	},
	{
		name = "Frank Sinatra - Frosty The Snowman",
		length = 162,
		url = "https://dl.dropboxusercontent.com/s/44m1lcgk54anh01/Michael%20Bubl%C3%A9%20-%20Frosty%20The%20Snowman%20%28ft.%20The%20Puppini%20Sisters%29%20%5BOfficial%20HD%20Audio%5D.mp3?dl=0"
	},
	{
		name = "John Legend - What Christmas Means To Me",
		length = 162,
		url = "https://dl.dropboxusercontent.com/s/mc69r6l2nd8ta67/John%20Legend%20-%20What%20Christmas%20Means%20to%20Me%20%28Official%20Audio%29%20ft.%20Stevie%20Wonder.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
