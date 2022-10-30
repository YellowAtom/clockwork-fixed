local ITEM = Clockwork.item:New()

ITEM.name = "Rap Cassette"
ITEM.uniqueID = "rap_cassette"
ITEM.cost = 130
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "v"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "This cassette is very cold, 'Rap' is written on it in very odd handwriting."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Rap", {
	{
		name = "Young Jeezy - I Luv It",
		length = 243,
		url = "https://dl.dropboxusercontent.com/s/5l6npa7ko3zr44c/%5BOST%5D%20Saints%20Row%202%20-%20Young%20Jeezy-%20I%20Luv%20It%20%28HQ%29.mp3?dl=0"
	},
	{
		name = "Wale - Ridin' In That Black Joint",
		length = 248,
		url = "https://dl.dropboxusercontent.com/s/fwvrgnh173mcq3k/%5BOST%5D%20Saints%20Row%202%20-%20Wale%20-%20Ridin%27%20In%20That%20Black%20Joint%20%28HQ%29.mp3?dl=0"
	},
	{
		name = "Nas - N.Y. State Of Mind",
		length = 295,
		url = "https://dl.dropboxusercontent.com/s/anz2ty1msz57iqw/%5BOST%5D%20Saints%20Row%202%20-%20Nas%20-%20N.Y.%20State%20Of%20Mind%20%28HQ%29.mp3?dl=0"
	},
	{
		name = "Lloyd Banks featuring 50 Cent - Hands Up",
		length = 242,
		url = "https://dl.dropboxusercontent.com/s/xddmvczvvhnjxdn/%5BOST%5D%20Saints%20Row%202%20-%20Lloyd%20Banks%20featuring%2050%20Cent%20-%20Hands%20Up%20%28HQ%29.mp3?dl=0"
	},
	{
		name = "Beanie Sigel - What A Thug About",
		length = 239,
		url = "https://dl.dropboxusercontent.com/s/r4y3q3c5iivzcl4/%5BOST%5D%20Saints%20Row%202%20-%20Beanie%20Sigel%20-%20What%20A%20Thug%20About%20%28HQ%29.mp3?dl=0"
	},
	{
		name = "Apache - Gangsta Bitch",
		length = 284,
		url = "https://dl.dropboxusercontent.com/s/s8osrox54z6wbfi/Saints%20Row%202%20-%20Apache%20-%20Gangsta%20Bitch.mp3?dl=0"
	},
	{
		name = "Gangrene - Bassheads",
		length = 165,
		url = "https://dl.dropboxusercontent.com/s/woi2jupt3xd3k5w/GTA%20V%20_%20Radio%20Los%20Santos%20_%20Gangrene%20-%20Bassheads.mp3?dl=0"
	},
	{
		name = "YG - I'm a Real 1",
		length = 168,
		url = "https://dl.dropboxusercontent.com/s/4hg3asy8lm4h1ur/GTA%20V%20_%20Radio%20Los%20Santos%20_%20YG%20-%20I%27m%20a%20Real%201%20%28Prod.%20By%20DJ%20Mustard%29.mp3?dl=0"
	},
	{
		name = "Chuck Inglish – Came Thru - Easily",
		length = 278,
		url = "https://dl.dropboxusercontent.com/s/kyki473e48lh1ki/GTA%20V%20%5BRadio%20Los%20Santos%5D%20Chuck%20Inglish%20%E2%80%93%20Came%20Thru%20-%20Easily%20%28Feat.%20Mac%20Miller%20%26%20Ab-Soul%29.mp3?dl=0"
	},
	{
		name = "Grafh - Get Shot Boy",
		length = 211,
		url = "https://dl.dropboxusercontent.com/s/hjts3ai9xqn6068/Grafh%20-%20Get%20Shot%20Boy.mp3?dl=0"
	},
	{
		name = "Kurupt - I'm Burnt",
		length = 200,
		url = "https://dl.dropboxusercontent.com/s/j0257tlt1zgtkz6/%5BSoundtracks%5D%20Saints%20Row%203%20-%20Krhyme%20_%20I%27m%20Burnt%20-%20Kurupt%20%28HD%29.mp3?dl=0"
	},
	{
		name = "The Game ft. 2Chainz & Rick Ross - Ali Bomaye",
		length = 321,
		url = "https://dl.dropboxusercontent.com/s/ze7il50fq141lhx/GTA%20V%20_%20Radio%20Los%20Santos%20_%20The%20Game%20ft.%202Chainz%20%26%20Rick%20Ross%20-%20Ali%20Bomaye.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
