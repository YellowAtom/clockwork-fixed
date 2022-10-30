local ITEM = Clockwork.item:New()

ITEM.name = "Moral Album Cassette"
ITEM.uniqueID = "Moral Album"
ITEM.cost = 65
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A White Cassette Tape with Moral scribled in with black marker on the front"
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Moral Album", {
	{
		name = "30 Seconds To Mars - Attack Lyrics",
		length = 192,
		url = "https://dl.dropboxusercontent.com/s/arzsxml6nn3r105/30%20Seconds%20To%20Mars%20-%20Attack%20Lyrics.mp3?dl=0"
	},
	{
		name = "Billy Joel - We Didn't Start the Fire",
		length = 291,
		url = "https://dl.dropboxusercontent.com/s/60ihg0u0nes2gjf/Billy%20Joel%20-%20We%20Didn%27t%20Start%20the%20Fire%20%28Audio%29.mp3?dl=0"
	},
	{
		name = "Battle Tapes - Graveyard Shift",
		length = 245,
		url = "https://dl.dropboxusercontent.com/s/wqzwakoikgjtnz9/Graveyard%20Shift.mp3?dl=0"
	},
	{
		name = "Thirty Seconds to Mars - Closer to the Edge",
		length = 286,
		url = "https://dl.dropboxusercontent.com/s/mm9u8jksoyuyveq/Thirty%20Seconds%20to%20Mars%20-%20Closer%20to%20the%20Edge%20%28Official%20Lyric%20Video%29.mp3?dl=0"
	},
	{
		name = "Thirty Seconds To Mars - Hail To The Victor",
		length = 202,
		url = "https://dl.dropboxusercontent.com/s/yu3kv6kpqjv5jdb/Thirty%20Seconds%20To%20Mars%20-%20Hail%20To%20The%20Victor%20%28Official%20Audio%29.mp3?dl=0"
	},
	{
		name = "Thirty Seconds to Mars - This is War",
		length = 329,
		url = "https://dl.dropboxusercontent.com/s/u95hwvzrfatt69f/Thirty%20Seconds%20to%20Mars%20-%20This%20is%20War%20%28Official%20Lyric%20Video%29.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
