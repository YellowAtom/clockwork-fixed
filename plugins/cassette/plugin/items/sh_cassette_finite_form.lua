local ITEM = Clockwork.item:New()

ITEM.name = "Jack Stauber - Finite Form Cassette"
ITEM.uniqueID = "finite_form_cassette"
ITEM.cost = 120
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A cream coloured cassette. A male with a long beard is printed on it."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Jack Stauber - Finite Form", {
	{
		name = "Smooth",
		length = 197,
		url = "https://dl.dropboxusercontent.com/s/wc8e9z4o8eatl99/Smooth.mp3?dl=0"
	},
	{
		name = "Windrag",
		length = 239,
		url = "https://dl.dropboxusercontent.com/s/ukx5eldjojw7hq6/Windrag.mp3?dl=0"
	},
	{
		name = "Runaway",
		length = 289,
		url = "https://dl.dropboxusercontent.com/s/o1h2qfi1jnn32uu/Runaway.mp3?dl=0"
	},
	{
		name = "Mindsight",
		length = 114,
		url = "https://dl.dropboxusercontent.com/s/dimmdwliergy8yf/Mindsight.mp3?dl=0"
	},
	{
		name = "Ms. Led",
		length = 305,
		url = "https://dl.dropboxusercontent.com/s/fvnu8lt00puuxqz/Ms.%20Led.mp3?dl=0"
	},
	{
		name = "Trust Flower",
		length = 138,
		url = "https://dl.dropboxusercontent.com/s/0pqbbfaowhxv1xm/Trust%20Flower.mp3?dl=0"
	},
	{
		name = "The Diverge",
		length = 181,
		url = "https://dl.dropboxusercontent.com/s/msdvkkmb0hvnb5x/The%20Diverge.mp3?dl=0"
	},
	{
		name = "Curl",
		length = 197,
		url = "https://dl.dropboxusercontent.com/s/40ksjin66zu3z24/Curl.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
