local ITEM = Clockwork.item:New()

ITEM.name = "R&B Cassette"
ITEM.uniqueID = "r&b_cassette"
ITEM.cost = 88
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A dark grey cassette with the word 'R&B Hits' written on it in black marker."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("R&B", {
	{
		name = "Omar - There's Nothing Like This",
		length = 240,
		url = "https://dl.dropboxusercontent.com/s/00z3yeemo7adhai/Omar%20-%20There%27s%20Nothing%20Like%20This.mp3?dl=0"
	},
	{
		name = "R. Kelly - Bump and Grind",
		length = 256,
		url = "https://dl.dropboxusercontent.com/s/ilf9lwr4q9u3wg1/R.%20Kelly%20-%20Bump%20and%20Grind.mp3?dl=0"
	},
	{
		name = "Raheem DeVaughn - You",
		length = 301,
		url = "https://dl.dropboxusercontent.com/s/xvsgapj4tdxg20y/Raheem%20DeVaughn%20-%20%20You.mp3?dl=0"
	},
	{
		name = "Barry White - It's Only Love Doing Its Thing",
		length = 302,
		url = "https://dl.dropboxusercontent.com/s/ji3zjsy6wxem3s4/Barry%20White%20-%20It%27s%20Only%20Love%20Doing%20It%27s%20Thing.mp3?dl=0"
	},
	{
		name = "Ginuwine - Pony",
		length = 201,
		url = "https://dl.dropboxusercontent.com/s/8z42fpz4dk9e49p/GTA%20IV%20The%20Vibe%2098.8%20Full%20Soundtrack%2018.%20Ginuwine%20-%20Pony.mp3?dl=0"
	},
	{
		name = "Alexander O'Neal - Criticize",
		length = 243,
		url = "https://dl.dropboxusercontent.com/s/dquy2wb3g2h0onx/Alexander%20O%27Neal%20-%20Criticize%20%5BHQ%5D.mp3?dl=0"
	},
	{
		name = "Jill Scott - Golden",
		length = 236,
		url = "https://dl.dropboxusercontent.com/s/ll2keym1hj4q2fx/Jill%20Scott%20-%20Golden.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
