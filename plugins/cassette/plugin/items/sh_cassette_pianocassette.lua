ITEM = Clockwork.item:New()

ITEM.name = "Piano Performances Cassette"
ITEM.uniqueID = "piano_cassette"
ITEM.cost = 60
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A well kept casette with a picture of a Grand Piano in golden colors and a white marker that says 'Best of Piano, vol. 1'."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Piano Performances", {
	{
		name = "Beethoven - Ode to Joy",
		length = 246,
		url = "https://dl.dropboxusercontent.com/s/lgix5r0qpl7fhwq/Beethoven%20Freude%20Sch%C3%B6ner%20G%C3%B6tterfunken%20Piano.mp3?dl=0"
	},
	{
		name = "Mozart - Rondo Alla Turca",
		length = 211,
		url = "https://dl.dropboxusercontent.com/s/lw7r5fcdlunm2yy/Mozart%20-%20Rondo%20Alla%20Turca%20%28Turkish%20March%29.mp3?dl=0"
	},
	{
		name = "Chopin - Nocturne",
		length = 296,
		url = "https://dl.dropboxusercontent.com/s/97jd9i3irmjdgfg/Chopin%20-%20Nocturne%20in%20E%20Flat%20Major%20%28Op.%209%20No.%202%29.mp3?dl=0"
	},
	{
		name = "Yiruma - River Flows In You",
		length = 215,
		url = "https://dl.dropboxusercontent.com/s/pjrrt9gi9qfej2b/Yiruma%20-%20River%20Flows%20in%20You.mp3?dl=0"
	},
	{
		name = "Liszt - La Campanella",
		length = 317,
		url = "https://dl.dropboxusercontent.com/s/dy5gx9yonf3cfc6/Liszt%20-%20La%20Campanella%20%28100%2C000%20special%29.mp3?dl=0"
	},
	{
		name = "Chopin - Ballade No. 1",
		length = 586,
		url = "https://dl.dropboxusercontent.com/s/38q73w5wy3e2mva/Chopin%20-%20Ballade%20No.%201%20in%20G%20Minor%20%281M%20special%29.mp3?dl=0"
	},
	{
		name = "Debussy - Clair de Lune",
		length = 313,
		url = "https://dl.dropboxusercontent.com/s/gncuvgstpybnj12/Debussy%20-%20Clair%20de%20Lune.mp3?dl=0"
	},
	{
		name = "Beethoven - Moonlight Sonata 1st. Movement",
		length = 444,
		url = "https://dl.dropboxusercontent.com/s/vej8o4sfnphvjbu/Beethoven%20-%20Moonlight%20Sonata%20%281st%20Movement%29.mp3?dl=0"
	},
	{
		name = "Beethoven - Moonlight Sonata 3rd. Movement",
		length = 454,
		url = "https://dl.dropboxusercontent.com/s/z9hczlhq8q21rix/Beethoven%20-%20Moonlight%20Sonata%20%283rd%20Movement%29.mp3?dl=0"
	},
	{
		name = "Liszt - Un Sospiro",
		length = 351,
		url = "https://dl.dropboxusercontent.com/s/qdnurfduwg8yksu/Liszt%20-%20Un%20Sospiro.mp3?dl=0"
	},
	{
		name = "Yiruma - Kiss The Rain",
		length = 319,
		url = "https://dl.dropboxusercontent.com/s/4joifyhft08m5fc/Yiruma%20-%20Kiss%20The%20Rain.mp3?dl=0"
	},
	{
		name = "Richard Clayderman - Ballade Pour Adeline",
		length = 190,
		url = "https://dl.dropboxusercontent.com/s/c77tsgxqp5fxi8k/Richard%20Clayderman%20-%20Ballade%20Pour%20Adeline.mp3?dl=0"
	},
	{
		name = "Paul de Senneville - Mariage d'Amour",
		length = 319,
		url = "https://dl.dropboxusercontent.com/s/70fjl81i8wvxwkt/Mariage%20d%27Amour.mp3?dl=0"
	},
	{
		name = "Anastasia - Once Upon A December",
		length = 190,
		url = "https://dl.dropboxusercontent.com/s/6n9ez7pzekxonow/Anastasia%20-%20Once%20Upon%20A%20December%20for%20Piano.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
