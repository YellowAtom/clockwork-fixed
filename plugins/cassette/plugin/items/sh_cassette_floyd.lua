local ITEM = Clockwork.item:New()

ITEM.name = "Pink Floyd Cassette"
ITEM.uniqueID = "floyd_cassette"
ITEM.cost = 80
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A dark grey cassette with a picture of a pyramid with a rainbow going through it."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Floyd", {
	{
		name = "Money",
		length = 392,
		url = "https://dl.dropboxusercontent.com/s/2rr36nigrpnhl41/Money%20-%20Pink%20Floyd%20HD%20%28Studio%20Version%29.mp3?dl=0"
	},
	{
		name = "Time",
		length = 425,
		url = "https://dl.dropboxusercontent.com/s/r0px6pwjbclze6l/Pink%20Floyd%20-%20Time.mp3?dl=0"
	},
	{
		name = "Comfortably Numb",
		length = 414,
		url = "https://dl.dropboxusercontent.com/s/1dcfnr3stvtnfte/Pink%20Floyd%20-%20Comfortably%20numb.mp3?dl=0"
	},
	{
		name = "Dazed & Confused",
		length = 391,
		url = "https://dl.dropboxusercontent.com/s/9crz8wwb4msx18v/Led%20Zeppelin-%20Dazed%20and%20Confused.mp3?dl=0"
	},
	{
		name = "Breathe in the Air",
		length = 599,
		url = "https://dl.dropboxusercontent.com/s/mpw2q1w5dlav288/Pink%20Floyd%20-%20Breathe%20in%20the%20Air%20%28Long%20Version%29%20The%20Great%20Gig%20in%20the%20Sky.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
