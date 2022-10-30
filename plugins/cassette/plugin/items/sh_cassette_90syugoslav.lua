local ITEM = Clockwork.item:New()

ITEM.name = "90's Yugoslav Cassette"
ITEM.uniqueID = "yugoslav_songs"
ITEM.cost = 12
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A very worn down cassette from the looks of things. It has the UN logo sticker on it."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("90's Yugoslav Songs", {
	{
		name = "Miro Semberac - Jadna Bosno Suverena",
		length = 137,
		url = "https://dl.dropboxusercontent.com/s/t0pja1ctksaq7y3/Miro%20Semberac%20-%20Jadna%20Bosno%20Suverena.mp3?dl=0"
	},
	{
		name = "Mišo Bojič - Hvala Ti Arkane",
		length = 209,
		url = "https://dl.dropboxusercontent.com/s/qw6811dlhqy0uad/Mi%C5%A1o%20Boji%C4%8D%20-%20Hvala%20Ti%20Arkane.mp3?dl=0"
	},
	{
		name = "Roki Vulovic - Gavrina Brigada",
		length = 262,
		url = "https://dl.dropboxusercontent.com/s/4jxqugp90nqzguo/Roki%20Vulovic%20-%20Gavrina%20brigada.mp3?dl=0"
	},
	{
		name = "Roki Vulovic - Panteri",
		length = 356,
		url = "https://dl.dropboxusercontent.com/s/wm8fnvpwgujw31c/Roki%20Vulovic%20-%20Panteri.mp3?dl=0"
	},
	{
		name = "Serbia Strong",
		length = 218,
		url = "https://dl.dropboxusercontent.com/s/tatrkhimfc6r79d/Serbia%20Strong.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
