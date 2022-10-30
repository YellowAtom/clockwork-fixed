local ITEM = Clockwork.item:New()

ITEM.name = "Hardrock Cassette"
ITEM.uniqueID = "hardrock_cassette"
ITEM.cost = 17
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = false
ITEM.description = "Rather a clean cassette, appearing duplicated once or twice, having a paper piece sticked on it with text written: Hardrock Cassette"
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Hardrock Cassette", {
	{
		name = "Criminal - New Disorder",
		length = 225,
		url = "https://dl.dropboxusercontent.com/s/w1ngmh80t5u32fk/Criminal%20-%20New%20Disorder.mp3?dl=0"
	},
	{
		name = "Helmet - Repetition",
		length = 185,
		url = "https://dl.dropboxusercontent.com/s/rrcsqpi3weqlkp5/Helmet%20-%20Repetition.mp3?dl=0"
	},
	{
		name = "Judas Priest - Painkiller",
		length = 375,
		url = "https://dl.dropboxusercontent.com/s/s71o78bh1t53o6n/Judas%20Priest%20-%20Painkiller.mp3?dl=0"
	},
	{
		name = "Keel - Speed Demon",
		length = 225,
		url = "https://dl.dropboxusercontent.com/s/7lbxrsrgdh7zxlr/Keel%20-%20Speed%20Demon%20%281%29.mp3?dl=0"
	},
	{
		name = "Disturbed - Ten Thousand Fists",
		length = 225,
		url = "https://dl.dropboxusercontent.com/s/2fecmmgk3yf1b69/Disturbed%20-%20Ten%20Thousand%20Fists.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
