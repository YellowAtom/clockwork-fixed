local ITEM = Clockwork.item:New()

ITEM.name = "Pre-War Classics Volume I Cassette"
ITEM.uniqueID = "prewar_classics_v1_cassette"
ITEM.cost = 50
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .04
ITEM.batch = 1
ITEM.access = "v"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A pretty old cassette showing a bright yellow sun in a pink sunset"
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Pre-War Archive - Volume I", {
	{
		name = "Haddaway - What is Love",
		length = 240,
		url = "https://dl.dropboxusercontent.com/s/bmfsak4vjoz4zqx/Haddaway%20-%20What%20Is%20Love%20%5BOfficial%5D.mp3?dl=0"
	},
	{
		name = "George Michael - Careless Whisper",
		length = 300,
		url = "https://dl.dropboxusercontent.com/s/r7hr7h2r1drnbs3/George%20Michael%20-%20Careless%20Whisper%20%28Official%20Video%29.mp3?dl=0"
	},
	{
		name = "Smug Dancin'",
		length = 256,
		url = "https://dl.dropboxusercontent.com/s/tlo6jksfyhe08fq/S%20M%20U%20G%20-%20D%20A%20N%20C%20I%20N%20-%20%ED%93%94%20%ED%93%A5%20%ED%93%9E%20%ED%93%9B%20%ED%93%A5%20%ED%93%94%20%ED%93%93.mp3?dl=0"
	},
	{
		name = "Flamingosis - Sunset Park",
		length = 220,
		url = "https://dl.dropboxusercontent.com/s/7amyx03difla7ax/Flamingosis%20-%20Sunset%20Park.mp3?dl=0"
	},
	{
		name = "Daler Mehndi - Tunak Tunak",
		length = 256,
		url = "https://dl.dropboxusercontent.com/s/jxfm2qi1y8xmqdi/Daler%20Mehndi%20-%20Tunak%20Tunak%20Tun%20Video.mp3?dl=0"
	},
	{
		name = "Rick Astley - Never Gonna Give You Up",
		length = 212,
		url = "https://dl.dropboxusercontent.com/s/ubclc5b0p9l12en/Rick%20Astley%20-%20Never%20Gonna%20Give%20You%20Up%20%28Video%29.mp3?dl=0"
	},
	{
		name = "Kero Kero Bonito - Flamingo",
		length = 197,
		url = "https://dl.dropboxusercontent.com/s/wxvc0180b117i5s/Kero%20Kero%20Bonito%20-%20Flamingo.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
