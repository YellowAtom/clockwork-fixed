local ITEM = Clockwork.item:New()

ITEM.name = "Chillwave Cassette"
ITEM.uniqueID = "chillwave_cassette"
ITEM.cost = 73
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A clean looking cassette with the word 'Chillwave' written on it in black marker."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Chillwave", {
	{
		name = "CHVRCHES - Recover",
		length = 340,
		url = "https://dl.dropboxusercontent.com/s/9ttkag6qmm6j2u5/CHVRCHES%20-%20Recover%20%28Cid%20Rim%20remix%29.mp3?dl=0"
	},
	{
		name = "Mala - Ghost",
		length = 246,
		url = "https://dl.dropboxusercontent.com/s/ldjs3f98c6jnaqo/GTA%20V%20Radio%20%5BWorldwide%20FM%5D%20Mala%20-%20Ghost.mp3?dl=0"
	},
	{
		name = "Swindle - Forest Funk",
		length = 277,
		url = "https://dl.dropboxusercontent.com/s/9oj66u2j0cm5y0r/GTA%20V%20Radio%20%5BWorldwide%20FM%5D%20Swindle%20-%20Forest%20Funk.mp3?dl=0"
	},
	{
		name = "Toro Y Moi - Harm in Change",
		length = 242,
		url = "https://dl.dropboxusercontent.com/s/loaooznucd47up4/GTA%20V%20Radio%20%5BWorldwide%20FM%5D%20Toro%20Y%20Moi%20-%20Harm%20in%20Change.mp3?dl=0"
	},
	{
		name = "Yuna - Live Your Life",
		length = 270,
		url = "https://dl.dropboxusercontent.com/s/08y052b9256p5o0/GTA%20V%20Radio%20%5BWorldwide%20FM%5D%20Yuna%20-%20Live%20Your%20Life%20%28MeLo%20X%20Motherland%20GOD%20MIX%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
