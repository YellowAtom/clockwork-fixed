local ITEM = Clockwork.item:New()

ITEM.name = "Experimental Cassette Vol. 1 Cassette"
ITEM.uniqueID = "cassette_exp"
ITEM.cost = 25
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A matte black cassette with an orange stripe. It has a label on it, saying 'Experimental' as well as the small Universal Union insignia on it. It sounds oddly familiar and nostalgic."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Experimental Cassette Vol. 1", {
	{
		name = "Amon Tobin - Bridge",
		length = 356,
		url = "https://dl.dropboxusercontent.com/s/chkyhhc0cuy72zc/Amon%20Tobin%20-%20Bridge.mp3?dl=0"
	},
	{
		name = "Amon Tobin - Reanimator",
		length = 394,
		url = "https://dl.dropboxusercontent.com/s/kqkorg135ecrm3v/Amon%20Tobin%20-%20Reanimator.mp3?dl=0"
	},
	{
		name = "Aphex Twin - Hedphelym",
		length = 363,
		url = "https://dl.dropboxusercontent.com/s/ofpf1ytgjhuu6lh/Aphex%20Twin%20-%20Hedphelym.mp3?dl=0"
	},
	{
		name = "Aphex Twin - Xtal",
		length = 293,
		url = "https://dl.dropboxusercontent.com/s/1oq4k1vperr06lm/Aphex%20Twin%20-%20Xtal.mp3?dl=0"
	},
	{
		name = "Home - Resonance",
		length = 212,
		url = "https://dl.dropboxusercontent.com/s/oaiiw5onsjfq5mi/Home%20-%20Resonance.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
