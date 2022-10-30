local ITEM = Clockwork.item:New()

ITEM.name = "DnB Tape Cassette"
ITEM.uniqueID = "dnb_tape"
ITEM.cost = 58
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "v"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A dusty, red tape labelled 'Drum and Bass'."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("DnB Tape", {
	{
		name = "Hold Your Colour",
		length = 451,
		url = "https://d.dropboxusercontent.com/s/tjbha9qmg34gg7x/pendulum%20hold%20your%20colour-qtD1IpH5a5Q.mp3?dl=0"
	},
	{
		name = "Still Grey",
		length = 465,
		url = "https://dl.dropboxusercontent.com/s/kn8h461x4qmkmnv/Pendulum%20-%20Still%20Grey.mp3?dl=0"
	},
	{
		name = "Nervenkitzel",
		length = 171,
		url = "https://dl.dropboxusercontent.com/s/te12ye7azi12brk/PHACE%20%26%20MEFJUS%20-%20NERVENKITZEL%20%5BLINKED%2001%5D-5uA2otwnFeI.mp3?dl=0"
	},
	{
		name = "Immunize",
		length = 276,
		url = "https://dl.dropboxusercontent.com/s/06n95l1dhxa8kc6/Pendulum%20-%20Immunize%20%5BHD%20-%20320kbps%5D-t_kM1yEcDxA.mp3?dl=0"
	},
	{
		name = "Blitz",
		length = 257,
		url = "https://dl.dropboxusercontent.com/s/u7kruk7hmpd7t5v/Mefjus%20-%20Blitz-rYnhrIDMXRU.mp3?dl=0"
	},
	{
		name = "Slam",
		length = 341,
		url = "https://dl.dropboxusercontent.com/s/b8j587lfw6trgnh/Pendulum%20-%20Slam%20%5BHD%20-%20320kbps%5D-Q89OdbX7A8E.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
