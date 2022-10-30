local ITEM = Clockwork.item:New()

ITEM.name = "Czech Classics Cassette"
ITEM.uniqueID = "cz_classics"
ITEM.cost = 32
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "An old looking cassette that has 'České Klasiky' written on it."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Czech Classics", {
	{
		name = "Václav Neckář & UMAKART - Půlnoční",
		length = 245,
		url = "https://dl.dropboxusercontent.com/s/t9iayeri5w0bmjp/by5uvo%20%28online-audio-converter.com%29.mp3?dl=0"
	},
	{
		name = "Karel Gott - Jsou svátky",
		length = 181,
		url = "https://dl.dropboxusercontent.com/s/qy6i246q2zwexwu/bik4eb%20%28online-audio-converter.com%29.mp3?dl=0"
	},
	{
		name = "Karel Gott & Charlotte Ella Gottová - Srdce nehasnou",
		length = 274,
		url = "https://dl.dropboxusercontent.com/s/spmwl6cu7xoqtb2/r50fwq%20%28online-audio-converter.com%29.mp3?dl=0"
	},
	{
		name = "Jaromír Nohavica - Mám jizvu na rtu",
		length = 227,
		url = "https://dl.dropboxusercontent.com/s/w1zssgtvezqpqv1/6laxl7%20%28online-audio-converter.com%29.mp3?dl=0"
	},
	{
		name = "Kryštof - Cesta ft. Tomáš Klus",
		length = 353,
		url = "https://dl.dropboxusercontent.com/s/ev6023inuytmuhp/Kry%C5%A1tof%20-%20Cesta%20ft.%20Tom%C3%A1%C5%A1%20Klus.mp3?dl=0"
	},
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
