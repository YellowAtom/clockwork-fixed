local ITEM = Clockwork.item:New()

ITEM.name = "Old Cassette"
ITEM.uniqueID = "old_cassette_war"
ITEM.cost = 75
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "v"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "This cassette appears rather old and beaten up"
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Archive of Marching", {
	{
		name = "Erika",
		length = 179,
		url = "https://dl.dropboxusercontent.com/s/v5bo0x3xfjplynp/Erika---%28Marschlied%29%20%28Hi-Fi%29.mp3?dl=0"
	},
	{
		name = "Red Army Choir: My Army",
		length = 199,
		url = "https://dl.dropboxusercontent.com/s/l6paehxn8brqeqx/Red%20Choir%20My%20Army.mp3?dl=0"
	},
	{
		name = "Red Army Choir: The Red Army Is The Strongest",
		length = 164,
		url = "https://dl.dropboxusercontent.com/s/tzh1s59h6tn8oos/Red%20Army%20Choir%20The%20Red%20Army%20Is%20the%20Strongest.mp3?dl=0"
	},
	{
		name = "Over there!",
		length = 163,
		url = "https://dl.dropboxusercontent.com/s/ht5r7bu2zovps8m/Over%20There%20-%20American%20Patriotic%20Song.mp3?dl=0"
	},
	{
		name = "Schwarzbraun ist die Haselnuss",
		length = 135,
		url = "https://dl.dropboxusercontent.com/s/hblr7g6xjuhspfd/Schwarzbraun%20ist%20die%20Haselnuss%20%20%5BGerman%20folk%20song%5D%5B%20english%20translation%5D.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
