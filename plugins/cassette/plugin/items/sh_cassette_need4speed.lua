local ITEM = Clockwork.item:New()

ITEM.name = "Black Box Cassette"
ITEM.uniqueID = "bbcassette"
ITEM.cost = 65
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A cassette. 'The Black Box' has been scribbled on in black marker. A bit of a dumb name, since the 'o' cube in 'Box' is orange."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Name Here", {
	{
		name = "Keep It Coming",
		length = 250,
		url = "https://dl.dropboxusercontent.com/s/ecp7vq98sav10u4/natekeepit.mp4?dl=0"
	},
	{
		name = "Hard Drivers",
		length = 193,
		url = "https://dl.dropboxusercontent.com/s/kee1v1ihgk73w2b/ekstrakhard.webm?dl=0"
	},
	{
		name = "Smashing the Gas",
		length = 184,
		url = "https://dl.dropboxusercontent.com/s/b312m6z77m889j4/mystikalgas.mp4?dl=0"
	},
	{
		name = "Switch/Twitch",
		length = 547,
		url = "https://dl.dropboxusercontent.com/s/kmjjp82l2uluzy1/flukeswtw.mp4?dl=0"
	},
	{
		name = "Fired Up",
		length = 195,
		url = "https://dl.dropboxusercontent.com/s/f09m3i7d052fb9j/firedup.mp4?dl=0"
	},
	{
		name = "Bounce",
		length = 204,
		url = "https://dl.dropboxusercontent.com/s/k8kkun3pztejhcz/dynaMCbounce.webm?dl=0"
	},
	{
		name = "After Party",
		length = 181,
		url = "https://dl.dropboxusercontent.com/s/ty3sqzfihf73vqc/dynaMCafparty.mp4?dl=0"
	},
	{
		name = "Shapeshifter",
		length = 199,
		url = "https://dl.dropboxusercontent.com/s/wtg8wen1jncytjk/celldwellshapeshift.mp4?dl=0"
	},
	{
		name = "Kimosabe",
		length = 320,
		url = "https://dl.dropboxusercontent.com/s/fqh2jsq5z6kn8kl/btkimosabe.mp4?dl=0"
	},
	{
		name = "Let's Move",
		length = 180,
		url = "https://dl.dropboxusercontent.com/s/7u4wo4rjkxie3uk/perceptionletsmove.mp4?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
