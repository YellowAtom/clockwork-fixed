local ITEM = Clockwork.item:New()

ITEM.name = "Moomin Cassette"
ITEM.uniqueID = "moomin_cassette"
ITEM.cost = 42
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A well kept casette with a crude picture of Moomin drawn on it with a blue marker."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Moomin", {
	{
		name = "Sanpo",
		length = 73,
		url = "https://dl.dropboxusercontent.com/s/meb6y74me4trgad/Sanpo.mp3?dl=0"
	},
	{
		name = "Lady Of The Cold",
		length = 154,
		url = "https://dl.dropboxusercontent.com/s/f178w5u0m2sk5f6/Tanoshii%20Moomin%20Ikka%20-%20Song%20of%20Lady%20of%20the%20Cold.mp3?dl=0"
	},
	{
		name = "Snufkin The Traveler",
		length = 397,
		url = "https://dl.dropboxusercontent.com/s/lcmroitinoq7d5y/Music%20I%20adore%20%23300%21%20Snufkin%20The%20Traveler%20%28Sumio%20Shiratori%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
