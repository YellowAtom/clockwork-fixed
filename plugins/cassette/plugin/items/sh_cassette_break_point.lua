local ITEM = Clockwork.item:New()

ITEM.name = "Break Point Cassette"
ITEM.uniqueID = "breakpoint_cassette"
ITEM.cost = 19
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "The front of the cassette depicts a man in a mask diving sideways, as he shoots with two pistols towards the observer."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Break Point Album", {
	{
		name = "Battle Tapes - Valkyrie",
		length = 220,
		url = "https://dl.dropboxusercontent.com/s/jl7c0m4jxzkcwft/Battle%20Tapes%20-%20Valkyrie.mp3?dl=0"
	},
	{
		name = "Alex Metric - It Starts",
		length = 198,
		url = "https://dl.dropboxusercontent.com/s/c7aqu0celkt1x09/Alex%20Metric%20-%20It%20Starts.mp3?dl=0"
	},
	{
		name = "Battle Tapes - Belgrade",
		length = 293,
		url = "https://dl.dropboxusercontent.com/s/mxklcqo3kd0nwbb/belgrade.mp3?dl=0"
	},
	{
		name = "H-Blockx - Gazoline",
		length = 191,
		url = "https://dl.dropboxusercontent.com/s/9ya3wz126h8dvsc/H-Blockx%20-%20Gazoline.mp3?dl=0"
	},
	{
		name = "Le Castle Vania Red Circle",
		length = 233,
		url = "https://dl.dropboxusercontent.com/s/njgb83btv45op0v/Le%20Castle%20Vania%20Red%20Circle%20%28LED%20Spirals%20%26amp%3B%20Shots%20Fired%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
