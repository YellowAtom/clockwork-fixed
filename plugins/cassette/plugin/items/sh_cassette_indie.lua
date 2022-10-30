local ITEM = Clockwork.item:New()

ITEM.name = "Indie Cassette"
ITEM.uniqueID = "indie_cassette"
ITEM.cost = 75
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A light grey cassette with the word 'Indie' written on it in black marker."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Indie", {
	{
		name = "Dan Croll - From Nowhere",
		length = 267,
		url = "https://dl.dropboxusercontent.com/s/s3pwwcczin9h4kk/GTA%20V%20%5BRadio%20Mirror%20Park%5D%20Dan%20Croll%20-%20From%20Nowhere%20%28Baardsen%20Remix%29.mp3?dl=0"
	},
	{
		name = "Niki and the Dove – The Drummer",
		length = 234,
		url = "https://dl.dropboxusercontent.com/s/ryphfnrn3p861ja/GTA%20V%20%5BRadio%20Mirror%20Park%5D%20Niki%20and%20the%20Dove%20%E2%80%93%20The%20Drummer.mp3?dl=0"
	},
	{
		name = "Blur - Tender",
		length = 358,
		url = "https://dl.dropboxusercontent.com/s/ge1la3b2ry754tu/Blur%20-%20Tender.mp3?dl=0"
	},
	{
		name = "Feathers - Dark Matter",
		length = 237,
		url = "https://dl.dropboxusercontent.com/s/ksp47ktikaojmlh/GTA%20V%20%5BRadio%20Mirror%20Park%5D%20Feathers%20-%20Dark%20Matter.mp3?dl=0"
	},
	{
		name = "Pumped up Kicks - Foster The People",
		length = 239,
		url = "https://dl.dropboxusercontent.com/s/jcp28yiw91urehp/Pumped%20up%20Kicks-%20Foster%20The%20People.mp3?dl=0"
	},
	{
		name = "The C90's - Shine a Light",
		length = 349,
		url = "https://dl.dropboxusercontent.com/s/p036yfe6nxac35r/GTA%20V%20%5BRadio%20Mirror%20Park%5D%20The%20C90%27s%20-%20Shine%20a%20Light%20%28Flight%20Facilities%20Remix%29.mp3?dl=0"
	},
	{
		name = "Fazerdaze - Lucky Girl",
		length = 171,
		url = "https://dl.dropboxusercontent.com/s/z7da6wkpzd0jfsh/Fazerdaze%20-%20Lucky%20Girl%20%28Official%20Video%29.mp3?dl=0"
	},
	{
		name = "Elina - Here With Me",
		length = 196,
		url = "https://dl.dropboxusercontent.com/s/ggcrux5zyfklrlg/Elina%20-%20Here%20With%20Me.mp3?dl=0"
	},
	{
		name = "Jesse Ruben - This Is Why I Need You",
		length = 224,
		url = "https://dl.dropboxusercontent.com/s/tblpoomgm4amy3g/Jesse%20Ruben%20-%20This%20Is%20Why%20I%20Need%20You.mp3?dl=0"
	},
	{
		name = "Neon Indian - Change of Coast",
		length = 192,
		url = "https://dl.dropboxusercontent.com/s/ibo3pfuce7xar8o/GTA%20V%20%5BRadio%20Mirror%20Park%5D%20Neon%20Indian%20--%20Change%20of%20Coast.mp3?dl=0"
	},
	{
		name = "The Chain Gang Of 1974 - Sleepwalking",
		length = 217,
		url = "https://dl.dropboxusercontent.com/s/so319nxtcvevx88/Sleepwalking.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
