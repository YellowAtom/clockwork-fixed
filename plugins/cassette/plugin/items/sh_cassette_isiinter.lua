local ITEM = Clockwork.item:New()

ITEM.name = "Isi's Intermission Cassette"
ITEM.uniqueID = "isi_cassette"
ITEM.cost = 66
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A label on the back with fairly neat handwriting reads 'Made by: William Isidora. For atmospheric pleasure!'"
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Isi's Intermission", {
	{
		name = "Plastic Love",
		length = 476,
		url = "https://dl.dropboxusercontent.com/s/usfxzkj9hoqwpkr/Mariya%20Takeuchi%20Plastic%20Love%20%E7%AB%B9%E5%86%85%20%E3%81%BE%E3%82%8A%E3%82%84.mp3?dl=0"
	},
	{
		name = "Fly Me to the Moon",
		length = 270,
		url = "https://dl.dropboxusercontent.com/s/b6g0sp4r4784wip/02%20-.mp3?dl=0"
	},
	{
		name = "Crockett's Theme",
		length = 352,
		url = "https://dl.dropboxusercontent.com/s/iljiq8r7x4wwxf6/Jan%20Hammer%20-%20Crockett%27s%20Theme%20%28Miami%20Vice%29.mp3?dl=0"
	},
	{
		name = "Jump Up, Super Star!",
		length = 250,
		url = "https://dl.dropboxusercontent.com/s/rc7d8a134omm71n/Super%20Mario%20Odyssey%20-%20Jump%20Up%2C%20Super%20Star%21.mp3?dl=0"
	},
	{
		name = "Telephone Number",
		length = 238,
		url = "https://dl.dropboxusercontent.com/s/xaihtc4o4wc11uz/Junko%20Ohashi%20-%20Telephone%20Number%20%281984%29.mp3?dl=0"
	},
	{
		name = "Midnight Pretenders",
		length = 345,
		url = "https://dl.dropboxusercontent.com/s/ttw8b40aku5lg3l/%E4%BA%9C%E8%98%AD%E7%9F%A5%E5%AD%90%E3%80%80%E6%B5%AE%E9%81%8A%E7%A9%BA%E9%96%93%E3%80%80Midnight%20Pretenders.mp3?dl=0"
	},
	{
		name = "Song for Lobsters",
		length = 288,
		url = "https://dl.dropboxusercontent.com/s/n89cy5dfib0hh8x/somebody%20that%20i%20used%20to%20know%20-%20%EF%BC%A4%EF%BD%8F%EF%BD%8F%EF%BD%8D%EF%BD%85%EF%BD%92%20%EF%BC%B7%EF%BD%81%EF%BD%96%EF%BD%85.mp3?dl=0"
	},
	{
		name = "Sanctuary",
		length = 179,
		url = "https://dl.dropboxusercontent.com/s/czci5er3orivl9s/Joji%20-%20Sanctuary%20%28Lyrics%29.mp3?dl=0"
	},
	{
		name = "Rain",
		length = 190,
		url = "https://dl.dropboxusercontent.com/s/ssz6viis8bmy3fc/Halo%203%20ODST%20Original%20Soundtrack%20-%2004%20Rain%20%28Deference%20for%20Darkness%29.mp3?dl=0"
	},
	{
		name = "One's Word",
		length = 107,
		url = "https://dl.dropboxusercontent.com/s/dj5zfhymftmg4c2/DARLING%20in%20the%20FRANXX%20OST%20-%20One%27s%20Word.mp3?dl=0"
	},
	{
		name = "Ignorant Hero",
		length = 257,
		url = "https://dl.dropboxusercontent.com/s/4n1w48e1jwa1xc1/Bloodborne%20DLC%20OST%20-%20Ludwig%2C%20the%20Holy%20Blade.mp3?dl=0"
	},
	{
		name = "Great Days",
		length = 240,
		url = "https://dl.dropboxusercontent.com/s/lax90kte0u5vvpw/Great%20Days%20UNITS%20ver..mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
