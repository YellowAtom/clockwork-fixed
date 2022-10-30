local ITEM = Clockwork.item:New()

ITEM.name = "Make Believe Cassette"
ITEM.uniqueID = "make_believe_cassette"
ITEM.cost = 20
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A casette with a pinkish tint to it. It's loaded with six songs."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Make Believe", {
	{
		name = "Not A Crime To Smile",
		length = 176,
		url = "https://dl.dropboxusercontent.com/s/244m7xlkn3ekd9i/Not%20A%20Crime%20To%20Smile.mp3?dl=0"
	},
	{
		name = "Cheer Up",
		length = 188,
		url = "https://dl.dropboxusercontent.com/s/ouj36uqwzaoa6gk/Cheer%20Up.mp3?dl=0"
	},
	{
		name = "La La La",
		length = 125,
		url = "https://dl.dropboxusercontent.com/s/t9b4swfeg8zbj0t/La%20La%20La.mp3?dl=0"
	},
	{
		name = "Dead Of Winter",
		length = 213,
		url = "https://dl.dropboxusercontent.com/s/doc9zfic3wor2b8/Dead%20Of%20Winter.mp3?dl=0"
	},
	{
		name = "You’ll Never Change My Mind",
		length = 232,
		url = "https://dl.dropboxusercontent.com/s/zdugzaofjbdh2o8/When%20Youre%20Gone.mp3?dl=0"
	},
	{
		name = "When You’re Gone",
		length = 225,
		url = "https://dl.dropboxusercontent.com/s/jblbp3j9md9xy4s/Youll%20Never%20Change%20My%20Mind.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()