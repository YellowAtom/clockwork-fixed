local ITEM = Clockwork.item:New()

ITEM.name = "Витас - Философия чуда Cassette"
ITEM.uniqueID = "vitas_miracle"
ITEM.cost = 70
ITEM.model = "models/ug_imports/cassette/casette.mdl"
ITEM.weight = .05
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Music"
ITEM.business = true
ITEM.description = "A metallic looking cassette. Has Russian wording written on it in yellow marker, an English translation seems to be provided undeneath - 'Vitas - The Philosophy of Miracle'."
ITEM.isCassette = true

ITEM.key = t_cassette.Register("Витас - Философия чуда", {
	{
		name = "Мечты",
		length = 287,
		url = "https://dl.dropboxusercontent.com/s/ok568s03bbv21jh/%D0%92%D0%B8%D1%82%D0%B0%D1%81%20-%20%20%D0%9C%D0%B5%D1%87%D1%82%D1%8B.mp3?dl=0"
	},
	{
		name = "7 элемент",
		length = 248,
		url = "https://dl.dropboxusercontent.com/s/yo0twzv1cjjgjbh/Vitas%20%20%207th%20Element%202002.mp3?dl=0"
	},
	{
		name = "Опера #2",
		length = 230,
		url = "https://dl.dropboxusercontent.com/s/2vin00e3ykfbpgm/Vitas%20opera%202%20lyrics%20%28OFFICIAL%29.mp3?dl=0"
	},
	{
		name = "Прелюдия",
		length = 328,
		url = "https://dl.dropboxusercontent.com/s/gqmlla4qr68yyky/%D0%9F%D1%80%D0%B5%D0%BB%D1%8E%D0%B4%D0%B8%D1%8F.mp3?dl=0"
	},
	{
		name = "Карлсон",
		length = 244,
		url = "https://dl.dropboxusercontent.com/s/ddprw8w0jcr1r0m/%D0%94%D0%B5%D0%BD%D1%8C%20%D1%80%D0%BE%D0%B6%D0%B4%D0%B5%D0%BD%D0%B8%D1%8F%20%D0%BC%D0%BE%D0%B5%D0%B9%20%D1%81%D0%BC%D0%B5%D1%80%D1%82%D0%B8.mp3?dl=0/s/ktuamkr8zv5xp7h/Vitas%20%20%20Vitas%20%20%20Karlsson%20Karlson.mp3?dl=0"
	},
	{
		name = "День рождения моей смерти",
		length = 311,
		url = "https://dl.dropboxusercontent.com/s/ddprw8w0jcr1r0m/%D0%94%D0%B5%D0%BD%D1%8C%20%D1%80%D0%BE%D0%B6%D0%B4%D0%B5%D0%BD%D0%B8%D1%8F%20%D0%BC%D0%BE%D0%B5%D0%B9%20%D1%81%D0%BC%D0%B5%D1%80%D1%82%D0%B8.mp3?dl=0"
	},
	{
		name = "Душа",
		length = 324,
		url = "https://dl.dropboxusercontent.com/s/oy5rl92gfwvc98c/Vitas%20-%20Soul.mp3?dl=0"
	},
	{
		name = "Тело",
		length = 246,
		url = "https://dl.dropboxusercontent.com/s/vr2tbpi6wi4k80a/%D0%A2%D0%B5%D0%BB%D0%BE.mp3?dl=0"
	},
	{
		name = "Старый граммофон",
		length = 164,
		url = "https://dl.dropboxusercontent.com/s/486k5igpjhxn9er/Vitas%20%20%20Vitas%20I%20%20%20An%20old%20gramophone%20Staryj%20grammofon.mp3?dl=0"
	},
	{
		name = "Цирк",
		length = 358,
		url = "https://dl.dropboxusercontent.com/s/abmweil27jajhqm/%D0%A6%D0%B8%D1%80%D0%BA.mp3?dl=0"
	}
})

function ITEM:OnDrop(player, position)
end

ITEM:Register()
