local ITEM = Clockwork.item:New()

ITEM.name = "S.Y. Cassette"
ITEM.uniqueID = "simon_cassette"
ITEM.cost = 95
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = false
ITEM.description = "A rather cleaner mixtape, with a few scratches on it. It's labeled 'S.Y.' on it, along with a few stickers."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("S.Y.", {
	{
		name = "YNW Melly - 772 Love PT.1",
		length = 197,
		url = "https://dl.dropboxusercontent.com/s/kltkeamky2lzy4p/772%20Love.mp3?dl=0"
	},
	{
		name = "YNW Melly - 772 Love PT.2",
		length = 306,
		url = "https://dl.dropboxusercontent.com/s/z33bh398byfqzy4/YNW%20Melly%20Dangerously%20In%20Love%20%28772%20Love%20Pt.%202%29%20%28Official%20Audio%29.mp3?dl=0"
	},
	{
		name = "A$AP Rocky - Praise The Lord",
		length = 198,
		url = "https://dl.dropboxusercontent.com/s/kks0t1s77vm2zac/A%24AP%20Rocky%20-%20Praise%20The%20Lord%20%28Da%20Shine%29%20%28Audio%29%20ft.%20Skepta.mp3?dl=0"
	},
	{
		name = "Tyler The Creator - EARFQUAKE",
		length = 186,
		url = "https://dl.dropboxusercontent.com/s/b81n20nmk1pt6dj/EARFQUAKE.mp3?dl=0"
	},
	{
		name = "Jack Harlow - What's Poppin",
		length = 132,
		url = "https://dl.dropboxusercontent.com/s/2gdurlunsc7xmns/Jack%20Harlow%20-%20WHATS%20POPPIN%20%28Lyrics%29.mp3?dl=0"
	},
	{
		name = "Lil Mosey - Blueberry Faygo",
		length = 146,
		url = "https://dl.dropboxusercontent.com/s/anj7t521ch6k93p/Lil%20Mosey%20-%20Blueberry%20Faygo%20%5BAudio%5D.mp3?dl=0"
	},
	{
		name = "Lil Tecca - Did It Again",
		length = 93,
		url = "https://dl.dropboxusercontent.com/s/tqv4yacpvsdmvmo/Lil%20Tecca%20-%20Did%20It%20Again%20%28Official%20Audio%29.mp3?dl=0"
	},
	{
		name = "Kendrick Lamar - Money Trees",
		length = 376,
		url = "https://dl.dropboxusercontent.com/s/6ua9zhtcat8lvhj/Money%20Trees.mp3?dl=0"
	},
	{
		name = "YNW Melly - Murder On My Mind",
		length = 257,
		url = "https://dl.dropboxusercontent.com/s/nx15yx5u51jterz/Murder%20On%20My%20Mind.mp3?dl=0"
	},
	{
		name = "NLE Choppa - Camelot",
		length = 136,
		url = "https://dl.dropboxusercontent.com/s/oz7b9nyk7v7vgip/NLE%20Choppa%20-%20Camelot%20%5BOfficial%20Audio%5D%20Warner%20Records.mp3?dl=0"
	},
	{
		name = "Offset & Metro Boomin - Ric Flair Drip",
		length = 151,
		url = "https://dl.dropboxusercontent.com/s/n56quhht32aq6g9/Ric%20Flair%20Drip.mp3?dl=0"
	},
	{
		name = "Roddy Ricch - The Box",
		length = 190,
		url = "https://dl.dropboxusercontent.com/s/m3tcepamt5j4334/Roddy%20Ricch%20-%20The%20Box%20%5BOfficial%20Audio%5D.mp3?dl=0"
	},
	{
		name = "NLE Choppa - Shotta Flow 5",
		length = 135,
		url = "https://dl.dropboxusercontent.com/s/04l1s22m1mtb0pe/Shotta%20Flow%205.mp3?dl=0"
	},
	{
		name = "YNW Melly - 223",
		length = 151,
		url = "https://dl.dropboxusercontent.com/s/dqq9d6vyy3ss043/YNW%20Melly%20-%20223s%20ft.%209lokknine%20%5BOfficial%20Audio%5D.mp3?dl=0"
	},
	{
		name = "YNW Melly - Mind On My Murder",
		length = 261,
		url = "https://dl.dropboxusercontent.com/s/0ajv6r1udm9tk67/YNW%20Melly%20-%20Mind%20On%20My%20Murder%20%5BOfficial%20Audio%5D.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
